//
//  RealtimeTempLabel.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/01/21.
//

import UIKit
import SnapKit

final class RealtimeTempLabel: UIView {
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 8
        view.distribution = .equalSpacing
        return view
    }()
    
    private lazy var emojiLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 55.0, weight: .regular)
        label.textColor = .black
        label.text = "☀️"
        return label
    }()
    
    private lazy var realtimeTempLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 48.0, weight: .regular)
        label.textColor = .black
        label.text = "-10°"
        return label
    }()
    
    private lazy var minMaxtempLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16.0, weight: .regular)
        label.textColor = .black
        label.text = "최저 -15°/ 최고 0°"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RealtimeTempLabel {
    
    // MARK: - Layout
    private func setupView(width: CGFloat = UIScreen.main.bounds.width, height: CGFloat = UIScreen.main.bounds.height) {
      
        [
            stackView,
            minMaxtempLabel
        ].forEach {addSubview($0)}
        
        [emojiLabel, realtimeTempLabel].forEach {stackView.addArrangedSubview($0)}
        
        stackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(150.0)
            $0.height.equalTo(64.0)
        }
        
        minMaxtempLabel.snp.makeConstraints {
            $0.top.equalTo(realtimeTempLabel.snp.bottom).offset(12.0)
            $0.centerX.equalToSuperview()
        }
    }
}
