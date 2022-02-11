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
    
    private func setWeatherData() {
        if let info = model.forecastInfo {
            mainScrollView.weatherView.regionLocationLabel.regionLabel.text = model.locationInfo
            mainScrollView.weatherView.emojiLabel.text = info.data.forecast.sky
            mainScrollView.weatherView.tempLabel.text = info.data.forecast.temperature + "°"
        }
    }
    
    private func setData() {
        self.mainScrollView.userButton.addTarget(self, action: #selector(settingVC), for: .touchUpInside)
        
        model.getMemberData {
            DispatchQueue.main.async {
                if let data = self.model.memberInfo {
                    self.mainScrollView.titleLabel.text = "\(data.data.regionName)의 \(data.data.nickname)님\(data.data.emoji)"
                }
            }
            self.model.getCurrentTempData {
                DispatchQueue.main.async {
                    self.setWeatherData()
                }
            }
        }
        model.getCommentData {
            DispatchQueue.main.async {
                self.mainScrollView.reviewTableView.commentList = self.model.commenttInfo
                self.mainScrollView.reviewTableView.tableView.reloadData()
            }
        }
        model.getSurveyData {
            DispatchQueue.main.async {
                self.mainScrollView.graphView.chart1View.titleLabel.text = self.model.surveyInfo[1].keyList[0]
                self.mainScrollView.graphView.chart1View.percentLabel.text = String(self.model.surveyInfo[1].valueList[0]) + "%"
                self.mainScrollView.graphView.chart2View.titleLabel.text = self.model.surveyInfo[1].keyList[1]
                self.mainScrollView.graphView.chart2View.percentLabel.text = String(self.model.surveyInfo[1].valueList[1]) + "%"
                self.mainScrollView.graphView.chart3View.titleLabel.text = self.model.surveyInfo[1].keyList[2]
                self.mainScrollView.graphView.chart3View.percentLabel.text = String(self.model.surveyInfo[1].valueList[2]) + "%"
            }
        }
    }
    
    @objc private func settingVC() {
        self.navigationController?.pushViewController(SettingViewController(), animated: true)
    }
    
    // MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        setData()
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
