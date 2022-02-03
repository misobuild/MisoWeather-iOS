//
//  ReviewTableViewCell.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/01/23.
//

import UIKit
import SnapKit

final class ReviewTableViewCell: UITableViewCell {
    
    // MARK: - subView
    
    var frontColor = UIColor.white
    var backColor = UIColor.backgroundColor
    
    lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = frontColor
        view.layer.cornerRadius = 20
        return view
    }()
    
    lazy var emojiLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 34.0)
        label.textColor = .textColor
        label.text = "🐯"
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12.0, weight: .regular)
        label.textColor = .textColor
        label.text = "부산의 춤추는 레몬호랑이"
        return label
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12.0, weight: .thin)
        label.textColor = .textColor
        label.text = "07:49"
        return label
    }()
    
    private lazy var reviewLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12.0, weight: .thin)
        label.textColor = .textColor
        label.numberOfLines = 0
        label.text = "이번주만 지나면 좀 나아진다니까 참아봅시다...오늘 뭔가 오뎅탕 땡기네요"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = backColor
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ReviewTableViewCell {
    // MARK: - layout
    private func setupView(width: CGFloat = UIScreen.main.bounds.width, height: CGFloat = UIScreen.main.bounds.height) {
      
        [
            backView
        ].forEach {addSubview($0)}
        
        [   emojiLabel,
            nameLabel,
            timeLabel,
            reviewLabel
        ].forEach {backView.addSubview($0)}
   
        backView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(5)
        }

        emojiLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20.0)
            $0.centerY.equalToSuperview()
        }
        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(emojiLabel.snp.trailing).offset(10.0)
            $0.top.equalTo(emojiLabel)
        }
        timeLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel)
            $0.trailing.equalToSuperview().inset(22.0)
        }
        reviewLabel.snp.makeConstraints {
            $0.leading.equalTo(nameLabel)
            $0.top.equalTo(nameLabel.snp.bottom).offset(2)
            $0.width.equalTo(200)
        }
    }
}
