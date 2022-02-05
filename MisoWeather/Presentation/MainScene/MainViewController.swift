//
//  MainViewController.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/01/06.
//

import UIKit

final class MainViewController: UIViewController {
    
    let model = MainViewModel()
    
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
    
    private func setData() {
        
        model.getMemberData {
            DispatchQueue.main.async {
                if let data = self.model.memberInfo {
                    self.mainScrollView.titleLabel.text = "\(data.data.regionName)의 \(data.data.nickname)님\(data.data.emoji)"
                }
            }
        }
    }
    
    // MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        setData()
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
