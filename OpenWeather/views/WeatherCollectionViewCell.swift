//
//  WeatherCollectionViewCell.swift
//  OpenWeather
//
//  Created by Askar on 03.04.2022.
//

import UIKit

class WeatherCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "WeatherCollectionViewCell"
    
    private lazy var dayLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textAlignment = .center
        label.textColor = K.textColor
        return label
    }()
    
    private lazy var weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var tempsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textAlignment = .center
        label.textColor = K.textColor
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.layer.cornerRadius = 5
        contentView.backgroundColor = .systemPurple
        
        setupDayLabel()
        setupWeatherImageView()
        setupTempsLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: DailyWeatherModel) {
        DispatchQueue.main.async {
            self.dayLabel.text = self.formatDate(date: model.date)
            self.weatherImageView.image = UIImage(systemName: model.weatherName)
            self.tempsLabel.text = "\(model.tempMin)° - \(model.tempMax)°"
        }
    }
}

// MARK: - Views Setup Methods

private extension WeatherCollectionViewCell {
    
    func setupDayLabel() {
        contentView.addSubview(dayLabel)
        dayLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
    }
    
    func setupWeatherImageView() {
        contentView.addSubview(weatherImageView)
        weatherImageView.snp.makeConstraints { make in
            make.top.equalTo(dayLabel.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(40)
        }
    }
    
    func setupTempsLabel() {
        contentView.addSubview(tempsLabel)
        tempsLabel.snp.makeConstraints { make in
            make.top.equalTo(weatherImageView.snp.bottom).offset(15)
            make.leading.trailing.bottom.equalToSuperview().inset(5)
        }
    }
    
    func formatDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E"
        return dateFormatter.string(from: date)
    }
}
