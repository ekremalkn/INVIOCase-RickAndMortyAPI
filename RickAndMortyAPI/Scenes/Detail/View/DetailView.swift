//
//  DetailView.swift
//  RickAndMortyAPI
//
//  Created by Ekrem Alkan on 29.03.2023.
//

import UIKit

protocol DetailViewProtocol {
    var detailViewCharacterName: String { get }
    var detailViewCharacterImage: String { get }
    var detailViewStatus: String { get }
    var detailViewSpecy: String { get }
    var detailViewGender: String { get }
    var detailViewOrigin: String { get }
    var detailViewLocation: String { get }
    var detailViewEpisodes: String { get }
    var detailViewCreatedDate: String { get }
}

final class DetailView: UIView {
    
    //MARK: - Creating UI Elements
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        return view
    }()
    
    private let characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.backgroundColor = .systemGray4
        return imageView
    }()
    
    let nameLabelView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    let charachterNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: "Avenir-Black", size: 25)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.3
        label.sizeToFit()
        return label
    }()
    
    private let detailStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        return stackView
    }()
    
    private let detailLineStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 20
        return stackView
    }()
    
    let details: [String] = ["Status:", "Specy:", "Gender:", "Origin:", "Location:", "Episodes:", "Created at:"]
    var values: [String] = []
    
    //MARK: - Life Cycle Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Layout Subviews
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.cornerRadius = 20
        contentView.layer.masksToBounds = true
        
        characterImageView.layer.cornerRadius = 20
        characterImageView.layer.masksToBounds = true
    }
    
    //MARK: - Setup StackView Elements
    private func setupDetailLabel(i: Int) -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont(name: "Avenir-Heavy", size: 22)
        label.text = details[i]
        return label
    }
    
    private func setupDetailValueLabel(i: Int) -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont(name: "Avenir", size: 22)
        label.text = values[i]
        return label
    }
    
    func configure(_ data: DetailViewProtocol, completion: @escaping () -> ()) {
        charachterNameLabel.text = data.detailViewCharacterName
        characterImageView.downloadSetImage(url: data.detailViewCharacterImage)
        values.append(data.detailViewStatus)
        values.append(data.detailViewSpecy)
        values.append(data.detailViewGender)
        values.append(data.detailViewOrigin)
        values.append(data.detailViewLocation)
        values.append(data.detailViewEpisodes)
        values.append(data.detailViewCreatedDate)
        completion()
    }
}

//MARK: - UI Elements AddSubview / SetupConstraints
extension DetailView: ViewProtocol {
    //MARK: - Configure View
    func configureView() {
        backgroundColor = .white
        addSubview()
        setupConstraints()
    }
    
    //MARK: - AddSubview
    func addSubview() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        elementsToContentView()
    }
    
    private func elementsToContentView() {
        contentView.addSubview(characterImageView)
        contentView.addSubview(detailStackView)
    }
    
    func addSetupStackView() {
        for i in 0..<details.count {
            let stackView = UIStackView()
            stackView.axis = .horizontal
            stackView.distribution = .fillProportionally
            stackView.spacing = 20
            stackView.addArrangedSubview(setupDetailLabel(i: i))
            stackView.addArrangedSubview(setupDetailValueLabel(i: i))
            
            detailStackView.addArrangedSubview(stackView)
        }
    }
    
    //MARK: - Setup Constraints
    func setupConstraints() {
        scrollViewConstraints()
        contentViewConstraints()
        characterImageViewConstraints()
        detailStackViewConstraints()
    }
    
    private func scrollViewConstraints() {
        scrollView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(self)
        }
    }
    
    private func contentViewConstraints() {
        contentView.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.top)
            make.leading.equalTo(scrollView.snp.leading).offset(10)
            make.trailing.equalTo(scrollView.snp.trailing).offset(-10)
            make.bottom.equalTo(scrollView.snp.bottom).offset(-20)
            make.centerX.equalTo(scrollView.snp.centerX)
        }
    }
    
    private func characterImageViewConstraints() {
        characterImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(20)
            make.height.width.equalTo(275)
            make.centerX.equalTo(contentView.snp.centerX)
        }
    }
    
    private func detailStackViewConstraints() {
        detailStackView.snp.makeConstraints { make in
            make.top.equalTo(characterImageView.snp.bottom).offset(20)
            make.centerX.equalTo(characterImageView.snp.centerX)
            make.leading.equalTo(contentView.snp.leading).offset(20)
            make.bottom.equalTo(contentView.snp.bottom).offset(-20)
        }
    }
    
}
