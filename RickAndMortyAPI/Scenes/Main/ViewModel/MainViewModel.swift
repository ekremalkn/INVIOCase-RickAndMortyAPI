//
//  MainViewModel.swift
//  RickAndMortyAPI
//
//  Created by Ekrem Alkan on 25.03.2023.
//

import Foundation
import RxSwift

final class MainViewModel: ViewModelProtocol {
    
    //MARK: - Subjects
    
    let locations = PublishSubject<[Result]>()
    
    //MARK: - Dispose Bag
    
    private let disposeBag = DisposeBag()
    
    // Stage Subjects
    
    let fetchingData = PublishSubject<Bool>()
    let fetchedData = PublishSubject<Bool>()
    let errorMsg = PublishSubject<String>()
    
    //MARK: - Methods
    
    func getLocations() {
        fetchingData.onNext(true)
        
        Service.shared.getLocations()
            .subscribe { [weak self] event in
                switch event {
                case .next(let locations):
                    self?.fetchingData.onNext(false)
                    guard let results = locations?.results else { return }
                    self?.locations.onNext(results)
                    self?.fetchedData.onNext(true)
                case .error(let error):
                    self?.fetchingData.onNext(false)
                    self?.errorMsg.onNext(error.localizedDescription)
                case .completed:
                    print("Success request")
                }
            }.disposed(by: disposeBag)
    }
}
