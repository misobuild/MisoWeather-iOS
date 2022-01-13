//
//  MainViewController.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/01/06.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - subviews
    private lazy var imoticonLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 40.0, weight: .regular)
        label.text = "🐣"
        label.backgroundColor = .black
        label.clipsToBounds = true
        label.layer.cornerRadius = 27
        label.textAlignment = .center
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20.0, weight: .regular)
        label.textColor = .black
        label.numberOfLines = 0
        label.text = """
                    부산의 귀여운 병아리님,
                    오늘 날씨엔 무엇을 입으실 건가요?
                    """
        return label
    }()
    
    private lazy var weatherView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var graphView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        view.layer.cornerRadius = 10
        return view
    }()
    
    // MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.hidesBackButton = true
        
        setupView()
    }
}

extension MainViewController {
    
    // MARK: - Layout
    private func setupView() {
        [imoticonLabel, titleLabel, weatherView, graphView].forEach {view.addSubview($0)}
        
        imoticonLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(24.0)
            $0.top.equalToSuperview().inset(60.0)
            $0.width.equalTo(55.0)
            $0.height.equalTo(55.0)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(24.0)
            $0.top.equalTo(imoticonLabel.snp.bottom).offset(10.0)
        }
        
        weatherView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(15.0)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(330.0)
            $0.width.equalTo(330.0)
        }
        
        graphView.snp.makeConstraints {
            $0.top.equalTo(weatherView.snp.bottom).offset(15.0)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(330.0)
            $0.width.equalTo(330.0)
        }
    }
}
