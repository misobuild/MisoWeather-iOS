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
    
    let model = RegisterViewModel()
    
    // MARK: - Subviews
    private lazy var kakaoLoginButon: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "kakaoLoginButton"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(hasKakaoToken), for: .touchUpInside)
        
//        // MARK: test
//        button.addTarget(self, action: #selector(nextVC), for: .touchUpInside)
        
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
        print("hasKakaoToken 실행")
        if AuthApi.hasToken() {
            // 사용자 액세스 토큰 정보 조회
            UserApi.shared.accessTokenInfo {(_, error) in
                if let error = error {
                    if let sdkError = error as? SdkError, sdkError.isInvalidTokenError() == true {
                        // 유효한 토큰 아님 로그인 필요
                        self.kakaoLogin()
                    } else {
                        // 기타 에러..
                        self.kakaoLogin()
                    }
                } else {
                    // 토큰 유효성 체크 성공(필요 시 토큰 갱신됨)
                    
                    // MARK: 엑세스 토큰 발급Test
//                    self.kakaoLogin()
                    
                    print("토큰 있니!?")
                    let token = TokenUtils()
                    print(token.read("kakao", account: "accessToken") ?? "")
                    self.kakaoLogin()
                    
                    // Main으로 화면 전환
                    // self.mainVC()
                }
            }
        } else {
            // 액세스 토큰 정보 없음 로그인 필요
            self.kakaoLogin()
        }
    }
    
    // 앱 실행시 처음 실행되는 함수
    // 화면 분기에 대해 처리해야함
    // RegionSelect or MainView
    private func hasUser() {
        print("hasUser 실행")
        if AuthApi.hasToken() {
            // 사용자 액세스 토큰 정보 조회
            UserApi.shared.accessTokenInfo {(_, error) in
                if let error = error {
                    if let sdkError = error as? SdkError, sdkError.isInvalidTokenError() == true {
                        // 유효한 토큰 아님 로그인 필요
                       print("유효 토큰 없음 로그인 필요 ")
                    } else {
                        // 기타 에러..
                    }
                } else {
                    // 토큰 유효성 체크 성공(필요 시 토큰 갱신됨)
                    
                    let token = TokenUtils()
                    print("토큰 있음??")
                    print(token.read("kakao", account: "accessToken") ?? "")
                    // Main으로 화면 전환

                    self.checkMain()
                }
            }
        }
    }
    
    // 로그아웃 -> 로그인 시 기존 유저인지 확인할 때
    private func checkUser() {
        print("checkUser 실행")
        model.token {(result: Result<String, APIError>) in
            
            switch result {
            case .success(let serverToken):
                print("유저 있음")
                // 메인으로 화면 전환
                DispatchQueue.main.async {
                    self.mainVC()
                }
                
            case .failure(let error):
                print("유저 없음")
                // 지역 선택으로 화면 전환
                DispatchQueue.main.async {
                    self.nextVC()
                }
            }
        }
    }
    
    // 처음 앱 실행 시 화면 분기에 대해서
    private func checkMain() {
        print("checkMain 실행")
        model.token {(result: Result<String, APIError>) in
            
            switch result {
            case .success(let serverToken):
                print("유저 있음")
                // 메인으로 화면 전환
                DispatchQueue.main.async {
                    self.mainVC()
                }
                
            case .failure(let error):
                print("유저 없음")
            }
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
                    
                    // TODO: 우리 기존 회원인지 아닌지 검사하는 과정이 필요함
                    self.checkUser()

//                    // 지역 선택으로 화면 전환
//                    self.nextVC()
                }
            }
        } else {
            // TODO: ShowAlert 카카오톡이 설치되어있지 않습니다.
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

//        let token = TokenUtils()
//        token.delete("kakao", account: "accessToken")
//
//
//        UserApi.shared.logout {(error) in
//            if let error = error {
//                print(error)
//            }
//            else {
//                print("logout() success.")
//            }
//        }
        
        hasUser()
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
