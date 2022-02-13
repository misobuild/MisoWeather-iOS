//
//  QnaView.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/02/11.
//

import UIKit
import SnapKit
import Lottie

class QnaView: UIView {
    
    var item = ""
    // MARK: - SubView
    private lazy var animationView: AnimationView = {
       let view = AnimationView(name: "lf20_tnqgtf5o")
        view.frame = self.bounds
        view.contentMode = .scaleAspectFit
        view.play()
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = """
                    오늘 같은 날씨엔
                    역시 \(item)!
                    """
        label.font = .systemFont(ofSize: 28)
        
        guard let text = label.text else { return UILabel() }
        let attributeString = NSMutableAttributedString(string: text)
        let font = UIFont.systemFont(ofSize: 28, weight: .heavy)
        attributeString.addAttribute(.font, value: font, range: (text as NSString).range(of: "롱패딩!"))
        label.attributedText = attributeString
        return label
    }()
    
    private lazy var thankyouLabel: UILabel = {
        let label = UILabel()
        label.text = "답변 감사해요!"
        label.font = .systemFont(ofSize: 24)
        return label
    }()
    
    // MARK: - LifeCycle Method

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension QnaView {
    // MARK: - Layout
    private func setupView(width: CGFloat = UIScreen.main.bounds.width, height: CGFloat = UIScreen.main.bounds.height) {
        
        self.backgroundColor = .white
        
        [
            animationView,
            titleLabel,
            thankyouLabel
        ].forEach {self.addSubview($0)}
        
        animationView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.width.equalTo(200)
            $0.height.equalTo(200)
        }
        
        titleLabel.snp.makeConstraints {
            $0.bottom.equalTo(animationView.snp.top).inset(-40)
            $0.centerX.equalToSuperview()
        }
        
        thankyouLabel.snp.makeConstraints {
            $0.top.equalTo(animationView.snp.bottom).offset(40)
            $0.centerX.equalToSuperview()
        }
    }
}
