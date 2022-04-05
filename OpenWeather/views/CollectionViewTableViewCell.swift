//
//  CellectionViewTableViewCell.swift
//  OpenWeather
//
//  Created by Askar on 02.04.2022.
//

import UIKit

class CollectionViewTableViewCell: UITableViewCell {

    static let identifier = "CollectionViewTableViewCell"
    
    private var weathersList: [DailyWeatherModel] = []
    
    private lazy var weatherCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(WeatherCollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewTableViewCell.identifier)
        collectionView.alwaysBounceHorizontal = true
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupWeatherCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupWeatherCollectionView() {
        contentView.addSubview(weatherCollectionView)
        weatherCollectionView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
        }
        
        weatherCollectionView.delegate = self
        weatherCollectionView.dataSource = self
    }
    
    func update(with modelList: [DailyWeatherModel]) {
        DispatchQueue.main.async {
            self.weathersList = modelList
            self.weatherCollectionView.reloadData()
        }
    }
}

// MARK: - Collection View Data Source And Delegate Methods

extension CollectionViewTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weathersList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = weatherCollectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as! WeatherCollectionViewCell
        cell.configure(with: weathersList[indexPath.row])
        return cell
    }
}

// MARK: - Collection View Delegate Flow Layout Methods

extension CollectionViewTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 75, height: 125)
    }
}
