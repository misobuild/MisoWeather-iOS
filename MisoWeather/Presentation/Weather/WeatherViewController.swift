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
        return view
    }()
    // MARK: - Private Method
    
    private func fetchData() {
        model.getRealtimeForecast {
            DispatchQueue.main.async {
                self.setRealTimeData()
            }
        }
        model.getHourlyForecast {
            DispatchQueue.main.async {
                self.setHourlyData()
            }
        }
    }
    
    private func setRealTimeData() {
        if let info = model.forecastInfo {
            weatherScrollView.locationLabel.regionLabel.text = model.locationInfo
            weatherScrollView.realtimeTempLabel.realtimeTempLabel.text = String(Int(info.temperature)) + "°"
            weatherScrollView.realtimeTempLabel.emojiLabel.text = info.weather
            weatherScrollView.realtimeTempLabel.minMaxtempLabel.text = "최저 " + String(Int(info.temperatureMin)) + "°" + " / 최고 " + String(Int(info.temperatureMax)) + "°"
        }
    }
    
    private func setHourlyData() {
        if let info = model.houlryInfo {
            weatherScrollView.hourlyWeatherView.hourly = info.data.hourlyForecastList
        }
        weatherScrollView.hourlyWeatherView.hourlyWeatherView.reloadData()
    }
    
    @objc private func nextVC() {
        let nextVC = SurveyReviewViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    // MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
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
