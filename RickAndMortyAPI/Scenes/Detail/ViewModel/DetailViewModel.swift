//
//  DetailViewModel.swift
//  RickAndMortyAPI
//
//  Created by Ekrem Alkan on 29.03.2023.
//

import RxSwift

final class DetailViewModel {
    
    //MARK: - Subjects
    let characterDetail = PublishSubject<SingleCharacter>()
    let characterName = PublishSubject<String>()
    
    // Stage Subjects
    let fetchingCharacterDetail = PublishSubject<Bool>()
    let fetchedCharacterDetail = PublishSubject<Void>()
    let errorMsg = PublishSubject<String>()
    
    //MARK: - Dispose Bag
    let disposeBag = DisposeBag()
    
    //MARK: - Variable
    let id: Int
    
    //MARK: - Init Method
    init(id: Int) {
        self.id = id
    }
    
    func getSingleCharacterDetail() {
        fetchingCharacterDetail.onNext(true)
        
        Service.shared.getSingleCharacter(id).subscribe { [weak self] event in
            switch event {
            case .next(let characterDetail):
                self?.fetchingCharacterDetail.onNext(false)
                guard let characterDetail = characterDetail else { return }
                self?.characterDetail.onNext(characterDetail)
                self?.characterName.onNext(characterDetail.name ?? "unknown")
                self?.fetchedCharacterDetail.onNext(())
            case .error(let error):
                self?.fetchingCharacterDetail.onNext(false)
                self?.errorMsg.onNext(error.localizedDescription)
            case .completed:
                print("Success Character Detail Request")
            }
        }.disposed(by: disposeBag)
    }
}
