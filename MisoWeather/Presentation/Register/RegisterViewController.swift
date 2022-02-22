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
        print("kakaoLogin")
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
                    UserDefaults.standard.set("kakao", forKey: "loginType")
                    token.create("kakao", account: "accessToken", value: accessToken)
                    
                    self.checkUser()
                }
            }
        } else {
            // TODO: ShowAlert 카카오톡이 설치되어있지 않습니다.
            print("카카오톡 미설치")
        }
    }
    
    @objc private func hasKakaoToken() {
        print("hasKakaoToken")
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
                    // self.kakaoLogin()
                    
                    let token = TokenUtils()
                    // token.create("kakao", account: "userID", value: oAuthToken?.id)
                    
                    print(token.read("kakao", account: "accessToken") ?? "")
                    self.kakaoLogin()
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
        print("hasUser")
        if AuthApi.hasToken() {
            // 사용자 액세스 토큰 정보 조회
            UserApi.shared.accessTokenInfo {(oauthToken, error) in
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
                    UserDefaults.standard.set("apple", forKey: "loginType")
                    token.create("kakao", account: "userID", value: String((oauthToken?.id)!))
                    print(token.read("kakao", account: "accessToken") ?? "")
                    
                    // Main으로 화면 전환
                    self.checkMain()
                }
            }
        }
    }
    
    // 로그아웃 -> 로그인 시 기존 유저인지 확인할 때
    private func checkUser() {
        print("checkUser")
        model.getIsExistUser { isUser in
            if isUser == "true"{
                // 메인으로 화면 전환
                DispatchQueue.main.async {
                    self.mainVC()
                }
            } else {
                DispatchQueue.main.async {
                    self.nextVC()
                }
            }
        }
    }
    
    // 처음 앱 실행 시 화면 분기에 대해서
    private func checkMain() {
        print("checkMain")
        model.getIsExistUser { isUser in
            if isUser == "true"{
                // 메인으로 화면 전환
                DispatchQueue.main.async {
                    self.mainVC()
                }
            }
        }
    }
    
    // MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .mainColor
        self.navigationController?.navigationBar.isHidden = true
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
               //               let authString = String(data: authorizationCode, encoding: .utf8),
               let tokenString = String(data: identityToken, encoding: .utf8) {
                
                let token = TokenUtils()
                token.create("apple", account: "user", value: user)
                token.create("apple", account: "identityToken", value: tokenString)
                
                self.checkUser()
            }

            // For the purpose of this demo app, store the `userIdentifier` in the keychain.
            // self.saveUserInKeychain(userIdentifier)
            
            // For the purpose of this demo app, show the Apple ID credential information in the `ResultViewController`.
            // self.showResultViewController(userIdentifier: userIdentifier, fullName: fullName, email: email)
            
        case let passwordCredential as ASPasswordCredential:
            
            // Sign in using an existing iCloud Keychain credential.
            let username = passwordCredential.user
            let password = passwordCredential.password
            
            // For the purpose of this demo app, show the password credential as an alert.
            print(username)
            print(password)
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
