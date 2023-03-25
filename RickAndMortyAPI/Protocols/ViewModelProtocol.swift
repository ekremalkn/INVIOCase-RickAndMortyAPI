//
//  ViewModelProtocol.swift
//  RickAndMortyAPI
//
//  Created by Ekrem Alkan on 25.03.2023.
//

import RxSwift

protocol ViewModelProtocol {
    var fetchingData: PublishSubject<Bool> { get }
    var fetchedData: PublishSubject<Bool> { get }
    var errorMsg:  PublishSubject<String> { get }
}
