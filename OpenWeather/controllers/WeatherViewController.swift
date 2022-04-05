//
//  ViewController.swift
//  OpenWeather
//
//  Created by Askar on 20.03.2022.
//

import UIKit
import SnapKit
import CoreLocation

final class WeatherViewController: UIViewController {
    
    private var weathers: [DailyWeatherModel] = []
    private var weatherModel: AllWeatherModel?
    
    private var locationManager = CLLocationManager()
    private var weatherManager = WeatherManager()
    
    private lazy var weatherTableView: UITableView = {
        let tableView = UITableView()
        tableView.allowsSelection = false
        tableView.backgroundColor = .clear
        tableView.tintColor = K.textColor
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private lazy var tableViewHeaderView: UITableViewHeaderFooterView = {
        let headerView = UITableViewHeaderFooterView()
        headerView.tintColor = K.textColor
        return headerView
    }()
    
    private lazy var currentLocationButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "location.fill"), for: .normal)
        button.tintColor = K.textColor
        button.addTarget(self, action: #selector(currentLocationButtonPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .minimal
        searchBar.searchTextField.textColor = K.textColor
        searchBar.placeholder = "Enter city"
        let emptyImage = UIImage()
        searchBar.setImage(emptyImage, for: .search, state: .normal)
        return searchBar
    }()
    
    private lazy var searchButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.tintColor = K.textColor
        button.addTarget(self, action: #selector(searchButtonPressed), for: .touchUpInside)
        return button
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        setGradientBackground()
        super.viewDidAppear(animated)
        setupLocation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = UIColor(red: 158/255, green: 66/255, blue: 158/255, alpha: 1)
        weatherManager.delegate = self
        
        addCurrentLocationButton()
        addSearchBar()
        addSearchButton()
        addWeatherTableView()
    }
}

// MARK: - Views Setup Methods

private extension WeatherViewController {
    
    func addCurrentLocationButton() {
        view.addSubview(currentLocationButton)
        currentLocationButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(60)
            make.leading.equalToSuperview().offset(20)
            make.height.width.equalTo(30)
        }
        currentLocationButton.imageView?.snp.makeConstraints({ make in
            make.edges.equalToSuperview()
        })
    }
    
    func addSearchBar() {
        view.addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.leading.equalTo(currentLocationButton.snp.trailing)
            make.height.equalTo(50)
        }
        searchBar.delegate = self
    }
    
    func addSearchButton() {
        view.addSubview(searchButton)
        searchButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(60)
            make.trailing.equalToSuperview().inset(20)
            make.leading.equalTo(searchBar.snp.trailing)
            make.height.width.equalTo(30)
        }
        searchButton.imageView?.snp.makeConstraints({ make in
            make.edges.equalToSuperview()
        })
    }
    
    func addWeatherTableView() {
        view.addSubview(weatherTableView)
        weatherTableView.snp.makeConstraints { make in
            make.top.equalTo(searchButton.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        let headerView = WeatherHeaderView()
        weatherTableView.tableHeaderView = headerView
        
        weatherTableView.dataSource = self
        weatherTableView.delegate = self
    }
 
    func setupLocation() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func setGradientBackground() {
        let colorTop =  UIColor(red: 163/255, green: 88/255, blue: 215/255, alpha: 1).cgColor
        let colorBottom = UIColor(red: 156/255, green: 55/255, blue: 128/255, alpha: 1).cgColor
                    
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
                
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
}

// MARK: - Table View Data Source Methods

extension WeatherViewController: UITableViewDataSource {
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = MainWeatherTableViewCell()
            cell.backgroundColor = .clear
            if weathers.isEmpty {
                return UITableViewCell()
            } else {
                cell.update(with: weathers[0])
                return cell
            }
        case 1:
            let cell = CollectionViewTableViewCell()
            cell.backgroundColor = .clear
            cell.update(with: weathers)
            return cell
        default:
            print("nice")
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let headerView = weatherTableView.tableHeaderView as? WeatherHeaderView {
            if let safeWeatherModel = weatherModel {
                headerView.update(with: safeWeatherModel)
                return headerView
            } else {
                print("no weather model")
            }
        } else {
            print("no header view")
        }
        return UITableViewHeaderFooterView()
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        if section == 0 {
//            return "Next 5 days"
//        } else {
//            return ""
//        }
//    }
}

// MARK: - Table View Delegate Methods

extension WeatherViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 175
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 135
    }
}

// MARK: - Search Bar Delegate Methods

extension WeatherViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let cityName = searchBar.text {
            weatherManager.fetchRequest(cityName: cityName)
        }
    }
    
    @objc func searchButtonPressed(sender: UIButton!) {
        if let cityName = searchBar.text {
            weatherManager.fetchRequest(cityName: cityName)
        }
    }
}

// MARK: - Location Manager Delegate Methods

extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            print("Retrieving location error")
            return
        }
        locationManager.stopUpdatingLocation()
        weatherManager.fetchRequest(
            lon: location.coordinate.longitude,
            lat: location.coordinate.latitude
        )
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    @objc func currentLocationButtonPressed(sender: UIButton!) {
        locationManager.requestLocation()
    }
}

// MARK: - Weather Manager Delegate Methods

extension WeatherViewController: WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: AllWeatherModel) {
        DispatchQueue.main.async {
            self.weathers = weather.dailyWeatherList
            self.weatherModel = weather
            self.weatherTableView.reloadData()
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
