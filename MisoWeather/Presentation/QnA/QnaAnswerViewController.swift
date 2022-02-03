//
//  QnaAnswerViewController.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/02/04.
//

import UIKit
import SnapKit

class QnaAnswerViewController: UIViewController {
    
    // MARK: - SubView
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = """
                    오늘 같은 날씨엔
                    역시 롱패딩!
                    """
        label.font = .systemFont(ofSize: 28)
        guard let text = label.text else { return UILabel() }
        let attributeString = NSMutableAttributedString(string: text)
        let font = UIFont.systemFont(ofSize: 18, weight: .heavy)
        attributeString.addAttribute(.font, value: font, range: (text as NSString).range(of: "롱패딩!"))
        return label
    }()
    
    private lazy var thankyouLabel: UILabel = {
        let label = UILabel()
        label.text = "답변 감사해요!"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    
    // MARK: - LifeCycle Method
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
}

extension QnaAnswerViewController {
    // MARK: - Layout
    private func setupView(width: CGFloat = UIScreen.main.bounds.width, height: CGFloat = UIScreen.main.bounds.height) {
        [
            titleLabel,
            thankyouLabel
        ].forEach {view.addSubview($0)}
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(100)
            $0.trailing.equalToSuperview().inset(28)
            $0.leading.equalToSuperview().inset(28)
            $0.height.equalTo(215)
        }

    }
}
