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
        label.font = .systemFont(ofSize: 18.0, weight: .light)
        label.textColor = .textColor
        label.textAlignment = .center
        label.layer.cornerRadius = 20
        
//        guard let text = label.text else { return UILabel() }
//        let attributeString = NSMutableAttributedString(string: text)
//        let font = UIFont.systemFont(ofSize: 18, weight: .heavy)
//        attributeString.addAttribute(.font, value: font, range: (text as NSString).range(of: "롱패딩"))
//        label.attributedText = attributeString
        
        return label
    }()
    
    private lazy var backView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.textColor?.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 20
        return view
    }()
    
    private lazy var checkView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "check")
        return view
    }()
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                
                titleLabel.textColor = .buttonTextColor
                backView.layer.borderColor = UIColor.mainColor?.cgColor
                backView.layer.masksToBounds = true
                backView.backgroundColor = .mainColor
            } else {
                titleLabel.textColor = .black
                backView.layer.borderColor = UIColor.black.cgColor
                backView.backgroundColor = .white
            }
        }
    }
    
    func setup(data: SurveyAnswerList) {
        let text = data.answerDescription + " " + data.answer
        titleLabel.text = text
        let attributeString = NSMutableAttributedString(string: text)
        let font = UIFont.systemFont(ofSize: 18, weight: .heavy)
        attributeString.addAttribute(.font, value: font, range: (text as NSString).range(of: data.answer))
        titleLabel.attributedText = attributeString
         
        setupView()
    }
}

extension QnaTableVIewCell {
    // MARK: - layout
    private func setupView(width: CGFloat = UIScreen.main.bounds.width, height: CGFloat = UIScreen.main.bounds.height) {
        
        [   backView,
            titleLabel,
            checkView
        ].forEach {addSubview($0)}

        backView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(3)
            $0.bottom.equalToSuperview().inset(3)
            $0.trailing.equalToSuperview().inset(3)
            $0.leading.equalToSuperview().inset(3)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalTo(backView)
            $0.center.equalTo(backView)
        }
        
        checkView.snp.makeConstraints {
            $0.centerY.equalTo(backView)
            $0.trailing.equalTo(titleLabel.snp.leading).inset(-10)
        }
    }
}
