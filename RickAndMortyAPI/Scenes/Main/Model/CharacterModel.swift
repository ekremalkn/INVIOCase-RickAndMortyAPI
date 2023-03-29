//
//  CharacterModel.swift
//  RickAndMortyAPI
//
//  Created by Ekrem Alkan on 25.03.2023.
//

import UIKit

// MARK: - Words
struct CharacterModel: Codable {
    let info: CharacterInfo?
    let results: [CharacterResult]?
}

// MARK: - Info
struct CharacterInfo: Codable {
    let count, pages: Int?
    let next: String?
}

// MARK: - Result
struct CharacterResult: Codable, CharacterCellProtocol {
    let id: Int?
    let name: String?
    let status: Status?
    let species: Species?
    let type: String?
    let gender: Gender?
    let origin, location: Location?
    let image: String?
    let episode: [String]?
    let url: String?
    let created: String?
    
    //MARK: - CharacterCellProtocol
    var characterCellImage: String {
        if let image = image {
            return image
        }
        return ""
    }
    
    var characterCellName: String {
        if let name = name {
            return name
        }
        return ""
    }
    
    var characterCellStatusColor: UIColor {
        if let status = status {
            switch status {
            case .alive:
                return .green
            case .dead:
                return .black
            case .unknown:
                return .systemGray
            }
        }
        return .systemGray6
    }
    
    var characterCellSpecies: String {
        if let species = species {
            switch species {
            case .alien:
                return species.rawValue
            case .human:
                return species.rawValue
            case .cronenberg:
                return species.rawValue
            case .robot:
                return species.rawValue
            case .humanoid:
                return species.rawValue
            case .animal:
                return species.rawValue
            case .disease:
                return species.rawValue
            case .poopybutthole:
                return species.rawValue
            case .mythologicalCreature:
                return species.rawValue
            case .unknown:
                return species.rawValue
            }
        }
        return ""
    }
    
    var characterCellSpeciesViewColor: UIColor {
        if let species = species {
            switch species {
            case .alien:
                return .orange
            case .human:
                return .white
            case .cronenberg:
                return .systemBlue
            case .robot:
                return .gray
            case .humanoid:
                return .white
            case .animal:
                return .cyan
            case .disease:
                return .magenta
            case .poopybutthole:
                return .systemTeal
            case .mythologicalCreature:
                return .systemIndigo
            case .unknown:
                return .systemGray
                
            }
        }
        return .systemGray6
    }
    
    var characterCellGender: String {
        if let gender = gender {
            switch gender {
            case .female:
                return gender.rawValue
            case .male:
                return gender.rawValue
            case .unknown:
                return gender.rawValue
            case .genderless:
                return gender.rawValue
            }
        }
        return ""
    }
    
    var characterCellGenderViewColor: UIColor {
        if let gender = gender {
            switch gender {
            case .female:
                return .purple
            case .male:
                return .systemBlue
            case .unknown:
                return .systemGray
            case .genderless:
                return .systemGray
            }
        }
        return .systemGray6
    }
    
    var characterCellLocation: String {
        if let location = location?.name {
            return location
        }
        return ""
    }
    
    var characterCellCreated: String {
        if let created = created {
            return created.formatDate() ?? "dd/mm/yyyy"
        }
        return "dd/mm/yyyy"
    }
    
    
    
}

enum Gender: String, Codable {
    case female = "Female"
    case male = "Male"
    case genderless = "Genderless"
    case unknown = "unknown"
}

// MARK: - Location
struct Location: Codable {
    let name: String?
    let url: String?
}

enum Species: String, Codable {
    case alien = "Alien"
    case human = "Human"
    case cronenberg = "Cronenberg"
    case robot = "Robot"
    case humanoid = "Humanoid"
    case animal = "Animal"
    case disease = "Disease"
    case poopybutthole = "Poopybutthole"
    case mythologicalCreature = "Mythological Creature"
    case unknown = "unknown"
}

enum Status: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}
