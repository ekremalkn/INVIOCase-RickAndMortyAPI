//
//  SplashController.swift
//  RickAndMortyAPI
//
//  Created by Ekrem Alkan on 24.03.2023.
//

import UIKit
import RxSwift

final class SplashController: UIViewController {
    
    //MARK: - References
    
    var splashView = SplashView()
    
    
    //MARK: - Dispose Bag
    private let disposeBag = DisposeBag()
    
    //MARK: - Adding Key/Value to UserDefaults
    
    let isOpenedBefore = UserDefaults.standard.bool(forKey: "isOpenedBefore")
    
    //MARK: - Life Cycle Methods
    
    override func loadView() {
        super.loadView()
        checkIsOpenedBefore()
        view = splashView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }
    
    //MARK: - Check isOpenedBefore
    
    private func checkIsOpenedBefore() {
        self.splashView.changeWelcomeMessageText(isOpenedBefore)
    }
    
    //MARK: - Configure View Controller
    
    private func configureViewController() {
        createCallbacks()
    }
    
    //MARK: - Create Callbacks
    
    private func createCallbacks() {
        animationFinishedCallback()
    }
    
    private func animationFinishedCallback() {
        splashView.animationFinished.subscribe { [weak self] _ in
            self?.goToMainController()
        }.disposed(by: disposeBag)
    }
    
    //MARK: - Go To Main Controller
    
    private func goToMainController() {
        let mainController = MainController()
        self.navigationController?.pushViewController(mainController, animated: true)
        self.removeFromParent()
    }
}
