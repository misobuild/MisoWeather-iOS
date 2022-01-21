//
//  MainViewController.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/01/06.
//

import UIKit

final class MainViewController: UIViewController {
    
    // MARK: - subviews
    private lazy var mainScrollView: MainScrollView = {
        let view = MainScrollView()
        view.weatherView.nextButton.addTarget(MainViewController(), action: #selector(nextVC), for: .touchUpInside)
        return view
        
    }()
    // MARK: - Private Method
    @objc private func nextVC() {
        let nextVC = WeatherViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    // MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
}

extension MainViewController {
    
    // MARK: - Layout
    private func setupView(width: CGFloat = UIScreen.main.bounds.width, height: CGFloat = UIScreen.main.bounds.height) {
        
        [
            mainScrollView
        ].forEach {view.addSubview($0)}
        
        mainScrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}
