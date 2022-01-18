//
//  NicknameSelectViewController.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/01/05.
//

import UIKit
import SnapKit

class NicknameSelectViewController: UIViewController {
    weak var delegate: nickNameSendDelegate?
    private var recivedNickName: NicknameModel.Data = NicknameModel.Data(nickname: "", emoji: "")
    
    private let region = UserInfo.shared.region!
    
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
        label.text = "\(region)의 \(recivedNickName.nickname)님!"
        return label
    }()

    private lazy var imoticonLable: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 170.0)
        label.textColor = .black
        label.text = "\(recivedNickName.emoji)"
        return label
    }()
    
    private lazy var refreshButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("닉네임 새로 받기", for: .normal)
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.adjustsImageWhenHighlighted = true
        button.addTarget(self, action: #selector(fetchData), for: .touchUpInside)
        return button
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13.0)
        label.numberOfLines = 0
        label.textColor = .gray
        label.textAlignment = .center
        label.text = """
                    닉네임이 마음에 들지 않으면 새로 받아보세요!
                    한 번 결정한 닉네임은 바꿀 수 없어요
                    """
        return label
    }()
    
    private lazy var confirmButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: "nicknameSelectButton"), for: .normal)
        button.addTarget(self, action: #selector(nextVC), for: .touchUpInside)
        return button
    }()
    
    @objc func nextVC() {
        self.navigationController?.pushViewController(MainViewController(), animated: true)
    }
    
    @objc func fetchData() {
        let urlString = "\(URLString.nicknameURL)"
        guard let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return}
        
        let url = URL(string: encodedString)
        let session = URLSession(configuration: .default)
        session.dataTask(with: url!) { data, _, error in
            guard let data = data, error == nil else {return}
            let decoder = JSONDecoder()
            let recive = try? decoder.decode(NicknameModel.self, from: data)
            
            if let nickName = recive {
                self.recivedNickName = nickName.data
            }

            DispatchQueue.main.async {
                self.nicknameLabel.text = "\(self.region)의 \(self.recivedNickName.nickname)님!"
                self.imoticonLable.text = self.recivedNickName.emoji
                self.animate()
            }
            
        }.resume()
    }
    
    func animate() {
        imoticonLable.alpha = 0
        nicknameLabel.alpha = 0
        imoticonLable.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        UIView.animate(withDuration: 0.8, animations: {
            self.imoticonLable.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.nicknameLabel.alpha = 1
            self.imoticonLable.alpha = 1
        })
        
        nicknameLabel.center.x = self.view.frame.width + 30
        UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 30.0, initialSpringVelocity: 30.0, options: UIView.AnimationOptions.curveEaseOut, animations: ({
                self.nicknameLabel.center.x = self.view.frame.width / 2
                }), completion: nil)
    }
    
    // MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationController?.navigationBar.topItem?.title = ""
        
        if let data = self.delegate?.sendData() {
            self.recivedNickName = data
        }
        animate()
        setupView()
    }
}

extension NicknameSelectViewController {
    
    // MARK: - Layout
    private func setupView() {
      
        [titleLabel, nicknameLabel, imoticonLable, refreshButton, descriptionLabel, confirmButton].forEach {view.addSubview($0)}

        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(48.0)
            $0.top.equalToSuperview().inset(170.0)
        }

        nicknameLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(48.0)
            $0.top.equalTo(titleLabel.snp.bottom).offset(5.0)
        }
        
        imoticonLable.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(nicknameLabel.snp.bottom).offset(view.frame.height * 0.06)
        }

        refreshButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(imoticonLable.snp.bottom).offset(view.frame.height * 0.06)
            $0.leading.equalToSuperview().inset(48.0)
            $0.trailing.equalToSuperview().inset(48.0)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(refreshButton.snp.bottom).offset(10.0)
        }
        
        confirmButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(view.frame.height * 0.096)
            $0.width.equalTo(view.frame.width - 96.0)
            $0.height.equalTo((view.frame.width - 96.0) * 0.15)
        }
    }
}
