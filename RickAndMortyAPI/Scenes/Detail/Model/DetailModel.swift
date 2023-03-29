//
//  DetailModel.swift
//  RickAndMortyAPI
//
//  Created by Ekrem Alkan on 29.03.2023.
//

import Foundation

// MARK: - Character
struct SingleCharacter: Codable, DetailViewProtocol {
    let id: Int?
    let name, status, species, type: String?
    let gender: String?
    let origin, location: DetailLocation?
    let image: String?
    let episode: [String]?
    let url: String?
    let created: String?
    
    //MARK: - DetailViewProtocol
    
    var detailViewCharacterName: String {
        if let name = name {
            return name
        }
        return ""
    }
    
    var detailViewCharacterImage: String {
        if let image = image {
            return image
        }
        return ""
    }
    
    var detailViewStatus: String {
        if let status = status {
            return status
        }
        return ""
    }
    
    var detailViewSpecy: String {
        if let species = species {
            return species
        }
        return ""
    }
    
    var detailViewGender: String {
        if let gender = gender {
            return gender
        }
        return ""
    }
    
    var detailViewOrigin: String {
        if let origin = location?.name {
            return origin
        }
        return ""
    }
    
    var detailViewLocation: String {
        if let location = location?.name {
            return location
        }
        return ""
    }
    
    var detailViewEpisodes: String {
        if let episode = episode {
            return episode.characterParsing(episode)
        }
        return ""
    }
    
    var detailViewCreatedDate: String {
        if let date = created?.formatDate(dateType: .date), let time = created?.formatDate(dateType: .time) {
            return "\(date), \(time)"
        }
        return ""
    }
    

}

// MARK: - Location
struct DetailLocation: Codable {
    let name: String?
    let url: String?
}
