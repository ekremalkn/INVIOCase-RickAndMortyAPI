//
//  CharacterCell.swift
//  RickAndMortyAPI
//
//  Created by Ekrem Alkan on 25.03.2023.
//

import UIKit
import RxSwift

protocol CharacterCellProtocol {
    var characterCellImage: String { get }
    var characterCellName: String { get }
    var characterCellStatusColor: UIColor { get }
    var characterCellSpecies: String { get }
    var characterCellSpeciesViewColor: UIColor { get }
    var characterCellGender: String { get }
    var characterCellGenderViewColor: UIColor { get }
    var characterCellLocation: String { get }
    var characterCellCreated: String { get }
}


final class CharacterCell: UICollectionViewCell {
    
    //MARK: - Cell's Identifier
    static let identifier = "CharacterCell"
    
    //MARK: - Creating UI Elements
    
    private let characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private let detailView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        return label
    }()
    
    private let statusView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let speciesLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        return label
    }()
    
    private let speciesView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let genderLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        return label
    }()
    
    private let genderView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textAlignment = .right
        return label
    }()
    
    private let createdDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textAlignment = .right
        return label
    }()
    
    
    //MARK: - Life Cycle Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Layout Subviews
    override func layoutSubviews() {
        super.layoutSubviews()
        self.makeTheViewsCornerRadius()
    }
    
    //MARK: - Configure
    func configure(_ data: CharacterCellProtocol) {
        characterImageView.downloadSetImage(url: data.characterCellImage)
        nameLabel.text = data.characterCellName
        statusView.backgroundColor = data.characterCellStatusColor
        speciesLabel.text = data.characterCellSpecies
        speciesView.backgroundColor = data.characterCellSpeciesViewColor
        genderLabel.text = data.characterCellGender
        genderView.backgroundColor = data.characterCellGenderViewColor
        locationLabel.text = data.characterCellLocation
        createdDateLabel.text = data.characterCellCreated
    }
    
    //MARK: - Make the views cornerRadius.
    private func makeTheViewsCornerRadius() {
        self.layer.cornerRadius = characterImageView.frame.height / 6
        self.layer.masksToBounds = true
        
        characterImageView.layer.cornerRadius = characterImageView.frame.height / 6
        characterImageView.layer.masksToBounds = true
        
        statusView.layer.cornerRadius = statusView.frame.height / 2
        statusView.layer.masksToBounds = true
        
        speciesView.layer.cornerRadius = speciesView.frame.height / 2
        speciesView.layer.masksToBounds = true
        
        genderView.layer.cornerRadius = speciesView.frame.height / 2
        genderView.layer.masksToBounds = true
    }
    
}

//MARK: - UI Elements AddSubview / Setup Constraints
extension CharacterCell: CellProtocol {
    func configureCell() {
        backgroundColor = .systemGray6
        addSubview()
        setupConstraints()
    }
    
    func addSubview() {
        contentView.addSubview(characterImageView)
        contentView.addSubview(detailView)
        detailsToDetailView()
    }
    
    
    
    func setupConstraints() {
        characterImageViewConstraints()
        detailViewConstraints()
        statusViewConstraints()
        nameLabelConstraints()
        speciesLabelConsraints()
        speciesViewConsraints()
        genderLabelConstraints()
        genderViewConstraints()
        locationLabelConstraints()
        createdDateLabelConstraints()
    }
    
    private func detailsToDetailView() {
        detailView.addSubview(nameLabel)
        detailView.addSubview(statusView)
        detailView.addSubview(speciesLabel)
        detailView.addSubview(speciesView)
        detailView.addSubview(genderLabel)
        detailView.addSubview(genderView)
        detailView.addSubview(locationLabel)
        detailView.addSubview(createdDateLabel)
    }
    
    private func characterImageViewConstraints() {
        characterImageView.snp.makeConstraints { make in
            make.leading.top.equalTo(contentView).offset(10)
            make.trailing.equalTo(contentView.snp.trailing).offset(-10)
            make.height.equalTo(contentView.snp.width).offset(-20)
        }
    }
    
    private func detailViewConstraints() {
        detailView.snp.makeConstraints { make in
            make.top.equalTo(characterImageView.snp.bottom).offset(10)
            make.leading.trailing.equalTo(characterImageView)
            make.bottom.equalTo(contentView.snp.bottom).offset(-10)
        }
    }
    
    private func nameLabelConstraints() {
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(detailView.snp.top)
            make.leading.equalTo(detailView.snp.leading)
            make.trailing.equalTo(statusView.snp.leading).offset(-5)
            make.height.equalTo(detailView.snp.height).multipliedBy(0.3)
        }
    }
    
    private func statusViewConstraints() {
        statusView.snp.makeConstraints { make in
            make.trailing.equalTo(detailView.snp.trailing)
            make.centerY.equalTo(nameLabel.snp.centerY)
            make.height.width.equalTo(speciesLabel.font.pointSize)
        }
    }
    
    private func speciesLabelConsraints() {
        speciesLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom)
            make.leading.trailing.equalTo(nameLabel)
            make.height.equalTo(detailView.snp.height).multipliedBy(0.2)
        }
    }
    
    private func speciesViewConsraints() {
        speciesView.snp.makeConstraints { make in
            make.centerY.equalTo(speciesLabel.snp.centerY)
            make.height.width.centerX.equalTo(statusView)
        }
    }
    
    private func genderLabelConstraints() {
        genderLabel.snp.makeConstraints { make in
            make.top.equalTo(speciesLabel.snp.bottom).offset(5)
            make.leading.trailing.height.equalTo(speciesLabel)
        }
    }
    
    private func genderViewConstraints() {
        genderView.snp.makeConstraints { make in
            make.centerY.equalTo(genderLabel.snp.centerY)
            make.height.width.centerX.equalTo(speciesView)
        }
    }
    
    private func locationLabelConstraints() {
        locationLabel.snp.makeConstraints { make in
            make.top.equalTo(genderLabel.snp.bottom)
            make.height.equalTo(detailView.snp.height).multipliedBy(0.15)
            make.trailing.leading.equalTo(detailView)
        }
    }
    
    private func createdDateLabelConstraints() {
        createdDateLabel.snp.makeConstraints { make in
            make.top.equalTo(locationLabel.snp.bottom)
            make.bottom.equalTo(contentView.snp.bottom)
            make.leading.trailing.equalTo(locationLabel)
        }
    }
    
}
