//
//  WeatherView.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/01/20.
//

import UIKit
import SnapKit

final class WeatherView: UIView {
    
    private lazy var location: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "location")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var regionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16.0, weight: .regular)
        label.textColor = .black
        label.text = "서울시 강남구 신사동"
        return label
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "chevron"), for: .normal)
        button.contentMode = .scaleAspectFit
        button.tintColor = .black
        return button
    }()
    
    private lazy var emojiLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 55.0, weight: .regular)
        label.textColor = .black
        label.text = "☀️"
        return label
    }()
    
    private lazy var mainTempLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 48.0, weight: .regular)
        label.textColor = .black
        label.text = "-10°"
        return label
    }()
    
    private lazy var tempLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16.0, weight: .regular)
        label.textColor = .black
        label.text = "최저 -15°/ 최고 0°"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension WeatherView {
    
    // MARK: - Layout
    private func setupView(width: CGFloat = UIScreen.main.bounds.width, height: CGFloat = UIScreen.main.bounds.height) {
      
        [
            location,
            regionLabel,
            button,
            emojiLabel,
            mainTempLabel,
            tempLabel
        ].forEach {addSubview($0)}
        
        location.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(width * 0.03)
            $0.top.equalToSuperview().inset(22.0)
            $0.width.equalTo(width * 0.06)
            $0.height.equalTo(width * 0.06)
        }
        
        regionLabel.snp.makeConstraints {
            $0.top.equalTo(location).offset(2.0)
            $0.leading.equalToSuperview().inset(width * 0.1)
        }
        
        button.snp.makeConstraints {
            $0.top.equalTo(location)
            $0.trailing.equalToSuperview().inset(width * 0.03)
            $0.width.equalTo(width * 0.06)
            $0.height.equalTo(width * 0.06)
        }
        
        emojiLabel.snp.makeConstraints {
            $0.top.equalTo(location.snp.bottom).offset(23.0)
            $0.leading.equalToSuperview().inset(width * 0.22)
        }
        
        mainTempLabel.snp.makeConstraints {
            $0.top.equalTo(emojiLabel).inset(5.0)
            $0.leading.equalTo(emojiLabel.snp.trailing).offset(7.0)
        }
        
        tempLabel.snp.makeConstraints {
            $0.top.equalTo(mainTempLabel.snp.bottom).offset(12.0)
            $0.centerX.equalToSuperview()
        }
    }
}
