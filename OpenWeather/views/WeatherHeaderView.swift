//
//  WeatherHeaderView.swift
//  OpenWeather
//
//  Created by Askar on 02.04.2022.
//

import UIKit

class WeatherHeaderView: UIView {
    
    private lazy var cityNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 27.5, weight: .bold)
        label.textColor = K.textColor
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(15)
        label.textColor = K.textColor
        return label
    }()
    
    private lazy var weatherIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var tempLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(50)
        label.textColor = K.textColor
        label.textAlignment = .center
        return label
    }()
    
    private lazy var descLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = K.textColor
        label.font = label.font.withSize(15)
        return label
    }()
    
    private lazy var weatherInfoView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var tempInfoView: UIView = {
        let view = UIView()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        setupCityNameLabel()
        setupDateLabel()
        setupWeatherInfoView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(with model: AllWeatherModel) {
        DispatchQueue.main.async {
            self.cityNameLabel.text = model.cityName + ", " + model.countryName
            self.dateLabel.text = self.formatDate(date: model.dailyWeatherList[0].date)
            self.weatherIconImageView.image = UIImage(systemName: model.dailyWeatherList[0].weatherName)
            self.tempLabel.text = model.dailyWeatherList[0].temp + "°"
            self.descLabel.text = model.dailyWeatherList[0].desctiption
        }
    }
}

// MARK: - Views Setup Methods

private extension WeatherHeaderView {
    func setupCityNameLabel() {
        addSubview(cityNameLabel)
        cityNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.trailing.equalToSuperview().offset(20)
            make.height.equalTo(40)
        }
    }
    
    func setupDateLabel() {
        addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(cityNameLabel.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview().offset(20)
            make.height.equalTo(20)
        }
    }
    
    func setupWeatherIconImageView() {
        weatherInfoView.addSubview(weatherIconImageView)
        weatherIconImageView.snp.makeConstraints { make in
            make.top.equalTo(weatherInfoView.snp.top)
            make.leading.equalTo(weatherInfoView.snp.leading).offset(20)
            make.height.width.equalTo(weatherInfoView.snp.height)
        }
    }
    
    func setupWeatherInfoView() {
        addSubview(weatherInfoView)
        weatherInfoView.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(175)
        }
        
        setupWeatherIconImageView()
        setupTempInfoView()
    }
    
    func setupTempInfoView() {
        weatherInfoView.addSubview(tempInfoView)
        tempInfoView.snp.makeConstraints { make in
            make.height.equalTo(weatherIconImageView.snp.width)
            make.leading.equalTo(weatherIconImageView.snp.trailing).offset(20)
            make.trailing.equalToSuperview().inset(20)
        }
        setupTempLabel()
        setupDescLabel()
    }
    
    func setupTempLabel() {
        tempInfoView.addSubview(tempLabel)
        tempLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().inset(50)
            make.leading.equalToSuperview()
            make.height.equalTo(tempInfoView.snp.height).multipliedBy(0.5)
        }
    }
    
    func setupDescLabel() {
        tempInfoView.addSubview(descLabel)
        descLabel.snp.makeConstraints { make in
            make.top.equalTo(tempLabel.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview().inset(50)
            make.bottom.equalToSuperview().inset(30)
        }
    }
    
    func formatDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        return dateFormatter.string(from: date)
    }
}
