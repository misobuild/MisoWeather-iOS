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
import AuthenticationServices

final class RegisterViewController: UIViewController {
    
    let model = RegisterViewModel()
    
    // MARK: - Subviews
    var imageViews = [UIImageView]()
    let scrollView = OnboardingView()
    
    private lazy var logoView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "logo")
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 45.0, weight: .regular)
        label.textColor = .buttonTextColor
        label.text = "MisoWeather🌤"
        return label
    }()
    
    private lazy var kakaoLoginButon: CustomButton = {
        let button = CustomButton(type: .kakao)
        button.addTarget(self, action: #selector(hasKakaoToken), for: .touchUpInside)
        return button
    }()
    
    private lazy var appleLoginButton: CustomButton = {
        let button = CustomButton(type: .apple)
        button.addTarget(self, action: #selector(handleAuthorizationAppleIDButtonPress), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Private Method
    
    @objc func handleAuthorizationAppleIDButtonPress() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    @objc private func nextVC() {
        self.navigationController?.pushViewController(BigRegionViewController(), animated: true)
    }
    
    @objc private func mainVC() {
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(MainViewController())
    }
    
    private func kakaoLogin() {
        print("======================kakaoLogin======================")
        // 카카오톡 설치 여부 확인
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                } else {
                    //  회원가입 성공 시 oauthToken 저장가능
                    guard let accessToken = oauthToken?.accessToken else {return}
                    
                    let token = TokenUtils()
                    UserDefaults.standard.set("kakao", forKey: "loginType")
                    token.create("kakao", account: "accessToken", value: accessToken)
                    
                    self.hasKakaoToken(isLogin: false)
                }
            }
        } else {
            // TODO: ShowAlert 카카오톡이 설치되어있지 않습니다.
            print("카카오톡 미설치")
        }
    }
    
    @objc private func hasKakaoToken(isLogin: Bool) {
        print("======================hasKakaoToken======================")
        if AuthApi.hasToken() {
            UserApi.shared.accessTokenInfo {(oAuthToken, error) in
                if let error = error {
                    if let sdkError = error as? SdkError, sdkError.isInvalidTokenError() == true {
                        print("에러")
                        self.kakaoLogin()
                    } else {
                        print("기타에러")
                        // 기타 에러..
                        self.kakaoLogin()
                    }
                } else {
                    UserDefaults.standard.set("kakao", forKey: "loginType")
                    
                    let token = TokenUtils()
                    token.create("kakao", account: "userID", value: String((oAuthToken?.id)!))
               
                    if isLogin {
                        self.checkUser(nextVC: false)
                    } else {
                        self.checkUser(nextVC: true)
                    }
                }
            }
        } else {
            if !isLogin {
                self.kakaoLogin()
            }
        }
    }
    
    private func hasUser() {
        print("======================hasUser======================")
        let loginType = UserDefaults.standard.string(forKey: "loginType")
        print("loginType = \(loginType)")
        
        if loginType == "kakao" {
            hasKakaoToken(isLogin: true)
        }
        
        if loginType == "apple" {
            checkUser(nextVC: true)
        }
    }
    
    // 로그아웃 -> 로그인 시 기존 유저인지 확인할 때
    private func checkUser(nextVC: Bool) {
        print("checkUser! ")
        model.getIsExistUser { isUser in
            if isUser == "true"{
                print("메인으로 화면 전환")
                // 메인으로 화면 전환
                self.model.postToken { _ in
                    DispatchQueue.main.async {
                        self.mainVC()
                    }
                }
            } else {
                print("다음 화면으로 전환")
                // 다음 화면으로 전환
                if nextVC {
                    DispatchQueue.main.async {
                        self.nextVC()
                    }
                }
            }
        }
    }
    
    // MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .mainColor
        self.navigationController?.navigationBar.isHidden = true
        
        // UserDefaults.standard.removeObject(forKey: "loginType")
        hasUser()
        setupView()
    }
}

// MARK: - AppleLogin
extension RegisterViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            
            // Create an account in your system.
            let user = appleIDCredential.user
            
            if let authorizationCode = appleIDCredential.authorizationCode,
               let identityToken = appleIDCredential.identityToken,
               let tokenString = String(data: identityToken, encoding: .utf8) {
                
                let token = TokenUtils()
                print("user = \(user)")
                print("tokenString = \(tokenString)")
                UserDefaults.standard.set("apple", forKey: "loginType")
                token.create("apple", account: "user", value: user)
                token.create("apple", account: "identityToken", value: tokenString)
                
                self.checkUser(nextVC: true)
            }
        case let passwordCredential as ASPasswordCredential:
            let username = passwordCredential.user
            let password = passwordCredential.password
            // DispatchQueue.main.async {
            //   self.showPasswordCredentialAlert(username: username, password: password)
            // }
        default:
            break
        }
    }
    
    // 로그인 실패
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print(" -- login error")
    }
}
extension RegisterViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        // 모달 시트에서 사용자에게 Apple 로그인 콘텐츠를 표시하는 앱에서 창을 가져오는 함수 호출
        return self.view.window!
    }
}

extension RegisterViewController {
    // MARK: - Layout
    private func setupView(width: CGFloat = UIScreen.main.bounds.width, height: CGFloat = UIScreen.main.bounds.height) {
        
        [
            logoView,
            scrollView,
            kakaoLoginButon,
            appleLoginButton,
            titleLabel].forEach {view.addSubview($0)}
        
        logoView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(height * 0.12)
            $0.leading.equalToSuperview().inset(width * 0.09)
            $0.width.equalTo(45)
            $0.height.equalTo(45)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(logoView.snp.bottom).offset(height * 0.05)
            $0.height.equalTo(height * 0.43)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        kakaoLoginButon.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(width * 0.07)
            $0.trailing.equalToSuperview().inset(width * 0.06)
            $0.top.equalTo(scrollView.snp.bottom).offset(height * 0.08)
            $0.height.equalTo(44)
        }
        
        appleLoginButton.snp.makeConstraints {
            $0.leading.equalTo(kakaoLoginButon)
            $0.trailing.equalTo(kakaoLoginButon)
            $0.top.equalTo(kakaoLoginButon.snp.bottom).offset(10)
            $0.height.equalTo(44)
        }
    }
}
