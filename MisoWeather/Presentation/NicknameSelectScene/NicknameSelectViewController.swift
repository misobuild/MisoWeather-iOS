//
//  NicknameSelectViewController.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/01/05.
//

import UIKit
import SnapKit

final class NicknameSelectViewController: UIViewController {

    var recivedNickName: NicknameModel.Data = NicknameModel.Data(nickname: "", emoji: "")
    var model = NicknameSelectViewModel()
    
    private var region = ""

    // MARK: - Subviews
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
        return label
    }()
    
    private lazy var imoticonLable: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 170.0)
        label.textColor = .black
        return label
    }()
    
    private lazy var refreshButton: UIButton = {
        let button = UIButton(type: .system)
        let text = "닉네임 새로 받기"
        button.setTitleColor(.darkGray, for: .normal)
        button.setTitle(text, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18.0)
        let attributeString = NSMutableAttributedString(string: text)
        attributeString.addAttribute(.underlineStyle, value: 1, range: NSRange.init(location: 0, length: text.count))
        button.titleLabel?.attributedText = attributeString
        button.addTarget(self, action: #selector(fetchNicknameData), for: .touchUpInside)
        return button
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0)
        label.numberOfLines = 0
        label.textColor = .gray
        label.textAlignment = .center
        label.text = """
                    닉네임이 마음에 들지 않으면 새로 받아보세요!
                    한 번 결정한 닉네임은 바꿀 수 없어요
                    """
        return label
    }()
    
    private lazy var confirmButton: CustomButton = {
        let button = CustomButton(type: .register)
        button.addTarget(self, action: #selector(register), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Private Method
    @objc private func fetchNicknameData() {
        let urlString = URL.nickname
        model.fetchNicknameData(urlString: urlString) {
            self.recivedNickName = self.model.reciveNickname
            DispatchQueue.main.async {
                self.setData()
            }
        }
    }
    
    private func setData() {
        self.nicknameLabel.text = "\(self.region)의 \(self.recivedNickName.nickname)님!"
        self.imoticonLable.text = "\(self.recivedNickName.emoji)"
        self.animate()
    }
    
    private func configureData() {
        if let region = UserInfo.shared.region {
            self.region = region
        }
        model.setData(data: self.recivedNickName)
    }
    
    private func nextVC() {
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(MainViewController())
    }
    
    @objc private func register() {
        model.register {(result: Result<String, APIError>) in
            switch result {
            case .failure(let error):
                print("error: \(error)")
                
            case .success:
                DispatchQueue.main.async {
                    self.nextVC()
                }
            }
        }
    }
    
    private func animate() {
        imoticonLable.alpha = 0
        nicknameLabel.alpha = 0
        imoticonLable.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        UIView.animate(withDuration: 0.8, animations: {
            self.imoticonLable.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.nicknameLabel.alpha = 1
            self.imoticonLable.alpha = 1
        })
    }
    
    // MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureData()
        setData()
        animate()
        setupView()
    }
}

extension NicknameSelectViewController {
    
    // MARK: - Layout
    private func setupView(width: CGFloat = UIScreen.main.bounds.width, height: CGFloat = UIScreen.main.bounds.height) {
        
        view.backgroundColor = .white
        self.navigationController?.navigationBar.topItem?.title = ""
        
        [titleLabel, nicknameLabel, imoticonLable, refreshButton, descriptionLabel, confirmButton].forEach {view.addSubview($0)}
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(width * 0.10)
            $0.trailing.equalToSuperview().inset(width * 0.10)
            $0.top.equalToSuperview().inset(height * 0.2)
        }
        
        nicknameLabel.snp.makeConstraints {
            $0.leading.equalTo(titleLabel)
            $0.top.equalTo(titleLabel.snp.bottom).offset(5.0)
        }
        
        imoticonLable.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(nicknameLabel.snp.bottom).offset(height * 0.06)
        }
        
        refreshButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(imoticonLable.snp.bottom).offset(height * 0.06)
            $0.width.equalTo(200)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(refreshButton.snp.bottom).offset(10.0)
        }
        
        confirmButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(height * 0.1)
            $0.width.equalTo(width - (width * 0.14))
            $0.height.equalTo((width - (width * 0.23)) * 0.15)
        }
    }
}
