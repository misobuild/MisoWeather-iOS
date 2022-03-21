//
//  MainWeatherView.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/01/20.
//

import UIKit
import SnapKit

final class MainWeatherView: UIView {
    // MARK: - subviews
    lazy var regionLocationLabel: RegionLocationLabel = {
        let view = RegionLocationLabel()
        return view
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "chevron"), for: .normal)
        button.contentMode = .scaleAspectFit
        button.tintColor = .black
        return button
    }()
    
   lazy var emojiLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20.0)
        label.textColor = .textColor
        return label
    }()
    
    lazy var tempLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16.0, weight: .medium)
        label.textColor = .textColor
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

extension MainWeatherView {
    // MARK: - Layout
    private func setupView(width: CGFloat = UIScreen.main.bounds.width, height: CGFloat = UIScreen.main.bounds.height) {
      
        [
            regionLocationLabel,
            emojiLabel,
            tempLabel,
            nextButton
        ].forEach {addSubview($0)}
        
        regionLocationLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(width * 0.01)
            $0.width.equalTo(width * 0.53)
        }
        
        emojiLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(width * 0.19)
        }
        
        tempLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(width * 0.1)
        }
        
        nextButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(width * 0.03)
            $0.width.equalTo(24.0)
            $0.height.equalTo(24.0)
        }
    }
}
