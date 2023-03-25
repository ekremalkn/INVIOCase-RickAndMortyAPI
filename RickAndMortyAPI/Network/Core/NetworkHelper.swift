//
//  NetworkHelper.swift
//  RickAndMortyAPI
//
//  Created by Ekrem Alkan on 25.03.2023.
//


final class NetworkHelper {
    static let shared = NetworkHelper()
    
    public func locationRequestUrl() -> String {
        return API.API_KEY.rawValue + NetworkEndPoint.LOCATION.rawValue
    }
}
