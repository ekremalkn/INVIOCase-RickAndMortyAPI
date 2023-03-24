//
//  MainController.swift
//  RickAndMortyAPI
//
//  Created by Ekrem Alkan on 24.03.2023.
//

import UIKit

final class MainController: UIViewController {
    
    //MARK: - Life Cycle Methods
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .blue
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
    }
    
    
    
}
