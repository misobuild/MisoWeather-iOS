//
//  ReviewViewContoller.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/01/24.
//

import UIKit
import SnapKit

final class ReviewViewContoller: UIViewController {
    
    let textViewPlaceHolder =  """
                            오늘 날씨에 대한
                            유쾌한 막내사자님의 느낌은 어떠신가요?
                            """
    
    // MARK: - SubView
    private lazy var textBackgoundView: UIView = {
        let view = UIView()
        view.backgroundColor = .backgroundColor
        view.layer.cornerRadius = 25
        return view
    }()
    
    private lazy var textView: UITextView = {
        let view = UITextView()
        view.backgroundColor = .backgroundColor
        view.delegate = self
        view.font = .systemFont(ofSize: 14)
        view.text = textViewPlaceHolder
        view.textColor = .lightGray
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
    
    @objc
    private func didTapTextView(_ sender: Any) {
        view.endEditing(true)
    }
    
    private func updateCountLabel(characterCount: Int) {
        remainCountLabel.text = "\(characterCount)/40"
    }
    
    // MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupView()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapTextView(_:)))
        view.addGestureRecognizer(tapGesture)
    }
}

extension ReviewViewContoller {
    // MARK: - Layout
    private func setupView(width: CGFloat = UIScreen.main.bounds.width, height: CGFloat = UIScreen.main.bounds.height) {
        [
            textBackgoundView,
            textView,
            remainCountLabel
        ].forEach {view.addSubview($0)}
        
        textBackgoundView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(26)
            $0.leading.equalToSuperview().inset(width * 0.06)
            $0.trailing.equalToSuperview().inset(width * 0.06)
            $0.height.equalTo(143)
        }
        
        textView.snp.makeConstraints {
            $0.top.equalTo(textBackgoundView).inset(10)
            $0.leading.equalToSuperview().inset(width * 0.1)
            $0.trailing.equalToSuperview().inset(width * 0.1)
            $0.height.equalTo(80)
        }
        remainCountLabel.snp.makeConstraints {
            $0.top.equalTo(textView.snp.bottom).inset(20)
            $0.centerX.equalToSuperview()
        }
        
        
        //        tableView.snp.makeConstraints {
        //            $0.top.equalToSuperview()
        //            $0.leading.equalToSuperview().inset(width * 0.06)
        //            $0.trailing.equalToSuperview().inset(width * 0.06)
        //            $0.bottom.equalToSuperview()
        //        }
    }
}

extension ReviewViewContoller: UITextViewDelegate {
  
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == textViewPlaceHolder {
            textView.text = nil
            textView.textColor = .textColor
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = textViewPlaceHolder
            textView.textColor = .lightGray
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text ?? ""
        guard let stringRagne = Range(range, in: currentText) else {return false}
        let updatedText = currentText.replacingCharacters(in: stringRagne, with: text)
        let characterCount = updatedText.count
        guard characterCount <= 40 else { return false }
        updateCountLabel(characterCount: characterCount)
        return true
    }
}
