//
//  SceneDelegate.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/01/03.
//

import UIKit
import KakaoSDKAuth
import KakaoSDKUser

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            if AuthApi.isKakaoTalkLoginUrl(url) {
                _ = AuthController.handleOpenUrl(url: url)
            }
        }
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        window?.backgroundColor = .white
        window?.rootViewController = UINavigationController(rootViewController: RegionSelectViewController())
        window?.makeKeyAndVisible()
    }
}

// 싱글턴을 적용하던지,,, 음 객체를 어떻게 넘길 지 생각해보고
// 카카오 ID 넘기는거 적용하고
// 일단 카카오 ID 넘겨서 그걸로 닉네임 띄우는거 해보고
// URL세션 적용할꺼 준비하고

// 메인뷰에 콜렉션뷰 두개 적용
// 메인뷰-1 에 콜렉션뷰 적용
// 메인뷰-2 에 콜렉션뷰 적용
