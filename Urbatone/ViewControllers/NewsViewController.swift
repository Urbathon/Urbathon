//
//  NewsViewController.swift
//  Urbatone
//
//  Created by Artsiom Sazonau on 26.11.23.
//

import UIKit

class NewsViewController: UIViewController {
    
    var news: News!
    
    @IBOutlet weak var tag1View: UIView!
    @IBOutlet weak var tag1Label: UILabel!
    @IBOutlet weak var tag2View: UIView!
    @IBOutlet weak var tag2Label: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var textLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        navigationItem.backBarButtonItem?.image = navigationItem.backBarButtonItem?.image?.withTintColor(.white, renderingMode: .alwaysOriginal)
        self.navigationController?.navigationBar.tintColor = .white
        titleLabel.textColor = .white
        titleLabel.text = news.title
        let df = DateFormatter()
        df.dateFormat = "MM-dd-yyyy"
        dateLabel.text = df.string(from: news.datePost)
        textLabel.text = news.description
        tag1Label.text = news.tags.removeFirst()
        tag2Label.text = news.tags.removeFirst()
        
        tag1Label.textColor = .white
        tag1View.layer.cornerRadius = 4
        tag1View.clipsToBounds = true
        tag1View.layer.backgroundColor = UIColor(resource: .blue).cgColor
        tag2Label.textColor = .white
        tag2View.layer.cornerRadius = 4
        tag2View.clipsToBounds = true
        tag2View.layer.backgroundColor = UIColor(resource: .blue).cgColor


    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
