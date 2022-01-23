//
//  SurveyViewController.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/01/23.
//

import UIKit
import SnapKit

class SurveyViewController: UIViewController {
    // MARK: - SubView
    
    let surveyView = SurveyView()
    let reviewView = ReviewView()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "asdf"
        label.font = .systemFont(ofSize: 20.0)
        label.textColor = .black
        return label
    }()
 
    
    private lazy var segment: UISegmentedControl = {
        let segment = UISegmentedControl(items: ["오늘의 사람들", "날씨 한 줄 평"])
        segment.layer.cornerRadius = 25
        segment.layer.cornerCurve = CALayerCornerCurve.circular
        segment.selectedSegmentTintColor = .mainColor
        segment.selectedSegmentIndex = 0
        segment.backgroundColor = .backgroundColor
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray]
        segment.setTitleTextAttributes(titleTextAttributes, for:.normal)
        
        let titleTextAttributes1 = [NSAttributedString.Key.foregroundColor: UIColor.white]
        segment.setTitleTextAttributes(titleTextAttributes1, for:.selected)
        
        //segment.addTarget(self, action: #selector(switchView), for: .valueChanged)
        segment.addTarget(self, action: #selector(switchView), for: .valueChanged)
        return segment
    }()
        
    @objc func switchView(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            surveyView.alpha = 1
            reviewView.alpha = 0
            print(sender.selectedSegmentIndex)
        } else {
            surveyView.alpha = 0
            reviewView.alpha = 1
            print(sender.selectedSegmentIndex)
        }
    }
    
    // MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
    }
}

extension SurveyViewController {
    // MARK: - Layout
    private func setupView() {
        [label, segment, surveyView, reviewView].forEach {view.addSubview($0)}
        label.snp.makeConstraints {
            $0.top.equalToSuperview().inset(30)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(200)
            $0.height.equalTo(50)
        }
        segment.snp.makeConstraints {
            $0.top.equalTo(label.snp.bottom).inset(50)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(200)
            $0.height.equalTo(50)
        }
        
        surveyView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(100)
        }
        reviewView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(100)
        }
    }
}

class SurveyView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .yellow
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class ReviewView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .blue
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
