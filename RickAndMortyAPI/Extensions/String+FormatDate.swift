//
//  String+FormatDate.swift
//  RickAndMortyAPI
//
//  Created by Ekrem Alkan on 26.03.2023.
//

import Foundation

enum DateType {
    case date
    case time
}

extension String {
    func formatDate(dateType: DateType) -> String? {
        switch dateType {
        case .date:
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            guard let date = dateFormatter.date(from: self) else { return nil }
            
            dateFormatter.dateFormat = "dd MMM yyyy"
            return dateFormatter.string(from: date)
        case .time:
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            guard let time = timeFormatter.date(from: self) else { return nil }
            
            timeFormatter.dateFormat = "HH:mm:ss"
            return timeFormatter.string(from: time)
        }
        
    }
    
}
