//
//  ReviewViewContoller.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/01/24.
//

import UIKit
import SnapKit

final class ReviewViewContoller: UIViewController {
    var isScrollEnd = false
    let model = SurveyReviewViewModel()
    var textCount = 0

    // MARK: - SubView
    let refreshControl = UIRefreshControl()
    
    private lazy var textBackgoundView: UIView = {
        let view = UIView()
        view.backgroundColor = .backgroundColor
        view.layer.cornerRadius = 25
        return view
    }()

    lazy var textView: UITextView = {
        let view = UITextView()
        view.backgroundColor = .backgroundColor
        view.isScrollEnabled = true
        view.showsVerticalScrollIndicator = true
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
        view.tableView.delegate = self
        view.backColor = UIColor.white
        
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        view.tableView.refreshControl = refreshControl

        return view
    }()
    
    // MARK: - Private Method
    
    private func setData() {
        model.getCommentData {
            DispatchQueue.main.async {
                self.textView.text = self.model.placeHolderText
                self.textView.textColor = .gray
                self.tableView.commentList = self.model.commenttInfo
                self.tableView.tableView.reloadData()
            }
        }
    }
    
    private func updateCountLabel() {
        remainCountLabel.text = "\(textCount)/40"
    }
    
    private func createSpinnerFooter() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        
        return footerView
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "한줄평을 남겨주세요",
                                      message: "",
                                      preferredStyle: UIAlertController.Style.alert)
        
        let confirm = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(confirm)
        present(alert, animated: true, completion: nil)
    }
    
    @objc private func post() {
        if  textCount == 0 {
            showAlert()
        } else {
            textCount = 0
            updateCountLabel()
            didTapTextView((Any).self)
            let textString = textView.text.replacingOccurrences(of: "\n", with: " ")
            model.setCommentData(text: textString)
            model.postCommentData {
                self.setData()
            }
        }
    }

    @objc private func didTapTextView(_ sender: Any) {
        view.endEditing(true)
    }
    
    @objc private func refresh() {
        refreshControl.endRefreshing()
        setData()
    }
    
    // MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setData()
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
            remainCountLabel,
            lineView,
            postButton,
            tableView
        ].forEach {view.addSubview($0)}
        
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

extension ReviewViewContoller: UITextViewDelegate {

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
        updateCountLabel()
        guard textCount < 40 else {
            return false
        }
        return true
    }
}

extension ReviewViewContoller: UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let boundsHeight = tableView.tableView.bounds.size.height // 테이블 뷰의 고정된 높이 ex) 600
        let offsetY = tableView.tableView.contentOffset.y // 스크롤한 높이 ex) 500
        let contentHeight = tableView.tableView.contentSize.height // 테이블 뷰의 전체 높이 ex) 1000

        //  보이는크기 + 스크롤한크기가 테이블 전체 크기를 넘어서면 데이터 가져오기
        if boundsHeight + offsetY > contentHeight {
            self.tableView.tableView.tableFooterView = createSpinnerFooter()
            if model.isMoreData {
                if !isScrollEnd {
                    self.isScrollEnd = true
                    model.getMoreCommentData {
                        DispatchQueue.main.async {
                            self.tableView.tableView.tableFooterView = nil
                            self.tableView.commentList = self.model.commenttInfo
                            self.tableView.tableView.reloadData()
                            self.isScrollEnd = false
                        }
                    }
                }
            } else {
                self.tableView.tableView.tableFooterView = nil
            }
        }
    }
}
