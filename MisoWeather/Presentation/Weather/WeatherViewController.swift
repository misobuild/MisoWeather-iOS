//
//  WeatherViewController.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/01/21.
//

import UIKit
import SnapKit

final class WeatherViewController: UIViewController {
    
    // MARK: - subviews
    private lazy var weatherScrollView: WeatherScrollView = {
        let view = WeatherScrollView()
        return view
    }()
//    // MARK: - Private Method
//    @objc private func nextVC() {
//        
//        self.navigationController?.pushViewController(nextVC, animated: true)
//    }
    // MARK: - LifeCycle Methods
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
      
        view.addSubview(weatherScrollView)
        weatherScrollView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}
