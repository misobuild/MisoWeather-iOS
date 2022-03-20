//
//  WeatherScrollView.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/01/22.
//

import UIKit
import SnapKit

class WeatherScrollView: UIView {
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    // MARK: - subView
    lazy var locationLabel: RegionLocationLabel = {
        let view = RegionLocationLabel()
        return view
    }()
    
    lazy var realtimeTempLabel: RealtimeTempLabel = {
        let label = RealtimeTempLabel()
        return label
    }()
    
    lazy var chatButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: "chatButton"), for: .normal)
        return button
    }()
    
    lazy var hourlyWeatherView: HourlyForecastView = {
        let view = HourlyForecastView()
        return view
    }()
    
    private lazy var particulateMatterView: ParticulateMatterView = {
        let view = ParticulateMatterView()
        return view
    }()
    
    lazy var precipitationView: PrecipitationView = {
        let view = PrecipitationView()
        return view
    }()
    
    lazy var dailyTableView: DailyForecastTableView = {
        let view = DailyForecastTableView()
        return view
    }()
    
    lazy var windSpeedView: WindSpeedView = {
        let view = WindSpeedView()
        return view
    }()
    
    lazy var humidityView: HumidityView = {
        let view = HumidityView()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        scrollView.showsVerticalScrollIndicator = false

        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension WeatherScrollView {
    
    // MARK: - Layout
    private func setupView(width: CGFloat = UIScreen.main.bounds.width, height: CGFloat = UIScreen.main.bounds.height) {
        [
            locationLabel,
            realtimeTempLabel,
            chatButton,
            hourlyWeatherView,
            particulateMatterView,
            precipitationView,
            dailyTableView,
            windSpeedView,
            humidityView
        ].forEach {contentView.addSubview($0)}
        
        scrollView.addSubview(contentView)
        addSubview(scrollView)
        
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(width)
            $0.height.equalTo(height * 1.35)
        }
  
        locationLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10.0)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(185.0)
        }
        
        realtimeTempLabel.snp.makeConstraints {
            $0.top.equalTo(locationLabel.snp.bottom).offset(25.00)
            $0.centerX.equalToSuperview()
        }
        
        chatButton.snp.makeConstraints {
            $0.top.equalTo(locationLabel.snp.bottom).offset(150.0)
            $0.height.equalTo(height * 0.07)
            $0.width.equalTo(width - (width * 0.14))
            $0.centerX.equalToSuperview()
        }
        
        hourlyWeatherView.snp.makeConstraints {
            $0.top.equalTo(chatButton.snp.bottom).offset(10.0)
            $0.height.equalTo(150.0)
            $0.width.equalTo(width - (width * 0.14))
            $0.centerX.equalToSuperview()
        }
        
        particulateMatterView.snp.makeConstraints {
            $0.top.equalTo(hourlyWeatherView.snp.bottom).offset(10.0)
            $0.height.equalTo(105.0)
            $0.width.equalTo(width * 0.42)
            $0.leading.equalToSuperview().inset(width * 0.07)
        }
        
        precipitationView.snp.makeConstraints {
            $0.top.equalTo(particulateMatterView)
            $0.height.equalTo(105.0)
            $0.width.equalTo(width * 0.42)
            $0.trailing.equalToSuperview().inset(width * 0.07)
        }
        
        dailyTableView.snp.makeConstraints {
            $0.top.equalTo(precipitationView.snp.bottom).offset(10.0)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(340)
            $0.width.equalTo(width - (width * 0.14))
        }
        
        windSpeedView.snp.makeConstraints {
            $0.top.equalTo(dailyTableView.snp.bottom).offset(10.0)
            $0.height.equalTo(105.0)
            $0.width.equalTo(width * 0.42)
            $0.leading.equalToSuperview().inset(width * 0.07)
        }
        
        humidityView.snp.makeConstraints {
            $0.top.equalTo(windSpeedView)
            $0.height.equalTo(105.0)
            $0.width.equalTo(width * 0.42)
            $0.trailing.equalToSuperview().inset(width * 0.07)
        }
    }
}
