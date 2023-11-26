//
//  MapViewController.swift
//  Urbatone
//
//  Created by Artsiom Sazonau on 24.11.23.
//

import UIKit
import MapboxMaps

class MapViewController: BaseViewController {
     
    var mapView: MapView!
    
    var pt: String {
        guard let path = Bundle.main.path(forResource: "Info", ofType: "plist") else {
            fatalError("No token")
        }
        let dict = NSDictionary(contentsOfFile: path)
        return dict!["MBXAccessToken"] as! String
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        let myResourceOptions = ResourceOptions(accessToken: pt)
        let cameraOptions = CameraOptions(center: .init(latitude:  56.8519, longitude: 60.6122), zoom: 9)
        let myMapInitOptions = MapInitOptions(resourceOptions: myResourceOptions, cameraOptions: cameraOptions)
        mapView = MapView(frame: view.bounds, mapInitOptions: myMapInitOptions)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.view.addSubview(mapView)
    }
    
}
