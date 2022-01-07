//
//  NicknameSelectViewController.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/01/05.
//

import UIKit
import SnapKit

class NicknameSelectViewController: UIViewController {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25.0, weight: .light)
        label.textColor = .black
        label.text = "안녕하세요."
        return label
    }()
    
    private lazy var nicknameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 27.0, weight: .black)
        label.textColor = .black
        label.text = "부산의 귀여운 병아리"
        return label
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25.0, weight: .light)
        label.textColor = .black
        label.text = " 님!"
        return label
    }()
    
    private lazy var imoticonLable: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 150.0)
        label.textColor = .black
        label.text = "🐣"
        return label
    }()
    
    private lazy var refreshButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("닉네임 새로 받기", for: .normal)
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.adjustsImageWhenHighlighted = true
        button.addTarget(self, action: #selector(nextVC), for: .touchUpInside)
        return button
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13.0)
        label.numberOfLines = 0
        label.textColor = .gray
        label.textAlignment = .center
        label.text = """
                    닉네임 새로 받기를 하면 새로운 닉네임이 랜덤으로 부여돼요!
                    한 번 부여된 닉네임은 바꿀 수 없어요!
                    """
        return label
    }()
    
    private lazy var confirmButton: customButton = {
        let button = customButton()
        button.setTitle("이걸로 결정했어요!", for: .normal)
        button.addTarget(self, action: #selector(nextVC), for: .touchUpInside)
        return button
    }()
    
    @objc func nextVC() {
        self.navigationController?.pushViewController(MainViewController(), animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setup()
    }
}

extension NicknameSelectViewController {
    private func setup() {
        [titleLabel, nicknameLabel, subTitleLabel, imoticonLable, refreshButton, descriptionLabel, confirmButton].forEach{view.addSubview($0)}
        
        titleLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(24.0)
            $0.top.equalToSuperview().inset(170.0)
        }
        nicknameLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(24.0)
            $0.top.equalTo(titleLabel.snp.bottom).offset(5.0)
        }
        subTitleLabel.snp.makeConstraints{
            $0.top.equalTo(nicknameLabel)
            $0.leading.equalTo(nicknameLabel.snp.trailing).inset(1.0)
        }
        imoticonLable.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(nicknameLabel.snp.bottom).offset(30.0)
        }
        refreshButton.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(imoticonLable.snp.bottom).offset(30.0)
            $0.leading.equalToSuperview().inset(24.0)
            $0.trailing.equalToSuperview().inset(24.0)
        }
        descriptionLabel.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(refreshButton.snp.bottom).offset(10.0)
        }
        confirmButton.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(refreshButton.snp.bottom).offset(100.0)
            $0.leading.equalToSuperview().inset(24.0)
            $0.trailing.equalToSuperview().inset(24.0)
            $0.height.equalTo(50.0)
        }
    }
}
