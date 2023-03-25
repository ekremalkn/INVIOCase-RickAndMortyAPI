//
//  MainController.swift
//  RickAndMortyAPI
//
//  Created by Ekrem Alkan on 24.03.2023.
//

import UIKit

final class MainController: UIViewController {
    
    //MARK: - References
    
    let viewModel: MainViewModel = MainViewModel()
    
    //MARK: - Life Cycle Methods
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getLocations()
        navigationController?.isNavigationBarHidden = true
    }
    
    
    
}
