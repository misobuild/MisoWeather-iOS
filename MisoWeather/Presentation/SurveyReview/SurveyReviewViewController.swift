//
//  SurveyReviewViewController.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/01/23.
//

import UIKit
import SnapKit

final class SurveyReviewViewController: UIViewController, UITableViewDelegate {
    
    let model = MainViewModel()
    
    // MARK: - SubView
    private lazy var segmentedControl: UISegmentedControl = {
        let segment = UISegmentedControl(items: ["오늘의 사람들", "날씨 한 줄 평"])
        segment.selectedSegmentTintColor = .mainColor
        segment.backgroundColor = .backgroundColor
        segment.selectedSegmentIndex = 0

        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray]
        let titleTextAttributes1 = [NSAttributedString.Key.foregroundColor: UIColor.white]
        segment.setTitleTextAttributes(titleTextAttributes, for: .normal)
        segment.setTitleTextAttributes(titleTextAttributes1, for: .selected)
        segment.addTarget(self, action: #selector(switchView), for: .valueChanged)
        return segment
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24.0, weight: .bold)
        label.textColor = .black
        label.text = "날씨 이야기"
        return label
    }()
    
    private lazy var locationButton: RegionButton = {
        let button = RegionButton()
        guard let loginType = UserDefaults.standard.string(forKey: "loginType") else {return button}
        if loginType == "nonLogin" {
            button.regionButton.setTitle("서울", for: .normal)
            button.regionButton.addTarget(self, action: #selector(coverVC), for: .touchUpInside)
        } else {
            if let regionName = UserDefaults.standard.string(forKey: "selectRegionName") {
                button.regionButton.setTitle(regionName, for: .normal)
                button.regionButton.addTarget(self, action: #selector(nextVC), for: .touchUpInside)
            }
        }
        return button
    }()
    
    // MARK: - Methods
    @objc private func coverVC() {
        let nextVC = CoverViewContoller()
        nextVC.modalPresentationStyle = .overFullScreen
        self.present(nextVC, animated: true)
    }
    
    @objc private func nextVC() {
        let nextVC = BigRegionViewController()
        nextVC.backScreen = .survey
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    private lazy var  surveyViewController: SurveyViewController = {
        let viewController = SurveyViewController()
        return viewController
    }()
    
     private lazy var  reviewViewController: ReviewViewContoller = {
        let viewController = ReviewViewContoller()
        return viewController
    }()
    
    private lazy var  dataViewControllers: [UIViewController] = {
        return [surveyViewController, reviewViewController]
    }()
    
    private lazy var pageViewController: UIPageViewController = {
        let viewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        viewController.dataSource = self
        viewController.delegate = self
        return viewController
    }()
    
    // MARK: - Private Method
    private var currentIndex: Int {
        guard let viewController = pageViewController.viewControllers?.first else {return 0}
            return dataViewControllers.firstIndex(of: viewController) ?? 0
    }

    @objc func switchView(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            locationButton.isHidden = false
            pageViewController.setViewControllers([dataViewControllers[0]], direction: .reverse, animated: true, completion: nil)
        } else {
            self.locationButton.isHidden = true
            pageViewController.setViewControllers([dataViewControllers[1]], direction: .forward, animated: true, completion: nil)
        }
    }
    
    @objc func updateNotificationReceived(notification: Notification) {
        if let regionName = UserDefaults.standard.string(forKey: "selectRegionName") {
            locationButton.regionButton.setTitle(regionName, for: .normal)
        }
    }
    
    // MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        if let firstVC = dataViewControllers.first {
            pageViewController.setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
        setupView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let regionName = UserDefaults.standard.string(forKey: "selectRegionName") {
            locationButton.regionButton.setTitle(regionName, for: .normal)
        }
        setupView()
        NotificationCenter.default.addObserver(self, selector: #selector(updateNotificationReceived(notification:)), name: .updateNotification, object: nil)
    }
}

extension SurveyReviewViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = dataViewControllers.firstIndex(of: viewController) else { return nil }
        let previousIndex = index - 1
        if previousIndex < 0 {
            return nil
        }
        return dataViewControllers[previousIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = dataViewControllers.firstIndex(of: viewController) else { return nil }
        let nextIndex = index + 1
        if nextIndex == dataViewControllers.count {
            return nil
        }
        return dataViewControllers[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if currentIndex == 0 {
            segmentedControl.selectedSegmentIndex = 0
            locationButton.isHidden = false
        } else {
            segmentedControl.selectedSegmentIndex = 1
            self.locationButton.isHidden = true
        }
    }
}

extension SurveyReviewViewController {
    // MARK: - Layout
    private func setupView(width: CGFloat = UIScreen.main.bounds.width, height: CGFloat = UIScreen.main.bounds.height) {
        view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.barTintColor = .white
        // 라인 선 없애기
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        [titleLabel, locationButton, pageViewController.view, segmentedControl].forEach {view.addSubview($0)}
        addChild(pageViewController)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(100)
            $0.leading.equalToSuperview().inset(width * 0.06)
        }
        
        locationButton.snp.makeConstraints {
            $0.top.equalTo(titleLabel)
            $0.trailing.equalToSuperview().inset(width * 0.06)
            $0.width.equalTo(80)
            $0.height.equalTo(22)
        }
        
        segmentedControl.snp.makeConstraints {
            $0.top.equalTo(locationButton.snp.bottom).offset(21)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(width * 0.75)
            $0.height.equalTo(height * 0.04)
        }
        
        pageViewController.view.snp.makeConstraints {
            $0.top.equalTo(segmentedControl.snp.bottom).offset(3)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}
