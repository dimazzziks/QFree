//
//  MapViewController.swift
//  QFree
//
//  Created by Maxim V. Sidorov on 11/26/20.
//

import Foundation
import MapKit

class MapViewController: UIViewController {
    
    let mapView = BaseMapView(frame: .zero)
    let mapManager: MapManagerProtocol = MapManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        // Test
        let center = CLLocationCoordinate2D(latitude: 55.759051, longitude: 37.595905)
        let radius = CLLocationDistance(10000)
        
        mapManager.placesNearby(center, radius: radius) { (result) in
            switch result {
            case .success(let items):
                print("PLACES COUNT: \(items.count)")
                self.mapView.showPlaces(items)
                self.mapView.centerCoordinate = center
                self.mapView.setCameraZoomRange(MKMapView.CameraZoomRange(maxCenterCoordinateDistance: radius * 2.5), animated: true)
            case .failure(let error):
                print("ERROR: \(error)")
            }
        }
    }
}
