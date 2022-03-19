//
//  HourlyWeatherViewCell.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/01/21.
//

import UIKit
import SnapKit

final class HourlyWeatherViewCell: UICollectionViewCell {
    
    // MARK: - subviews
    private lazy var tempLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0, weight: .regular)
        label.textColor = .textColor
        label.text = "-10°"
        return label
    }()
    
    private lazy var emojiLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 30.0, weight: .regular)
        label.textColor = .textColor
        label.text = "🌦"
        return label
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0, weight: .thin)
        label.textColor = .textColor
        label.text = "16시"
        return label
    }()

    func configureData(hourly: HourlyForecastList) {
        tempLabel.text = String(Int(hourly.temperature)) + "°"
        emojiLabel.text = hourly.weather
        timeLabel.text = hourly.forecastTime[11..<13] + "시"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HourlyWeatherViewCell {
    
    // MARK: - Layout
    private func setupView(width: CGFloat = UIScreen.main.bounds.width, height: CGFloat = UIScreen.main.bounds.height) {
        
        [   tempLabel,
            emojiLabel,
            timeLabel
            
        ].forEach {addSubview($0)}
        
        tempLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
        }
        emojiLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(tempLabel.snp.bottom).offset(5.0)
        }
        timeLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(emojiLabel.snp.bottom).offset(5.0)
        }
    }
}
