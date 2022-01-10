//
//  RegisterViewController.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/01/03.
//

import UIKit
import KakaoSDKUser
import KakaoSDKAuth
import KakaoSDKCommon
import SnapKit

class RegisterViewController: UIViewController {
    
    //MARK: - subviews
    
    private lazy var kakaoLoginButon: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "kakaoLoginButton"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(hasKakaoToken), for: .touchUpInside)
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 45.0, weight: .regular)
        label.textColor = .black
        label.text = "MisoWeather🌤"
        return label
    }()
    
    private lazy var nonLoginButton: UIButton = {
        let button = UIButton()
        button.setTitle("그냥 둘러볼래요", for: .normal)
        button.setTitleColor( UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(nextVC), for: .touchUpInside)
        return button
    }()
    
    @objc func nextVC() {
        self.navigationController?.pushViewController(RegionSelectViewController(), animated: true)
    }
    
    @objc func hasKakaoToken() {

        if (AuthApi.hasToken()) {
            UserApi.shared.accessTokenInfo { (_, error) in
                if let error = error {
                    if let sdkError = error as? SdkError, sdkError.isInvalidTokenError() == true  {
                        //로그인 필요
                        print("로그인 필요")
                        self.kakaoLogin()
                    }
                    else {
                        //기타 에러
                    }
                }
                else {
                    //토큰 유효성 체크 성공(필요 시 토큰 갱신됨)
                    print("토큰 유효성 체크 성공")
                    self.getUserInfo()
                }
            }
        }
        else {
            //로그인 필요
            print("로그인 필요2")
            self.kakaoLogin()
        }
    }
    
    private func kakaoLogin(){
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
                self.navigationController?.pushViewController(RegionSelectViewController(), animated: true)
                
            }
        }
    }
    
    // MARK: - LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = .black
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        
        self.navigationItem.backBarButtonItem = backBarButtonItem

        setup()
    }
}

extension RegisterViewController {
    // MARK: - Helpers
    private func setup() {
        [kakaoLoginButon, nonLoginButton ,titleLabel].forEach{ view.addSubview($0) }
        
        titleLabel.snp.makeConstraints{
            $0.top.equalToSuperview().inset(300.0)
            $0.centerX.equalToSuperview()
        }
        kakaoLoginButon.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(24.0)
            $0.top.equalTo(titleLabel.snp.bottom).offset(150.0)
            $0.centerX.equalToSuperview()
        }
        nonLoginButton.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(kakaoLoginButon.snp.bottom).offset(17.0)
        }
    }
}

