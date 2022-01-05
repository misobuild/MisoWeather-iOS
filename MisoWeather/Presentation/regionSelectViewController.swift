//
//  regionSelectViewController.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/01/03.
//

import UIKit
import SnapKit

class regionSelectViewController: UIViewController {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25.0, weight: .light)
        label.textColor = .black
        label.numberOfLines = 0
        label.text = """
                    어느 지역의
                    옷차림을 보고 싶으신가요?
                    """
        return label
    }()
    
    private lazy var regionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25.0, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 0
        label.text = "파주시"
        return label
    }()
    
    private lazy var confirmButton: customButton = {
        let button = customButton(type: .system)
        button.setTitle("다음", for: .normal)
        button.addTarget(self, action: #selector(nextVC), for: .touchUpInside)
        return button
    }()
    
    @objc func nextVC() {
        self.navigationController?.pushViewController(nicknameSelectViewController(), animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setup()
    }
}

extension regionSelectViewController {
    private func setup() {
        [titleLabel, regionLabel, confirmButton].forEach{view.addSubview($0)}

        titleLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(24.0)
            $0.top.equalToSuperview().inset(200.0)
        }
        regionLabel.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(100.0)

        }
        confirmButton.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(regionLabel.snp.bottom).offset(100.0)
            $0.leading.equalToSuperview().inset(24.0)
            $0.trailing.equalToSuperview().inset(24.0)
            $0.height.equalTo(50.0)
        }
    }
}
