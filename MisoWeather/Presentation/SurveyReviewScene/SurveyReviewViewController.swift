//
//  SurveyReviewViewController.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/01/23.
//

import UIKit
import SnapKit

final class SurveyReviewViewController: UIViewController {
    
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
    
    private lazy var locationButton: RegionButton = {
        let button = RegionButton()
        return button
    }()
    
    // MARK: - Private Method
    private var currentIndex: Int {
        guard let viewController = pageViewController.viewControllers?.first else {return 0}
            return dataViewControllers.firstIndex(of: viewController) ?? 0
    }

    @objc func switchView(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            print(currentIndex)
            pageViewController.setViewControllers([dataViewControllers[0]], direction: .reverse, animated: true, completion: nil)
        } else {
            print(currentIndex)
            pageViewController.setViewControllers([dataViewControllers[1]], direction: .forward, animated: true, completion: nil)
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
        } else {
            segmentedControl.selectedSegmentIndex = 1
        }
    }
}

extension SurveyReviewViewController {
    // MARK: - Layout
    private func setupView(width: CGFloat = UIScreen.main.bounds.width, height: CGFloat = UIScreen.main.bounds.height) {
        [titleLabel, locationButton, pageViewController.view, segmentedControl].forEach {view.addSubview($0)}
        addChild(pageViewController)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(110)
            $0.leading.equalToSuperview().inset(width * 0.06)
        }
        
        locationButton.snp.makeConstraints {
            $0.top.equalTo(titleLabel)
            $0.trailing.equalToSuperview().inset(width * 0.06)
            $0.width.equalTo(80)
            $0.height.equalTo(22)
        }
        
        segmentedControl.snp.makeConstraints {
            $0.top.equalTo(locationButton.snp.bottom).offset(20)
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
