//
//  MainWeatherTableViewCell.swift
//  OpenWeather
//
//  Created by Askar on 02.04.2022.
//

import UIKit

class MainWeatherTableViewCell: UITableViewCell {

    static let identifier = "MainWeatherTableViewCell"
    
    private lazy var topView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var bottomView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var maxTempLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var windLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var sunriseLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var minTempLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var humidityLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var sunsetLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
        setupContentView()
        setupTopView()
        setupBottomView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(with model: DailyWeatherModel) {
        DispatchQueue.main.async {
            self.maxTempLabel.text = "\(model.tempMax)°\nMax"
            self.minTempLabel.text = "\(model.tempMin)°\nMin"
            self.windLabel.text = "\(model.speed) km/h\nWind"
            self.humidityLabel.text = "\(model.humidity)%\nHumidity"
            self.sunriseLabel.text = "\(self.formatDate(date: model.sunrise))\nSunrise"
            self.sunsetLabel.text = "\(self.formatDate(date: model.sunset))\nSunset"
        }
    }
}

// MARK: - Views Setup Methods

private extension MainWeatherTableViewCell {
    func setupContentView() {
        contentView.backgroundColor = K.textColor
        contentView.layer.cornerRadius = 15
        contentView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
        }
    }
    
    func setupTopView() {
        contentView.addSubview(topView)
        topView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.5)
        }
        setupMaxTempLabel()
        setupWindLabel()
        setupSuriseLabel()
    }
    
    func setupBottomView() {
        contentView.addSubview(bottomView)
        bottomView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        setupMinTempLabel()
        setupHumidityLabel()
        setupSunsetLabel()
    }
    
    func setupMaxTempLabel() {
        topView.addSubview(maxTempLabel)
        maxTempLabel.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview()
            make.width.equalTo(topView.snp.width).multipliedBy(0.33)
        }
    }
    
    func setupWindLabel() {
        topView.addSubview(windLabel)
        windLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(maxTempLabel.snp.trailing)
            make.width.equalTo(topView.snp.width).multipliedBy(0.33)
        }
    }
    
    func setupSuriseLabel() {
        topView.addSubview(sunriseLabel)
        sunriseLabel.snp.makeConstraints { make in
            make.leading.equalTo(windLabel.snp.trailing)
            make.top.trailing.equalToSuperview()
            make.bottom.equalTo(topView.snp.bottom)
        }
    }
    
    func setupMinTempLabel() {
        bottomView.addSubview(minTempLabel)
        minTempLabel.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview()
            make.width.equalTo(bottomView.snp.width).multipliedBy(0.33)
        }
    }
    
    func setupHumidityLabel() {
        bottomView.addSubview(humidityLabel)
        humidityLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(minTempLabel.snp.trailing)
            make.width.equalTo(bottomView.snp.width).multipliedBy(0.33)
        }
    }
    
    func setupSunsetLabel() {
        bottomView.addSubview(sunsetLabel)
        sunsetLabel.snp.makeConstraints { make in
            make.top.trailing.bottom.equalToSuperview()
            make.leading.equalTo(humidityLabel.snp.trailing)
        }
    }
    
    func formatDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
    }
}
