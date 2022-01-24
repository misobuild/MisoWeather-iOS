//
//  ServeyTableViewCell.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/01/24.
//

import UIKit
import SnapKit

final class ServeyTableViewCell: UITableViewCell {
    
    // MARK: - subView
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18.0, weight: .bold)
        label.textColor = .textColor
        label.text = "오늘 어떤 음료가 땡기세요?☕️"
        return label
    }()
    
    private lazy var leftBackgoundView: UIView = {
        let view = UIView()
        view.backgroundColor = .backgroundColor
        view.layer.cornerRadius = 25
        return view
    }()
    
    private lazy var rightBackgoundView: UIView = {
        let view = UIView()
        view.backgroundColor = .backgroundColor
        view.layer.cornerRadius = 25
        return view
    }()
    
    private lazy var answerTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0, weight: .bold)
        label.textColor = .textColor
        label.text = "내 답변"
        return label
    }()
    
    private lazy var askTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0, weight: .bold)
        label.textColor = .textColor
        label.text = "다른 사람들은"
        return label
    }()
    
    private lazy var checkImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "check")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var questionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0, weight: .bold)
        label.textColor = .mainColor
        label.text = "프라푸치노"
        return label
    }()
    
    private lazy var pmStatusLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0, weight: .regular)
        label.textColor = .textColor
        label.text = "🌧"
        return label
    }()
    
    private lazy var minTempLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0, weight: .regular)
        label.textColor = .textColor
        label.text = "-15°"
        return label
    }()
    
    private lazy var maxTempLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0, weight: .regular)
        label.textColor = .textColor
        label.text = "0°"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ServeyTableViewCell {
    // MARK: - layout
    private func setupView(width: CGFloat = UIScreen.main.bounds.width, height: CGFloat = UIScreen.main.bounds.height) {
      
        [
            titleLabel,
            leftBackgoundView,
            rightBackgoundView,
            answerTitleLabel,
            askTitleLabel,
            checkImage,
            questionLabel,
            pmStatusLabel,
            minTempLabel,
            maxTempLabel
        ].forEach {addSubview($0)}

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(25)
            $0.leading.equalToSuperview()
        }
        leftBackgoundView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(18)
            $0.leading.equalToSuperview()
            $0.width.equalTo(width * 0.3)
            $0.bottom.equalToSuperview().inset(10)
        }
        rightBackgoundView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(18)
            $0.trailing.equalToSuperview()
            $0.width.equalTo(width * 0.56)
            $0.bottom.equalToSuperview().inset(10)
        }
        answerTitleLabel.snp.makeConstraints {
            $0.top.equalTo(leftBackgoundView).inset(16)
            $0.centerX.equalTo(leftBackgoundView)
        }
        askTitleLabel.snp.makeConstraints {
            $0.top.equalTo(answerTitleLabel)
            $0.centerX.equalTo(rightBackgoundView)
        }
        checkImage.snp.makeConstraints {
            $0.top.equalTo(answerTitleLabel.snp.bottom).offset(6)
            $0.centerX.equalTo(leftBackgoundView)
            $0.width.equalTo(46)
            $0.height.equalTo(46)
        }
        questionLabel.snp.makeConstraints {
            $0.top.equalTo(checkImage.snp.bottom).offset(9)
            $0.centerX.equalTo(leftBackgoundView)
        }
    }
}
