//
//  LocationModel.swift
//  RickAndMortyAPI
//
//  Created by Ekrem Alkan on 25.03.2023.
//

import Foundation

// MARK: - Locations
struct LocationModel: Codable {
    let info: Info?
    let results: [LocationResult]?
}

// MARK: - Info
struct Info: Codable {
    let count, pages: Int?
    let next: String?
}

// MARK: - Result
struct LocationResult: Codable, LocationCellProtocol {
    let id: Int?
    let name, type, dimension: String?
    let residents: [String]?
    let url: String?
    let created: String?
    
    //MARK: - LocationCellProtocol
    var locationCellName: String {
        if let name = name {
            return name
        }
        return "Location"
    }
    
    
}

