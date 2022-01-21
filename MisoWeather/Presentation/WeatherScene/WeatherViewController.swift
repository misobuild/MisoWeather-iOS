//
//  WeatherViewController.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/01/21.
//

import UIKit
import SnapKit

class WeatherViewController: UIViewController {
    
    private lazy var locationLabel: RegionLocationLabel = {
        let view = RegionLocationLabel()
        return view
    }()
    
    private lazy var realtimeTempLabel: RealtimeTempLabel = {
        let label = RealtimeTempLabel()
        return label
    }()
    
    private lazy var chatButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: "chatButton"), for: .normal)
        
        return button
    }()
    
//    // MARK: - Private Method
//    @objc private func nextVC() {
//        
//        self.navigationController?.pushViewController(nextVC, animated: true)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupView()
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
      
        [
            locationLabel,
            realtimeTempLabel,
            chatButton
        ].forEach {view.addSubview($0)}

        locationLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(113.0)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(185.0)
        }
        
        realtimeTempLabel.snp.makeConstraints {
            $0.top.equalTo(locationLabel.snp.bottom).offset(25.00)
            $0.centerX.equalToSuperview()
        }
        
        chatButton.snp.makeConstraints {
            $0.top.equalTo(locationLabel.snp.bottom).offset(161.0)
            $0.height.equalTo(height * 0.07)
            $0.width.equalTo(width - (width * 0.14))
            $0.centerX.equalToSuperview()
        }
    }
}
