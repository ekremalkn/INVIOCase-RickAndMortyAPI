//
//  NetworkManager.swift
//  RickAndMortyAPI
//
//  Created by Ekrem Alkan on 25.03.2023.
//

import Alamofire
import RxSwift

final class NetworkManager {
    static let shared = NetworkManager()
    
    public func request<T: Decodable>(path: String) -> Observable<T> {
        return Observable.create { observer in
            AF.request(path, encoding: JSONEncoding.default)
                .validate()
                .responseDecodable(of: T.self) { response in
                    switch response.result {
                    case .success(let model):
                        observer.onNext(model)
                        observer.onCompleted()
                    case .failure(let error):
                        observer.onError(error)
                        print("An error occurred during the API request. [\(error)]")
                    }
                }
            return Disposables.create()
        }
    }
}
