//
//  PrecipitationView.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/01/21.
//

import UIKit
import SnapKit

final class PrecipitationView: UIView {
    
    // MARK: - subView
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0, weight: .regular)
        label.textColor = .textColor
        label.text = "강수"
        return label
    }()
    
    private lazy var emojiLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 36.0, weight: .regular)
        label.textColor = .textColor
        label.text = "☔️"
        return label
    }()
    
    private lazy var precipitationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24.0, weight: .bold)
        label.textColor = .textColor
        label.text = "80%"
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0, weight: .thin)
        label.textColor = .textColor
        label.text = "시간당 10mm"
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

extension PrecipitationView {
    // MARK: - layout
    private func setupView(width: CGFloat = UIScreen.main.bounds.width, height: CGFloat = UIScreen.main.bounds.height) {
      
        [
            titleLabel,
            emojiLabel,
            precipitationLabel,
            descriptionLabel
        ].forEach {addSubview($0)}

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(13.0)
            $0.leading.equalToSuperview().inset(width * 0.05)
        }
        
        emojiLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(12.0)
            $0.leading.equalTo(titleLabel)
        }
        
        precipitationLabel.snp.makeConstraints {
            $0.top.equalTo(emojiLabel)
            $0.leading.equalTo(emojiLabel.snp.trailing).offset(width * 0.015)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(precipitationLabel.snp.bottom).offset(5.0)
            $0.leading.equalTo(precipitationLabel)
        }
    }
}
