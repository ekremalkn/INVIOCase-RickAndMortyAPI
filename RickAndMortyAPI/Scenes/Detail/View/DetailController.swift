//
//  DetailController.swift
//  RickAndMortyAPI
//
//  Created by Ekrem Alkan on 29.03.2023.
//

import UIKit
import RxSwift

final class DetailController: UIViewController {

    //MARK: - References
    let detailView = DetailView()
    let viewModel: DetailViewModel
    
    //MARK: - Dispose Bag
    let disposeBag = DisposeBag()
    
    //MARK: - Life Cycle Methods
    init(id: Int) {
        self.viewModel = DetailViewModel(id: id)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }
    
    //MARK: - Configure View Controller
    private func configureViewController() {
        configureNavBar()
        createCallbacks()
        viewModel.getSingleCharacterDetail()
    }
    
    private func configureNavBar() {
        navigationController?.isNavigationBarHidden = false
        }

    //MARK: - Create Callbacks
    private func createCallbacks() {
        viewModelCallbacks()
    }
    
    //MARK: - ViewModel Callbacks
    
    private func viewModelCallbacks() {
        viewModel.characterDetail.subscribe { [weak self] characterDetail in
            self?.detailView.configure(characterDetail, completion: {
                self?.detailView.addSetupStackView()
            })
        }.disposed(by: disposeBag)
        
        viewModel.characterName.subscribe { [weak self] name in
            self?.title = name
        }.disposed(by: disposeBag)
    }



}
