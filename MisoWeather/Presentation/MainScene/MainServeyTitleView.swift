//
//  MainServeyTitleView.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/01/22.
//

import UIKit
import SnapKit

final class MainServeyTitleView: UIView {
    
    var region = "서울"
    
    // MARK: - subviews
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = """
                    오늘은 뭘 입을까?
                    """
        label.textColor = .textColor
        label.font = .systemFont(ofSize: 18.0, weight: .bold)
        return label
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "chevron"), for: .normal)
        button.contentMode = .scaleAspectFit
        button.tintColor = .black
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MainServeyTitleView {
    // MARK: - Layout
    private func setupView(width: CGFloat = UIScreen.main.bounds.width, height: CGFloat = UIScreen.main.bounds.height) {
      
        [
            titleLabel,
            nextButton
        ].forEach {addSubview($0)}
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(width * 0.02)
            $0.top.equalToSuperview()
        }
        
        nextButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.width.equalTo(24.0)
            $0.height.equalTo(24.0)
        }
    }
}
