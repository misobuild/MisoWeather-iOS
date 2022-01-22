//
//  MainWeatherView.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/01/20.
//

import UIKit
import SnapKit

final class MainWeatherView: UIView {
    
    private lazy var regionLocationLabel: RegionLocationLabel = {
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
    
    private lazy var mainTempLabel: RealtimeTempLabel = {
        let view = RealtimeTempLabel()
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .red
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
            nextButton,
            mainTempLabel
        ].forEach {addSubview($0)}
        
        regionLocationLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(22.0)
            $0.leading.equalToSuperview().inset(width * 0.03)
        }
        
        nextButton.snp.makeConstraints {
            $0.top.equalTo(regionLocationLabel)
            $0.trailing.equalToSuperview().inset(width * 0.03)
            $0.width.equalTo(24.0)
            $0.height.equalTo(24.0)
        }
        
        mainTempLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(68.0)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(150.0)
            $0.height.equalTo(64.0)
        }
    }
}
