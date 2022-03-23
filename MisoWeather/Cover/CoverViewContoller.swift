//
//  CoverViewContoller.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/03/22.
//

import UIKit

final class CoverViewContoller: UIViewController {
    
    // MARK: - subviews
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setBackgroundImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        button.tintColor = .systemGray3
        button.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(close), for: .touchUpInside)
        return button
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "nonLoginButton"), for: .normal)
        button.addTarget(self, action: #selector(nextLogin), for: .touchUpInside)
        return button
    }()
    
    // MARK: - private Methods
    @objc func close() {
        self.dismiss(animated: true, completion: nil)
    }

    @objc func nextLogin() {
        self.dismiss(animated: true) {
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(RegisterViewController())
        }
    }
    
    // MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        view.backgroundColor = .coverColor
        navigationController?.navigationBar.isHidden = true
    }
        
}

extension CoverViewContoller {
    // MARK: - subLayout
    private func setupView(width: CGFloat = UIScreen.main.bounds.width, height: CGFloat = UIScreen.main.bounds.height) {
        view.addSubview(closeButton)
        view.addSubview(button)

        closeButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(50)
            $0.trailing.equalToSuperview().inset(30)
            $0.width.equalTo(40)
            $0.height.equalTo(40)
        }
        
        button.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(height * 0.2)
            $0.leading.equalToSuperview().inset(30)
            $0.trailing.equalToSuperview().inset(30)
            $0.height.equalTo(height * 0.085)
        }
    }
}
