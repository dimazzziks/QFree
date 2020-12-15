//
//  MapManager.swift
//  QFree
//
//  Created by Maxim V. Sidorov on 11/26/20.
//

import Foundation
import MapKit

enum MKLocalSearchError: Error {
    case searchError
    case emptyResponse
}

protocol MapManagerProtocol {
    func placesNearby(_ center: CLLocationCoordinate2D, radius: CLLocationDistance, completion: @escaping (Result<[MKMapItem], MKLocalSearchError>) -> ())
}

class MapManager: MapManagerProtocol {
    func placesNearby(_ center: CLLocationCoordinate2D, radius: CLLocationDistance, completion: @escaping (Result<[MKMapItem], MKLocalSearchError>) -> ()) {
        let request = MKLocalPointsOfInterestRequest(center: center, radius: radius)
        request.pointOfInterestFilter = MKPointOfInterestFilter(including: [.restaurant, .cafe])
        let searcher = MKLocalSearch(request: request)
        searcher.start { (response, error) in
            if error != nil {
                completion(.failure(.searchError))
                return
            }
            if let response = response {
                completion(.success(response.mapItems))
                return
            }
            completion(.failure(.emptyResponse))
        }
    }
}
