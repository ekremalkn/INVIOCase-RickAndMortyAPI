//
//  Service.swift
//  RickAndMortyAPI
//
//  Created by Ekrem Alkan on 25.03.2023.
//

import Alamofire
import RxSwift

protocol ServiceProtocol {
    func getLocations() -> Observable<LocationModel?>
    func getCharacters() -> Observable<CharacterModel?>
    func getSingleLocation(_ id: Int) -> Observable<LocationResult?>
    func getMultipleCharacters(_ IDs: String) -> Observable<[CharacterResult]?>
}

final class Service: ServiceProtocol {
    static let shared = Service()
    
    func getLocations() -> Observable<LocationModel?> {
        return NetworkManager.shared.request(path: NetworkHelper.shared.locationRequestUrl()).asObservable()
    }
    
    func getCharacters() -> Observable<CharacterModel?> {
        return NetworkManager.shared.request(path: NetworkHelper.shared.characterRequestUrl()).asObservable()
    }
    
    func getSingleLocation(_ id: Int) -> Observable<LocationResult?> {
        return NetworkManager.shared.request(path: NetworkHelper.shared.singleLocationRequestUrl(id))
    }
    
    func getMultipleCharacters(_ IDs: String) -> RxSwift.Observable<[CharacterResult]?> {
        return NetworkManager.shared.request(path: NetworkHelper.shared.multipleCharactersRequestUrl(IDs))
    }
    
}
