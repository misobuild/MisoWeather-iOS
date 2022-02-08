//
//  ReviewViewContoller.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/01/24.
//

import UIKit
import SnapKit

final class ReviewViewContoller: UIViewController {
    
    let model = SurveyViewModel()
    
    // MARK: - SubView
    lazy var scrollView: ReviewScrollView = {
        let view = ReviewScrollView()
        return view
    }()
    
    // MARK: - Method
    
    private func setData() {
        model.getCommentData {
            DispatchQueue.main.async {
                self.scrollView.textView.text = self.model.placeHolderText
                self.scrollView.textView.textColor = .gray
                self.scrollView.tableView.commentList = self.model.commenttInfo
                self.scrollView.tableView.tableView.reloadData()
            }
        }
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "한줄평을 남겨주세요",
                                      message: "",
                                      preferredStyle: UIAlertController.Style.alert)
        
        let confirm = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(confirm)
        present(alert, animated: true, completion: nil)
    }
    
    @objc func post() {
        if  scrollView.textCount == 0 {
            showAlert()
        } else {
            scrollView.textCount = 0
            scrollView.updateCountLabel()
            model.setCommentData(text: scrollView.textView.text)
            model.postCommentData {
                self.setData()
            }
        }
    }
    
    @objc private func didTapTextView(_ sender: Any) {
        view.endEditing(true)
    }

    // MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        setData()
        setupView()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapTextView(_:)))
        view.addGestureRecognizer(tapGesture)
    }
}

extension ReviewViewContoller {
    // MARK: - Layout
    private func setupView(width: CGFloat = UIScreen.main.bounds.width, height: CGFloat = UIScreen.main.bounds.height) {
        
        view.backgroundColor = .white
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
