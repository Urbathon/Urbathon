//
//  HomeViewController.swift
//  Urbatone
//
//  Created by Artsiom Sazonau on 23.11.23.
//

import UIKit

class HomeViewController: BaseViewController, UICollectionViewDelegate {
    
    enum Section: Hashable, CaseIterable {
        case requests
        case tags
        case news
        case faq
    }
    
    struct Item: Hashable {
        var id: Int
        var image: UIImage?
        var title: String
        var subTitle: String?
        var description: String?
        var date: Date?
        var tag: String?
    }
    let images: [UIImage] = {
        (0...4).map(String.init).map(UIImage.init)
    }()
    
    let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "dd-MM-yyyy"
        return df
    }()
    
    var requests: [Item] {
        tabBarViewController.requestsModel.requests.map {
            .init(id: $0.id,
                  title: $0.status == "new" ? "Новый": "Выполнено",
                  subTitle: $0.categoryProblem,
                  description: $0.description,
                  date: Date(timeIntervalSince1970: TimeInterval($0.dateCreate)))
        }
    }
    
    var newsItems: [Item] {
        tabBarViewController.newsModel.news.map {
            .init(id: $0.id,
                  image: images.randomElement(),
                  title: $0.title,
                  subTitle: "",
                  description: $0.description,
                  date: $0.datePost,
                  tag: $0.tags.first)
        }
    }
    
    let faqItems: [Item] = {
        [.init(id: Int.random(in: 0...10000),
               title: "Чат горячей линии"),
         .init(id: Int.random(in: 0...10000),
                title: "Тарифы"),
         .init(id: Int.random(in: 0...10000),
                title: "Полезные контакты"),
         .init(id: Int.random(in: 0...10000),
                title: "Что-нибудь еще"),
        ]
    }()
    
    lazy var collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: getCollectionViewLayout())
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let label = UILabel()
        label.text = "Иванов Иван"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .white
        navigationItem.leftBarButtonItem = .init(customView: label)
        navigationItem.rightBarButtonItems = [.init(image: UIImage(systemName: "person")?.withTintColor(.white, renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(profileTapped)),
                                              .init(image: UIImage(systemName: "bell")?.withTintColor(.white, renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(bellTapped)),
                                              .init(image: UIImage(systemName: "plus.circle")?.withTintColor(.white, renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(plusTapped))]
//        TODO: bell.badge
        view.addSubview(collectionView)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        collectionView.delegate = self
        // Do any additional setup after loading the view.
        collectionView.register(TagCollectionViewCell.self, forCellWithReuseIdentifier: TagCollectionViewCell.id)
        collectionView.register(NewsCollectionViewCell.self, forCellWithReuseIdentifier: NewsCollectionViewCell.id)
        collectionView.register(UINib(nibName: RequestCollectionViewCell.id, bundle: nil), forCellWithReuseIdentifier: RequestCollectionViewCell.id)
        collectionView.register(FAQCollectionViewCell.self, forCellWithReuseIdentifier: FAQCollectionViewCell.id)
        collectionView.register(UINib(nibName: HeaderCollectionReusableView.id, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.id)
        collectionView.register(FooterCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: FooterCollectionReusableView.id)
        collectionView.register(EmptyCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: EmptyCollectionReusableView.id)
        collectionView.register(EmptyCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: EmptyCollectionReusableView.id)
        
        
        makeDataSource()
        
        updateCollectionView()
    }
    
    func makeDataSource() {
        let newsCellRegistration = UICollectionView.CellRegistration<NewsCollectionViewCell, Item> { cell, indexPath, item in
            cell.imageView.image = item.image
            cell.titleLabel.text = item.title
            cell.tagLabel.text = item.tag
        }
        
        let faqCellRegistration = UICollectionView.CellRegistration<FAQCollectionViewCell, Item> { cell, indexPath, item in
            cell.titleLabel.text = item.title
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView) { (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: Item) -> UICollectionViewCell? in
            switch indexPath.section {
            case 0:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RequestCollectionViewCell.id, for: indexPath) as! RequestCollectionViewCell
                cell.statusLabel.text = itemIdentifier.title
                cell.statusLabel.textColor = UIColor(resource: .blue)
                cell.dateLabel.text = self.dateFormatter.string(from: itemIdentifier.date!)
                cell.titleLabel.text = itemIdentifier.subTitle
                cell.desctiptionLabel.text = itemIdentifier.description
                return cell
            case 1: break
            case 2: 
                return collectionView.dequeueConfiguredReusableCell(using: newsCellRegistration, for: indexPath, item: itemIdentifier)
            case 3:
                return collectionView.dequeueConfiguredReusableCell(using: faqCellRegistration, for: indexPath, item: itemIdentifier)
            default: break
            }
            return UICollectionViewCell()
        }
        dataSource?.supplementaryViewProvider = { collectionView, elementKind, indexPath -> UICollectionReusableView? in
            switch indexPath.section {
            case 0: 
                
                if elementKind == UICollectionView.elementKindSectionHeader {
                    let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.id, for: indexPath) as? HeaderCollectionReusableView
                    view?.titleLabel.text = "Ваши запросы"
                    view?.subTitleLabel.text = "Все:"
                    view?.valueLabel.text = "6"
                    return view
                } else {
                    let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: FooterCollectionReusableView.id, for: indexPath) as? FooterCollectionReusableView
                    return view
                }
//            case 1: return nil
            case 2:
                if elementKind == UICollectionView.elementKindSectionHeader {
                    let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.id, for: indexPath) as? HeaderCollectionReusableView
                    view?.titleLabel.text = "Новости"
                    view?.subTitleLabel.text = "Все:"
                    view?.valueLabel.text = "12"
                    return view
                } else {
                    let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: FooterCollectionReusableView.id, for: indexPath) as? FooterCollectionReusableView
                    return view
                }
            case 3:
                if elementKind == UICollectionView.elementKindSectionHeader {
                    let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.id, for: indexPath) as? HeaderCollectionReusableView
                    view?.titleLabel.text = "Часто используемый услуги"
                    view?.subTitleLabel.isHidden = true
                    view?.valueLabel.isHidden = true
                    return view
                } else {
                    fallthrough
                }
            default:
                let view = collectionView.dequeueReusableSupplementaryView(ofKind: elementKind, withReuseIdentifier: EmptyCollectionReusableView.id, for: indexPath)
                return view
            }
        }
    }
    
    func updateCollectionView() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(requests, toSection: .requests)
        snapshot.appendItems(newsItems, toSection: .news)
        snapshot.appendItems(faqItems, toSection: .faq)
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    func getCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { sect, env in
            switch sect {
            case 3:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(44))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = .init(top: 4, leading: 16, bottom: 4, trailing: 16)
                section.boundarySupplementaryItems = self.getSectionFooterAndHeader(section: sect)
                return section
            default:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.75), heightDimension: .fractionalHeight(0.3))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                group.interItemSpacing = .fixed(16)
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets = .init(top: 4, leading: 16, bottom: 4, trailing: 16)
                section.interGroupSpacing = 16
                section.boundarySupplementaryItems = self.getSectionFooterAndHeader(section: sect)
                return section
            }
        }
    }
    
    func getSectionFooterAndHeader(section: Int) -> [NSCollectionLayoutBoundarySupplementaryItem] {
        var headerSize: NSCollectionLayoutSize
        var footerSize: NSCollectionLayoutSize
        switch section {
        case 0: fallthrough
        case 2:
            headerSize = .init(widthDimension: .fractionalWidth(1),
                               heightDimension: .estimated(44))
            footerSize = .init(widthDimension: .fractionalWidth(1),
                               heightDimension: .estimated(44))
        case 3:
            headerSize = .init(widthDimension: .fractionalWidth(1),
                               heightDimension: .estimated(20))
            footerSize = .init(widthDimension: .fractionalWidth(0),
                               heightDimension: .fractionalHeight(0))
        default:
            headerSize = .init(widthDimension: .fractionalWidth(0),
                               heightDimension: .fractionalWidth(0))
            footerSize = .init(widthDimension: .fractionalWidth(0),
                               heightDimension: .fractionalHeight(0))
        }
            
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                        elementKind: UICollectionView.elementKindSectionHeader,
                                                                        alignment: .topLeading)
        let sectionFooter = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerSize,
                                                                        elementKind: UICollectionView.elementKindSectionFooter,
                                                                        alignment: .bottom)
        return [sectionHeader, sectionFooter]
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        switch indexPath.section {
        case 0:
            let request = getRequestBy(indexPath)
        case 2:
            let news = getNewsBy(indexPath)
            let vc = NewsViewController(nibName: "NewsViewController", bundle: nil)
            vc.news = news
            navigationController?.pushViewController(vc, animated: true)
        default: break
        }
    }
    
    func getRequestBy(_ indexPath: IndexPath) -> UserRequest {
        let item = requests[indexPath.row]
        return tabBarViewController.requestsModel.requests.first(where: {$0.id == item.id})!
    }
    
    func getNewsBy(_ indexPath: IndexPath) -> News {
        let item = newsItems[indexPath.row]
        return tabBarViewController.newsModel.news.first(where: {$0.id == item.id})!
    }
    
    @objc func profileTapped() {
        tabBarViewController.selectedIndex = 3
    }
    
    @objc func bellTapped() {
        tabBarViewController.selectedIndex = 2
    }
    
    @objc func plusTapped() {
        let vc = CreateRequestViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

    override func reload() {
        hideLoadingScreen()
        updateCollectionView()
    }

}

