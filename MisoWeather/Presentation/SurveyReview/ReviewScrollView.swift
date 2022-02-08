//
//  ReviewScrollView.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/01/25.
//

import UIKit
import SnapKit

class ReviewScrollView: UIView {
    
    let model = SurveyViewModel()
    var textCount = 0
    
    let scrollView = UIScrollView()
    let contentView = UIView()

//    // MARK: - SubView
    private lazy var textBackgoundView: UIView = {
        let view = UIView()
        view.backgroundColor = .backgroundColor
        view.layer.cornerRadius = 25
        return view
    }()

    lazy var textView: UITextView = {
        let view = UITextView()
        view.backgroundColor = .backgroundColor
        view.delegate = self
        view.font = .systemFont(ofSize: 14)
        view.text = model.placeHolderText
        view.textColor = .systemGray2
        return view
    }()

    lazy var remainCountLabel: UILabel = {
        let label = UILabel()
        label.text = "0/40"
        label.font = .systemFont(ofSize: 10)
        label.textColor = .lightGray
        label.textAlignment = .center
        return label
    }()

    private lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        return view
    }()

    private lazy var postButton: CustomButton = {
        let button = CustomButton(type: .post)
        button.addTarget(ReviewViewContoller(), action: #selector(ReviewViewContoller.post), for: .touchUpInside)
        return button
    }()

    lazy var tableView: ReviewTableView = {
        let view = ReviewTableView()
        view.frontColor = UIColor.backgroundColor ?? .gray
        view.backColor = UIColor.white
        return view
    }()

    // MARK: - Method
    
    func updateCountLabel(){
        remainCountLabel.text = "\(textCount)/40"
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        scrollView.delegate = self
        scrollView.showsVerticalScrollIndicator = false
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ReviewScrollView {
    
    // MARK: - Layout
    private func setupView(width: CGFloat = UIScreen.main.bounds.width, height: CGFloat = UIScreen.main.bounds.height) {
        [
            textBackgoundView,
            textView,
            remainCountLabel,
            lineView,
            postButton,
            tableView
        ].forEach {contentView.addSubview($0)}
        
        scrollView.addSubview(contentView)
        addSubview(scrollView)
        
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(width)
            $0.height.equalTo(height * 1.35)
        }
        
        textBackgoundView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(26)
            $0.leading.equalToSuperview().inset(width * 0.06)
            $0.trailing.equalToSuperview().inset(width * 0.06)
            $0.height.equalTo(143)
        }
        textView.snp.makeConstraints {
            $0.top.equalTo(textBackgoundView).inset(20)
            $0.leading.equalToSuperview().inset(width * 0.13)
            $0.trailing.equalToSuperview().inset(width * 0.13)
            $0.height.equalTo(80)
        }
        remainCountLabel.snp.makeConstraints {
            $0.top.equalTo(textView.snp.bottom).inset(17)
            $0.trailing.equalTo(textBackgoundView.snp.trailing).inset(25)
        }
        lineView.snp.makeConstraints {
            $0.bottom.equalTo(textBackgoundView.snp.bottom).inset(37)
            $0.leading.equalTo(textBackgoundView).inset(20)
            $0.trailing.equalTo(textBackgoundView).inset(20)
            $0.height.equalTo(1)
        }
        postButton.snp.makeConstraints {
            $0.trailing.equalTo(lineView)
            $0.top.equalTo(lineView).inset(6)
            $0.width.equalTo(70)
            $0.height.equalTo(25)
        }
        tableView.snp.makeConstraints {
            $0.top.equalTo(textBackgoundView.snp.bottom).offset(7)
            $0.leading.equalToSuperview().inset(width * 0.045)
            $0.trailing.equalToSuperview().inset(width * 0.045)
            $0.bottom.equalToSuperview()
        }
    }
}

extension ReviewScrollView: UITextViewDelegate {

    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == model.placeHolderText {
            textView.text = nil
            textView.textColor = .textColor
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text =  model.placeHolderText
            textView.textColor = .gray
        }
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text ?? ""
        guard let stringRagne = Range(range, in: currentText) else {return false}
        let updatedText = currentText.replacingCharacters(in: stringRagne, with: text)
        textCount = updatedText.count
        guard textCount <= 40 else { return false }
        
        return true
    }
}
