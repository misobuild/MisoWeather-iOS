//
//  registerViewController.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/01/03.
//

import UIKit
import KakaoSDKUser
import SnapKit

class registerViewController: UIViewController {
    
    //MARK: - subviews
    
    private lazy var kakaoLoginButon: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "kakaoLoginButton"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(kakaoLogin), for: .touchUpInside)
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25.0, weight: .regular)
        label.textColor = .black
        label.text = "회원가입을 해주세요."
        return label
    }()
    
    @objc func kakaoLogin() {
        // 카카오톡 설치 여부 확인
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print("error")
                    print(error)
                }
                else {
                    print("loginWithKakaoTalk() success.")
                    //  회원가입 성공 시 oauthToken 저장가능
                    // _ = oauthToken
                    
                    //  사용자정보를 성공적으로 가져오면 화면전환
                    self.getUserInfo()
                }
            }
        }
        else {
            print("카카오톡 미설치")
        }
    }
    
    private func getUserInfo() {
        //  사용자 정보 가져오기
        UserApi.shared.me() {(user, error) in
            if let error = error {
                print(error)
            }
            else {
                print("me() success.")
                
                //  닉네임, 이메일 정보
                let nickname = user?.kakaoAccount?.profile?.nickname
                
                self.navigationController?.pushViewController(regionSelectViewController(), animated: true)
                
            }
        }
    }
    
    // MARK: - LifeCycle MEthods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

extension registerViewController {
    // MARK: - HElpors
    private func setup() {
        [kakaoLoginButon, titleLabel].forEach{ view.addSubview($0) }
        
    
        titleLabel.snp.makeConstraints{
            $0.top.equalToSuperview().inset(300.0)
            $0.centerX.equalToSuperview()
        }
        kakaoLoginButon.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(24.0)
            $0.top.equalTo(titleLabel.snp.bottom).offset(150.0)
            $0.centerX.equalToSuperview()

        }
    }
}

