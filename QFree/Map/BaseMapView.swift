//
//  BaseMapView.swift
//  QFree
//
//  Created by Maxim V. Sidorov on 11/26/20.
//

import Foundation
import MapKit

class BaseMapView: MKMapView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showPlaces(_ items: [MKMapItem]) {
        addAnnotations(items.map { $0.placemark })
    }
}

extension BaseMapView: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let view = MKAnnotationView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        view.backgroundColor = Brandbook.defaultColor
        view.alpha = 0.5
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 12
        return view
    }
}


