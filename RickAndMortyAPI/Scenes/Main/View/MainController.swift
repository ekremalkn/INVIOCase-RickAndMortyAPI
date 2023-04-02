//
//  MainController.swift
//  RickAndMortyAPI
//
//  Created by Ekrem Alkan on 24.03.2023.
//

import UIKit
import RxSwift
import RxCocoa

final class MainController: UIViewController {
    
    //MARK: - References
    let mainView: MainView = MainView()
    let viewModel: MainViewModel = MainViewModel()
    
    //MARK: - Dispose Bag
    private let disposeBag = DisposeBag()
    
    //MARK: - Life Cycle Methods
    override func loadView() {
        super.loadView()
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    //MARK: - Configure View Controller
    private func configureViewController() {
        configureNavBar()
        createCallbacks()
        viewModel.getLocations()
        viewModel.getCharacters()
    }
    
    private func configureNavBar() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .black
    }
    
    //MARK: - UIScreen orientation will change
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        self.mainView.charactersCollectionView.collectionViewLayout.invalidateLayout()
        
    }
    
    //MARK: - Create Callbacks
    private func createCallbacks() {
        collectionViewCallbacks()
        viewModelCallbacks()
    }
    
    //MARK: - Collection Views Callbacks
    private func collectionViewCallbacks() {
        locationsCollectionViewCallbacks()
        charactersCollectionViewCallbacks()
    }
    
    private func locationsCollectionViewCallbacks() {
        // Binding Data
        
        viewModel.locations.bind(to: mainView.locationsCollectionView.rx.items) { [weak self] collectionView, row, location in
            let indexPath = IndexPath(row: row, section: 0)
            do {
                let locationsCount = try? self?.viewModel.locations.value().count
                if indexPath.row == (locationsCount ?? 1) - 1  {
                    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LoadingCell.identifier, for: indexPath) as? LoadingCell else { return UICollectionViewCell() }
                    return cell
                } else {
                    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LocationCell.identifier, for: indexPath) as? LocationCell else { return UICollectionViewCell() }
                    cell.configure(location)
                    return cell
                }
            }
            
        }.disposed(by: disposeBag)
        
        // Handle Didselect
        mainView.locationsCollectionView.rx.modelSelected(LocationResult.self).bind { [weak self] selectedLocation in
            if let id = selectedLocation.id {
                self?.viewModel.getSingleLocation(id)
            }
        }.disposed(by: disposeBag)
        
        mainView.locationsCollectionView.rx.itemSelected.subscribe { [weak self] indexPath in
            guard let cell = self?.mainView.locationsCollectionView.cellForItem(at: indexPath) as? LocationCell else { return }
            cell.isSelected = true
        }.disposed(by: disposeBag)
        
        // Handle Deselected
        mainView.locationsCollectionView.rx.itemDeselected.subscribe { [weak self] indexPath in
            guard let cell = self?.mainView.locationsCollectionView.cellForItem(at: indexPath) as? LocationCell else { return }
            cell.isSelected = false
        }.disposed(by: disposeBag)
        
        // Handle select the first cell default
        mainView.locationsCollectionView.rx.willDisplayCell.take(1).subscribe { [weak self] cell, indexPath in
            self?.mainView.locationsCollectionView.selectItem(at: indexPath, animated: false, scrollPosition: .top)
            cell.isSelected = true
            self?.viewModel.getSingleLocation(indexPath.row + 1)
        }.disposed(by: disposeBag)
        
        mainView.locationsCollectionView.rx.willDisplayCell.subscribe { [weak self] cell, indexPath in
            guard let cell = cell as? LoadingCell else { return }
            do {
                let locationsCount = try? self?.viewModel.locations.value().count
                if indexPath.row == (locationsCount ?? 1) - 1 {
                    guard let nextLocationUrl = self?.viewModel.nextLocation else { cell.alertLabelIsHidden = false; return }
                    cell.loadingIndicator.startAnimating()
                    self?.viewModel.getNextLocationUrl(nextLocationUrl)
                }
            }
        }.disposed(by: disposeBag)
        
        // Set delegate for collection cell size
        mainView.locationsCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    private func charactersCollectionViewCallbacks() {
        // Binding Data
        viewModel.characters.bind(to: mainView.charactersCollectionView.rx.items(cellIdentifier: CharacterCell.identifier, cellType: CharacterCell.self)) { row, character, cell in
            cell.configure(character)
            
        }.disposed(by: disposeBag)
        
        // Handle Didselect
        mainView.charactersCollectionView.rx.modelSelected(CharacterResult.self).bind { [weak self] selectedCharacter in
            guard let id = selectedCharacter.id else { return }
            let detailController = DetailController(id: id)
            self?.navigationController?.pushViewController(detailController, animated: true)
        }.disposed(by: disposeBag)
        
        // Set delegate for collection cell size
        mainView.charactersCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    //MARK: - ViewModel Callbacks
    private func viewModelCallbacks() {
        locationStageCallbacks()
        charactersLoadStageCallbacks()
    }
    
    private func locationStageCallbacks() {
        viewModel.fetchingNextLocationsData.subscribe { value in
            if value {
                print("locations yakalanmaya başlandı")
            } else {
                print("locations yakalanma sona erdi")
            }
        }.disposed(by: disposeBag)
        
        viewModel.fetchedNextLocationsData.subscribe { _ in
            print("locations yakalama başarılı")
        }.disposed(by: disposeBag)
        
        viewModel.errorMsg.subscribe { errorMsg in
            print(errorMsg)
        }.disposed(by: disposeBag)
    }
    
    private func charactersLoadStageCallbacks() {
        viewModel.fetchingCharactersData.subscribe { [weak self] value in
            if value {
                self?.mainView.indicator.startAnimating()
            } else {
                self?.mainView.indicator.stopAnimating()
            }
        }.disposed(by: disposeBag)
        
        viewModel.fetchedCharactersData.subscribe { [weak self] _ in
            self?.mainView.indicator.stopAnimating()
            self?.mainView.changeMessageLabelText(hide: true)
        }.disposed(by: disposeBag)
        
        viewModel.fetchedNoCharactersData.subscribe { [weak self] _ in
            self?.mainView.changeMessageLabelText(hide: false)
            self?.mainView.indicator.stopAnimating()
        }.disposed(by: disposeBag)
    }
    
}

//MARK: - UICollectionViewDelegateFlowLayout
extension MainController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case mainView.locationsCollectionView:
            var cellWidth: CGFloat = collectionView.frame.width / 3
            let cellHeight: CGFloat = (collectionView.frame.height - 5) / 2
            if let locations =  try? viewModel.locations.value() {
                let text = locations[indexPath.row].name
                if let labelWidth = text?.size(withAttributes: [.font: UIFont.boldSystemFont(ofSize: 20)]).width {
                    cellWidth = labelWidth + 20
                }
            }
            let size: CGSize = CGSize(width: cellWidth, height: cellHeight)
            return size
            
        case mainView.charactersCollectionView:
            let cellWidth: CGFloat = (collectionView.frame.width - 20) / 2
            let cellHeight: CGFloat = collectionView.frame.height / 2.5
            if UIDevice.current.orientation.isLandscape { // check UIDevice orientation
                let landScapeCellHeight = collectionView.frame.height * 1.25
                let landScapeCellWidth = (collectionView.frame.width - 30) / 3
                return CGSize(width: landScapeCellWidth, height: landScapeCellHeight)
            }
            if UIDevice.current.orientation.isPortrait {
                return CGSize(width: cellWidth, height: cellHeight)
            }
            let size: CGSize = CGSize(width: cellWidth, height: cellHeight)
            return size
        default:
            return CGSize()
        }
    }
    
}


