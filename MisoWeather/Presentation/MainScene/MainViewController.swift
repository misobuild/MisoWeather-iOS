//
//  MainViewController.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/01/06.
//

import UIKit

final class MainViewController: UIViewController {
    
    // MARK: - subviews
    private lazy var mainScrollView: MainScrollView = {
        let view = MainScrollView()
        view.weatherView.nextButton.addTarget(MainViewController(), action: #selector(nextWeatherVC), for: .touchUpInside)
        view.serveyTitleView.nextButton.addTarget(MainViewController(), action: #selector(nextServeyVC), for: .touchUpInside)
        return view
        
    }()
    // MARK: - Private Method
    @objc private func nextWeatherVC() {
        let nextVC = WeatherViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc private func nextServeyVC() {
        let nextVC = SurveyReviewViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    // MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        
        setupView()
    }
}

extension MainViewController {
    
    // MARK: - Layout
    private func setupView(width: CGFloat = UIScreen.main.bounds.width, height: CGFloat = UIScreen.main.bounds.height) {
        
        [
            mainScrollView
        ].forEach {view.addSubview($0)}
        
        mainScrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}
