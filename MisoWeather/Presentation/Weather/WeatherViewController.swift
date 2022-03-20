//
//  WeatherViewController.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/01/21.
//

import UIKit
import SnapKit

final class WeatherViewController: UIViewController {
    
    let model = WeatherViewModel()
    
    // MARK: - subviews
    private lazy var weatherScrollView: WeatherScrollView = {
        let view = WeatherScrollView()
        view.chatButton.addTarget(self, action: #selector(nextVC), for: .touchUpInside)
        return view
    }()
    
    // MARK: - Private Method
    private func setData() {
        model.getRealtimeForecast {
            DispatchQueue.main.async {
                self.setRealTimeData()
                self.setHumidityData()
                self.setWindSpeedData()
            }
        }
        model.getHourlyForecast {
            DispatchQueue.main.async {
                self.setHourlyData()
            }
        }
        model.getDailyForecast {
            DispatchQueue.main.async {
                self.setDailyData()
                self.setPopData()
            }
        }
    }
    
    private func setRealTimeData() {
        if let info = model.forecastInfo {
            weatherScrollView.locationLabel.regionLabel.text = model.locationInfo
            weatherScrollView.realtimeTempLabel.realtimeTempLabel.text = String(Int(info.temperature)) + "°"
            weatherScrollView.realtimeTempLabel.emojiLabel.text = info.weather
            weatherScrollView.realtimeTempLabel.minMaxtempLabel.text = "최저 " + String(Int(info.temperatureMin)) + "°" + " /  최고 " + String(Int(info.temperatureMax)) + "°"
        }
    }
    
    private func setHumidityData() {
        if let info = model.forecastInfo {
            weatherScrollView.humidityView.emojiLabel.text = info.humidityIcon
            weatherScrollView.humidityView.humidityLabel.text = String(info.humidity) + "%"
        }
    }
    
    private func setWindSpeedData() {
        if let info = model.forecastInfo {
            weatherScrollView.windSpeedView.emojiLabel.text = info.windSpeedIcon
            weatherScrollView.windSpeedView.descriptionLabel.text = info.windSpeedComment
        }
    }
    
    private func setHourlyData() {
        if let info = model.houlryInfo {
            weatherScrollView.hourlyWeatherView.hourly = info.data.hourlyForecastList
        }
        weatherScrollView.hourlyWeatherView.hourlyWeatherView.reloadData()
    }
    
    private func setDailyData() {
        if let info = model.dailyInfo {
            weatherScrollView.dailyTableView.daily = info.data.dailyForecastList
        }
        weatherScrollView.dailyTableView.tableView.reloadData()
    }
    
    private func setPopData() {
        if let info = model.dailyInfo {
            weatherScrollView.precipitationView.emojiLabel.text = info.data.popIcon
            weatherScrollView.precipitationView.precipitationLabel.text = String(info.data.rain) + "%"
            weatherScrollView.precipitationView.descriptionLabel.text = "시간당 " + String(info.data.rain) + "mm"
        }
    }
    
    @objc private func nextVC() {
        let nextVC = SurveyReviewViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    // MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
        setupView()
    }
}

extension WeatherViewController {
    // MARK: - Layout
    private func setupView(width: CGFloat = UIScreen.main.bounds.width, height: CGFloat = UIScreen.main.bounds.height) {
        view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.barTintColor = .white
        // 라인 선 없애기
        self.navigationController?.navigationBar.shadowImage = UIImage()
      
        view.addSubview(weatherScrollView)
        weatherScrollView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}
