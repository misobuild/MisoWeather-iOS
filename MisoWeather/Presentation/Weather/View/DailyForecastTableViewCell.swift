//
//  DailyForecastTableViewCell.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/01/22.
//

import UIKit
import SnapKit

final class DailyForecastTableViewCell: UITableViewCell {
    
    // MARK: - subView
    lazy var dayLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0, weight: .regular)
        label.textColor = .textColor
        label.text = "오늘"
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0, weight: .thin)
        label.textColor = .textColor
        label.text = "12/24"
        return label
    }()
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15.0, weight: .regular)
        label.textColor = .textColor
        label.text = "☀️"
        return label
    }()
    
    private lazy var poStatusLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15.0, weight: .thin)
        label.textColor = .textColor
        label.text = "☔️"
        return label
    }()
    
    private lazy var poLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0, weight: .regular)
        label.textColor = .textColor
        label.textAlignment = .right
        label.text = "20%"
        return label
    }()
    
    private lazy var minTempLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0, weight: .regular)
        label.textColor = .textColor
        label.textAlignment = .right
        label.text = "-15°"
        return label
    }()
    
    private lazy var maxTempLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0, weight: .regular)
        label.textColor = .textColor
        label.textAlignment = .right
        label.text = "0°"
        return label
    }()
    
    func configureData(daily: DailyForecastList) {
        let dateStr = daily.forecastTime
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let converterDate = dateFormatter.date(from: dateStr)
        
        let myDateFormatter = DateFormatter()
        myDateFormatter.dateFormat = "E MM/dd "
        myDateFormatter.locale = Locale(identifier: "ko_KR")
        let convertStr = myDateFormatter.string(from: converterDate!)

        dayLabel.text = convertStr[0..<1]
        dateLabel.text = convertStr[2..<7]
        statusLabel.text = daily.weather
        poStatusLabel.text = daily.popIcon
        poLabel.text = String(daily.pop) + "%"
        minTempLabel.text = String(Int(daily.minTemperature)) + "°"
        maxTempLabel.text =  String(Int(daily.maxTemperature)) +  "°"
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .backgroundColor
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DailyForecastTableViewCell {
    // MARK: - layout
    private func setupView(width: CGFloat = UIScreen.main.bounds.width, height: CGFloat = UIScreen.main.bounds.height) {
      
        [
            dayLabel,
            dateLabel,
            statusLabel,
            poStatusLabel,
            poLabel,
            minTempLabel,
            maxTempLabel
        ].forEach {addSubview($0)}

        dayLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(width * 0.05)
            $0.width.equalTo(26.0)
        }
        dateLabel.snp.makeConstraints {
            $0.leading.equalTo(dayLabel.snp.trailing).offset(width * 0.01)
            $0.width.equalTo(40.0)
        }
        statusLabel.snp.makeConstraints {
            $0.leading.equalTo(dateLabel.snp.trailing).offset(width * 0.07)
        }
        poStatusLabel.snp.makeConstraints {
            $0.leading.equalTo(statusLabel.snp.trailing).offset(width * 0.06)
        }
        poLabel.snp.makeConstraints {
            $0.leading.equalTo(poStatusLabel.snp.trailing).offset(width * 0.01)
            $0.width.equalTo(40)
        }
        minTempLabel.snp.makeConstraints {
            $0.leading.equalTo(poLabel.snp.trailing).offset(width * 0.05)
            $0.width.equalTo(25)
        }
        maxTempLabel.snp.makeConstraints {
            $0.leading.equalTo(minTempLabel.snp.trailing).offset(width * 0.03)
            $0.width.equalTo(25)
        }
    }
}
