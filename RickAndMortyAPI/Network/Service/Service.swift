//
//  Service.swift
//  RickAndMortyAPI
//
//  Created by Ekrem Alkan on 25.03.2023.
//

import Alamofire
import RxSwift

protocol ServiceProtocol {
    func getLocations() -> Observable<Locations?>
}

final class Service: ServiceProtocol {
    static let shared = Service()
    
    func getLocations() -> Observable<Locations?> {
        return NetworkManager.shared.request(path: NetworkHelper.shared.locationRequestUrl()).asObservable()
    }
    
}
