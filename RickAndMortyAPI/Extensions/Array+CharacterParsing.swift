//
//  Array+CharacterParsing.swift
//  RickAndMortyAPI
//
//  Created by Ekrem Alkan on 29.03.2023.
//


extension Array {
    public func characterParsing(_ stringArr: [String]) -> String {
        let parsedCharacters = stringArr.map { arrElement in
            return arrElement.replacingOccurrences(of: API.API_KEY.rawValue + NetworkEndPoint.EPISODE.rawValue, with: "")
        }
        let characters = parsedCharacters.joined(separator: ", ".trimmingCharacters(in: []))
        return characters
    }
    
}
