//
//  QnaTableVIewCell.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/01/25.
//

import SnapKit
import UIKit

final class QnaTableVIewCell: UITableViewCell {

    // MARK: - SubView
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18.0, weight: .thin)
        label.backgroundColor = .orange
        label.textColor = .textColor
        label.text = "꽁꽁 싸매자"
        return label
    }()
    
    private lazy var subTitleLable: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18.0, weight: .bold)
        label.backgroundColor = .blue
        label.textColor = .textColor
        label.text = "롱패딩"
        return label
    }()
    
    private lazy var backView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.textColor?.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 20
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.backgroundColor = .red
        view.axis = .horizontal
        view.spacing = 6
        view.distribution = .equalSpacing
        return view
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

extension QnaTableVIewCell {
    // MARK: - layout
    private func setupView(width: CGFloat = UIScreen.main.bounds.width, height: CGFloat = UIScreen.main.bounds.height) {
        
        [   backView,
            stackView
 
        ].forEach {addSubview($0)}
        [
            titleLabel,
            subTitleLable
        ].forEach {stackView.addSubview($0)}

        stackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.equalTo(44)
            $0.width.equalTo(318)
        }
        
        backView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(3)
        }

        titleLabel.snp.makeConstraints {
            $0.centerY.equalTo(stackView)
        }

        subTitleLable.snp.makeConstraints {
            $0.centerY.equalTo(stackView)
            $0.leading.equalTo(titleLabel.snp.trailing).offset(10)
        }
    }
}
