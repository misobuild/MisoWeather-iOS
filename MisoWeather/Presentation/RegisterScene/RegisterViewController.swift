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

final class RegisterViewController: UIViewController {
    
    // MARK: - Subviews
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
        label.textColor = .buttonTextColor
        label.text = "MisoWeather🌤"
        return label
    }()
    
    private lazy var nonLoginButton: UIButton = {
        let button = UIButton(type: .system)
        let text = "그냥 둘러볼래요"
        button.setTitleColor(.white, for: .normal)
        button.setTitle(text, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16.0)
        let attributeString = NSMutableAttributedString(string: text)
        attributeString.addAttribute(.underlineStyle, value: 1, range: NSRange.init(location: 0, length: text.count))
        button.titleLabel?.attributedText = attributeString
        // 굵기 1의 언더라인과 함께 처음부터 끝까지 밑줄 설정
        button.addTarget(self, action: #selector(mainVC), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Private Method
    @objc private func nextVC() {
        self.navigationController?.pushViewController(BigRegionViewController(), animated: true)
    }
    
    @objc private func mainVC() {
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(MainViewController())
    }
    
    @objc private func hasKakaoToken() {
        if AuthApi.hasToken() {
            // 사용자 액세스 토큰 정보 조회
            UserApi.shared.accessTokenInfo {(_, error) in
                if let error = error {
                    if let sdkError = error as? SdkError, sdkError.isInvalidTokenError() == true {
                        // 유효한 토큰 아님 로그인 필요
                        self.kakaoLogin()
                    } else {
                        // 기타 에러.. 
                    }
                } else {
                    // 토큰 유효성 체크 성공(필요 시 토큰 갱신됨)
                    print("토큰 유효성 체크 성공")
                    
                    // 엑세스 토큰 발급Test
                    self.kakaoLogin()
                    
                    let token = TokenUtils()
                    print(token.read("kakao", account: "accessToken") ?? "")
                    
                    // 화면전환
                    self.nextVC()
                }
            }
        } else {
            // 액세스 토큰 정보 없음 로그인 필요
            self.kakaoLogin()
        }
    }
    
    private func kakaoLogin() {
        // 카카오톡 설치 여부 확인
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                } else {
                    //  회원가입 성공 시 oauthToken 저장가능
                    guard let accessToken = oauthToken?.accessToken else {return}
                    
                    // 키체인에 Token, ID 저장
                    let token = TokenUtils()
                    token.create("kakao", account: "accessToken", value: accessToken)
                    
                    // 화면전환
                    self.nextVC()
                }
            }
        } else {
            print("카카오톡 미설치")
        }
    }
    
    // MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .mainColor
        self.navigationController?.navigationBar.isHidden = true
        
//        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
//        self.navigationItem.backBarButtonItem = backBarButtonItem
        
        setupView()
    }
}

extension RegisterViewController {
    // MARK: - Layout
    private func setupView() {
        
        [kakaoLoginButon, nonLoginButton, titleLabel].forEach {view.addSubview($0)}
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(300.0)
            $0.centerX.equalToSuperview()
        }
        kakaoLoginButon.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(24.0)
            $0.top.equalTo(titleLabel.snp.bottom).offset(150.0)
            $0.centerX.equalToSuperview()
        }
        nonLoginButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(24.0)
            $0.trailing.equalToSuperview().inset(24.0)
            $0.top.equalTo(kakaoLoginButon.snp.bottom).offset(17.0)
        }
    }
}
