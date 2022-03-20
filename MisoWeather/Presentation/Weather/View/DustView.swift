//
//  DustView.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/01/21.
//

import UIKit
import SnapKit

final class DustView: UIView {
    
    // MARK: - subviews
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0, weight: .regular)
        label.textColor = .textColor
        label.text = "미세먼지"
        return label
    }()
    
    lazy var emojiLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 30.0, weight: .regular)
        label.textColor = .textColor
        label.text = "😊"
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 4
        view.distribution = .equalSpacing
        return view
    }()
    
    lazy var PMLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0, weight: .bold)
        label.textColor = .textColor
        label.text = "21"
        return label
    }()
    
    lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0, weight: .thin)
        label.textColor = .textColor
        label.text = "좋음"
        return label
    }()
    
    private lazy var ultraTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0, weight: .regular)
        label.textColor = .textColor
        label.text = "초미세먼지"
        return label
    }()
    
    lazy var ultraEmojiLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 30.0, weight: .regular)
        label.textColor = .textColor
        label.text = "😊"
        return label
    }()
    
    private lazy var ultraStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 4
        view.distribution = .equalSpacing
        return view
    }()
    
    lazy var ultraPMLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0, weight: .bold)
        label.textColor = .textColor
        label.text = "26"
        return label
    }()
    
    lazy var ultraStatusLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0, weight: .thin)
        label.textColor = .textColor
        label.text = "나쁨"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        backgroundColor = .backgroundColor
        layer.cornerRadius = 20
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DustView {
    
    // MARK: - Layout
    private func setupView(width: CGFloat = UIScreen.main.bounds.width, height: CGFloat = UIScreen.main.bounds.height) {
        
        [   titleLabel,
            emojiLabel,
            stackView,
            ultraTitleLabel,
            ultraEmojiLabel,
            ultraStackView
        ].forEach {addSubview($0)}
        
        [PMLabel, statusLabel].forEach {stackView.addArrangedSubview($0)}
        [ultraPMLabel, ultraStatusLabel].forEach {ultraStackView.addArrangedSubview($0)}
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15)
            $0.leading.equalToSuperview().offset(15)
        }
        
        emojiLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.leading.equalToSuperview().offset(25)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(emojiLabel.snp.bottom).offset(5)
            $0.leading.equalToSuperview().offset(15)
        }
        
        ultraTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel)
            $0.leading.equalToSuperview().offset(80)
        }
        
        ultraEmojiLabel.snp.makeConstraints {
            $0.top.equalTo(emojiLabel)
            $0.leading.equalToSuperview().offset(95)
        }

        ultraStackView.snp.makeConstraints {
            $0.top.equalTo(stackView)
            $0.leading.equalToSuperview().offset(90)
        }
    }
}
