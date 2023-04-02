//
//  MainViewModel.swift
//  RickAndMortyAPI
//
//  Created by Ekrem Alkan on 25.03.2023.
//

import RxSwift

final class MainViewModel {
    
    //MARK: - Subjects
    let locations = BehaviorSubject<[LocationResult]>(value: [])
    var nextLocation: String? = nil
    let characters = PublishSubject<[CharacterResult]>()
    
    // Stage Subjects
    let fetchingNextLocationsData = PublishSubject<Bool>()
    let fetchedNextLocationsData = PublishSubject<Void>()
    let fetchingSingleLocationData = PublishSubject<Bool>()
    let fetchedSingleLocationData = PublishSubject<Void>()
    let fetchingCharactersData = PublishSubject<Bool>()
    let fetchedCharactersData = PublishSubject<Void>()
    let fetchedNoCharactersData = PublishSubject<Void>()
    let errorMsg = PublishSubject<String>()
    
    //MARK: - Dispose Bag
    private let disposeBag = DisposeBag()
    
    //MARK: - Methods
    func getLocations() {
        fetchingNextLocationsData.onNext(true)
        
        Service.shared.getLocations(1)
            .subscribe { [weak self] event in
                let currentLocations = try? self?.locations.value()
                
                switch event {
                case .next(let locations):
                    self?.fetchingNextLocationsData.onNext(false)
                    guard let nextLocation = locations?.info?.next, let locations = locations?.results else { return  }
                    let allLocations = (currentLocations ?? []) + locations
                    self?.locations.onNext(allLocations)
                    self?.nextLocation = nextLocation
                    self?.fetchedNextLocationsData.onNext(())
                case .error(let error):
                    self?.fetchingNextLocationsData.onNext(false)
                    self?.errorMsg.onNext(error.localizedDescription)
                case .completed:
                    print("Success Locations Request")
                }
            }.disposed(by: disposeBag)
    }
    
    func getNextLocations(_ url: String) {
        fetchingNextLocationsData.onNext(true)
        
        Service.shared.getNextLocations(url).subscribe { [weak self] event in
            let currentLocations = try? self?.locations.value()
            
            switch event {
            case .next(let locations):
                self?.fetchingNextLocationsData.onNext(false)
                guard let locations = locations?.results else { return }
                let allLocations = (currentLocations ?? []) + locations
                self?.fetchedNextLocationsData.onNext(())
                self?.locations.onNext(allLocations)
            case .error(let error):
                self?.fetchingNextLocationsData.onNext(false)
                self?.errorMsg.onNext(error.localizedDescription)
            case .completed:
                print("Succes Next Locations Request")
            }
        }.disposed(by: disposeBag)
    }
    
    func getNextLocationUrl(_ url: String) {
        
        Service.shared.getNextLocations(url).subscribe { [weak self] event in
            switch event {
            case .next(let locations):
                guard let nextLocationUrl = locations?.info?.next else { self?.nextLocation = nil; return }
                self?.nextLocation = nextLocationUrl
                self?.getNextLocations(nextLocationUrl)
            case .error(let error):
                self?.errorMsg.onNext(error.localizedDescription)
            case .completed:
                print("Succes Next Location Url Request")
            }
        }.disposed(by: disposeBag)
    }
    
    func getCharacters() {
        fetchingCharactersData.onNext(true)
        
        Service.shared.getCharacters().subscribe { [weak self] event in
            switch event {
            case .next(let characters):
                self?.fetchingCharactersData.onNext(false)
                guard let results = characters?.results else { return }
                self?.characters.onNext(results)
                self?.fetchedCharactersData.onNext(())
            case .error(let error):
                self?.fetchingCharactersData.onNext(false)
                self?.errorMsg.onNext(error.localizedDescription)
            case .completed:
                print("Success Character Request")
            }
        }.disposed(by: disposeBag)
    }
    
    func getSingleLocation(_ id: Int) {
        fetchingCharactersData.onNext(true)
        
        Service.shared.getSingleLocation(id).subscribe { [weak self] event in
            switch event {
            case .next(let locations):
                self?.fetchingSingleLocationData.onNext(false)
                guard let locationCharactersUrl = locations?.residents else { return }
                if locationCharactersUrl.count > 0 {
                    self?.filterMultipleIDs(locationCharactersUrl)
                    self?.fetchedSingleLocationData.onNext(())
                } else {
                    self?.characters.onNext([])
                    self?.fetchedSingleLocationData.onNext(())
                    self?.fetchedNoCharactersData.onNext(())
                }
                
            case .error(let error):
                self?.fetchingNextLocationsData.onNext(false)
                self?.errorMsg.onNext(error.localizedDescription)
            case .completed:
                print("Success Single Location Request")
            }
        }.disposed(by: disposeBag)
    }
    
    func getMultipleCharacters(_ locationCharactersUrl: String) {
        Service.shared.getMultipleCharacters(locationCharactersUrl).subscribe { [weak self] event in
            switch event {
            case .next(let characters):
                self?.fetchingCharactersData.onNext(false)
                guard let characters = characters else { return }
                self?.characters.onNext(characters)
                self?.fetchedCharactersData.onNext(())
            case .error(let error):
                self?.fetchingCharactersData.onNext(false)
                self?.errorMsg.onNext(error.localizedDescription)
            case .completed:
                print("Success Single Character Request")
            }
        }.disposed(by: disposeBag)
        
        
    }
    
    private func filterMultipleIDs(_ locationCharactersUrl: [String]) {
        let characterIDs = locationCharactersUrl.map { url in
            return url.replacingOccurrences(of: API.API_KEY.rawValue + NetworkEndPoint.CHARACTER.rawValue, with: "")
        }
        let IDs = characterIDs.joined(separator: ",").trimmingCharacters(in: [","])
        self.getMultipleCharacters(IDs)
        
    }
    
    
    
    
}

