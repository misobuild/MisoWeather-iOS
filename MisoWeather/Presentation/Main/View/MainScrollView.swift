//
//  MainScrollView.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/01/20.
//
import UIKit
import SnapKit

final class MainScrollView: UIView {
    
    let scrollView = UIScrollView()

    // 스크롤 뷰 안에는 스크롤이 되는 컨텐트 뷰가 존재해야 함
    let contentView = UIView()
    
    // MARK: - subviews
    private lazy var logoView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "logoPurple")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var misoLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18.0, weight: .regular)
        label.text = "MISOWEATHER"
        return label
    }()
    
    lazy var locationButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "location"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    lazy var userButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "person.fill"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    private lazy var greetingLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 19.0, weight: .light)
        label.textColor = .black
        label.numberOfLines = 0
        label.text = "안녕하세요!"
        return label
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20.0, weight: .heavy)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    lazy var weatherView: MainWeatherView = {
        let view = MainWeatherView()
        view.backgroundColor = .backgroundColor
        view.layer.cornerRadius = 20
        return view
    }()
    
    private lazy var serveyBackView: UIView = {
        let view = UIView()
        view.backgroundColor = .backgroundColor
        view.layer.cornerRadius = 25
        return view
    }()
    
    lazy var serveyTitleView: MainServeyTitleView = {
        let view = MainServeyTitleView()
        return view
    }()
    
    lazy var graphView: MainServeyView = {
        let view = MainServeyView()
        return view
    }()
    
    private lazy var reviewTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "오늘 날씨 어때요?"
        label.textColor = .textColor
        label.font = .systemFont(ofSize: 18.0, weight: .bold)
        return label
    }()
    
    lazy var reviewTableView: ReviewTableView = {
        let view = ReviewTableView()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        scrollView.showsVerticalScrollIndicator = false
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MainScrollView {
    
    // MARK: - Layout
    private func setupView(width: CGFloat = UIScreen.main.bounds.width, height: CGFloat = UIScreen.main.bounds.height) {
        [
            logoView,
            misoLabel,
            locationButton,
            userButton,
            greetingLabel,
            titleLabel,
            weatherView,
            serveyBackView,
            serveyTitleView,
            graphView,
            reviewTitleLabel,
            reviewTableView
        ].forEach {contentView.addSubview($0)}
        
        scrollView.addSubview(contentView)
        addSubview(scrollView)
        
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(width)
            $0.height.equalTo(950)
        }
        logoView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(30.0)
            $0.leading.equalToSuperview().inset(width * 0.06)
            $0.width.equalTo(20)
            $0.height.equalTo(20)
        }
        misoLabel.snp.makeConstraints {
            $0.centerY.equalTo(logoView)
            $0.leading.equalTo(logoView.snp.trailing).offset(4)
        }
        
        locationButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(width * 0.12)
            $0.centerY.equalTo(userButton)
            $0.width.equalTo(width * 0.09)
            $0.height.equalTo(width * 0.09)
        }
        
        userButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(width * 0.06)
            $0.top.equalTo(logoView)
            $0.width.equalTo(width * 0.06)
            $0.height.equalTo(width * 0.06)
        }
        
        greetingLabel.snp.makeConstraints {
            $0.top.equalTo(logoView.snp.bottom).offset(32.0)
            $0.leading.equalTo(logoView)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(greetingLabel.snp.bottom).offset(7.0)
            $0.leading.equalTo(greetingLabel)
        }
        
        weatherView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(23.0)
            $0.leading.equalToSuperview().inset(width * 0.05)
            $0.width.equalTo(width - (width * 0.1))
            $0.height.equalTo(42.0)
        }
        
        serveyBackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(weatherView.snp.bottom).offset(15.0)
            $0.width.equalTo(width - (width * 0.1))
            $0.height.equalTo(680)
        }
        
        serveyTitleView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(serveyBackView).inset(25.0)
            $0.width.equalTo(width * 0.84)
            $0.height.equalTo(height * 0.03)
        }
           
        graphView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(serveyTitleView.snp.bottom).offset(15.0)
            $0.width.equalTo(width * 0.84)
            $0.height.equalTo(128.0)
        }
        
        reviewTitleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(width * 0.10)
            $0.top.equalTo(graphView.snp.bottom).offset(30.0)
        }
        
        reviewTableView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(reviewTitleLabel.snp.bottom).offset(15.0)
            $0.width.equalTo(width * 0.87)
            $0.height.equalTo(400)
        }
    }
}
