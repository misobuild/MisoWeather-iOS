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
        guard let loginType = UserDefaults.standard.string(forKey: "loginType") else { return view }
        view.weatherView.nextButton.addTarget(MainViewController(), action: #selector(nextWeatherVC), for: .touchUpInside)
        view.serveyTitleView.nextButton.addTarget(MainViewController(), action: #selector(nextServeyVC), for: .touchUpInside)
        if loginType == "nonLogin" {
            view.locationButton.addTarget(MainViewController(), action: #selector(coverVC), for: .touchUpInside)
        } else {
            view.locationButton.addTarget(MainViewController(), action: #selector(nextRegionVC), for: .touchUpInside)
        }
        return view
    }()
    
    // MARK: - Private Method
    @objc private func coverVC() {
        let nextVC = CoverViewContoller()
        nextVC.modalPresentationStyle = .overFullScreen
        self.present(nextVC, animated: true)
    }
    
    @objc private func nextRegionVC() {
        let nextVC = BigRegionViewController()
        nextVC.backScreen = .main
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc private func nextWeatherVC() {
        let nextVC = WeatherViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc private func nextServeyVC() {
        let nextVC = SurveyReviewViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc private func nextLoginVC() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc private func settingVC() {
        self.navigationController?.pushViewController(SettingViewController(), animated: true)
    }
    
    private func setWeatherData() {
        if let info = model.forecastInfo {
            mainScrollView.weatherView.regionLocationLabel.regionLabel.text = model.locationInfo
            mainScrollView.weatherView.emojiLabel.text = info.weather
            mainScrollView.weatherView.tempLabel.text = String(Int(info.temperature)) + "°"
        }
    }
    
    private func setData() {
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
    private func nonLogin() {
        setData()
        UserDefaults.standard.set("1", forKey: "regionID")
        mainScrollView.titleLabel.text = "전국의 수줍은 힐끔 방문자님!👤"
        model.getRealtimeForecast {
            DispatchQueue.main.async {
                self.setWeatherData()
            }
        }
    }
    
    private func login() {
        setData()
        model.getMemberData {
            DispatchQueue.main.async {
                if let data = self.model.memberInfo {
                    self.mainScrollView.titleLabel.text = "\(data.data.regionName)의 \(data.data.nickname)님\(data.data.emoji)"
                }
            }
            
            self.model.getRealtimeForecast {
                DispatchQueue.main.async {
                    self.setWeatherData()
                }
            }
        }
    }
    
    private func configure() {
        guard let loginType = UserDefaults.standard.string(forKey: "loginType") else {return}
        if loginType == "nonLogin" {
            nonLogin()
            mainScrollView.loginButton.isHidden = false
            mainScrollView.loginButton.addTarget(self, action: #selector(nextLoginVC), for: .touchUpInside)
            self.mainScrollView.userButton.addTarget(self, action: #selector(coverVC), for: .touchUpInside)
        } else {
            login()
            mainScrollView.loginButton.isHidden = true
            self.mainScrollView.userButton.addTarget(self, action: #selector(settingVC), for: .touchUpInside)
        }
    }
    
    // MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
        configure()
    }
}

extension MainViewController {
    
    // MARK: - Layout
    private func setupView(width: CGFloat = UIScreen.main.bounds.width, height: CGFloat = UIScreen.main.bounds.height) {
        
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
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
