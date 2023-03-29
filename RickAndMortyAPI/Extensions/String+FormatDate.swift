//
//  String+FormatDate.swift
//  RickAndMortyAPI
//
//  Created by Ekrem Alkan on 26.03.2023.
//

import Foundation

extension String {
    func formatDate() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        guard let date = dateFormatter.date(from: self) else {
            return nil
        }
        
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: date)
    }
}
