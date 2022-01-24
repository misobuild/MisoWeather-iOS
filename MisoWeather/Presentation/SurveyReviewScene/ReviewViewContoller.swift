//
//  ReviewViewContoller.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/01/24.
//

import UIKit
import SnapKit

final class ReviewViewContoller: UIViewController {
    
    let name = "유쾌한 막내사자"
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
       // view.delegate = self
        view.font = .systemFont(ofSize: 14)
        view.text = textViewPlaceHolder
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
        let view = CustomButton(type: .post)
        return view
    }()
    
    private lazy var tableView: ReviewTableView = {
        let view = ReviewTableView()
        view.frontColor = UIColor.backgroundColor ?? .gray
        view.backColor = UIColor.white
        view.row = 20
        return view
    }()
    
    private lazy var scrollView: ReviewScrollView = {
        let view = ReviewScrollView()
        return view
    }()
    
    // MARK: - Method
    @objc private func didTapTextView(_ sender: Any) {
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
          
            scrollView
        ].forEach {view.addSubview($0)}
        
        scrollView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}
