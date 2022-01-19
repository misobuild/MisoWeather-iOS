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
    private lazy var misoLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18.0, weight: .regular)
        label.text = "MISOWEATHER"
        return label
    }()
    
    private lazy var listButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "list.bullet"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    private lazy var userButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "person.fill"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20.0, weight: .regular)
        label.textColor = .black
        label.numberOfLines = 0
        label.text = """
                    부산의 귀여운 병아리님 🐣
                    오늘 날씨엔 어떤 외투를 입으실래요?👉
                    """
        return label
    }()
    
    private lazy var weatherView: WeatherView = {
        let view = WeatherView()
        view.backgroundColor = .backgroundColor
        view.layer.cornerRadius = 25
        return view
    }()
    
    private lazy var graphView: UIView = {
        let view = UIView()
        view.backgroundColor = .backgroundColor
        view.layer.cornerRadius = 25
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
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
            misoLabel,
            listButton,
            userButton,
            titleLabel,
            weatherView,
            graphView
        ].forEach {contentView.addSubview($0)}
        
        scrollView.addSubview(contentView)
        addSubview(scrollView)
        
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(width)
            $0.height.equalTo(1900.0)
        }
  
        misoLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(width * 0.07)
            $0.top.equalToSuperview().inset(height * 0.07)
        }
        
        listButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(width * 0.17)
            $0.top.equalTo(misoLabel)
            $0.width.equalTo(24.0)
            $0.height.equalTo(24.0)
        }
        
        userButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(width * 0.07)
            $0.top.equalTo(misoLabel)
            $0.width.equalTo(24.0)
            $0.height.equalTo(24.0)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(misoLabel.snp.bottom).offset(32.0)
            $0.leading.equalTo(misoLabel)
        }
        
        weatherView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(30.0)
            $0.leading.equalToSuperview().inset(width * 0.07)
            $0.width.equalTo(width - (width * 0.14))
            $0.height.equalTo(190.0)

        }
           
        graphView.snp.makeConstraints {
            $0.top.equalTo(weatherView.snp.bottom).offset(15.0)
            $0.leading.equalToSuperview().inset(width * 0.07)
            $0.width.equalTo(width - (width * 0.14))
            $0.height.equalTo(height * 0.9)

        }
    }
}
