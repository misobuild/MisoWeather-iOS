//
//  regionSearchViewController.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/01/03.
//

import UIKit
import SnapKit

class regionSearchViewController: UIViewController {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25.0, weight: .light)
        label.textColor = .black
        label.text = "어떤 지역의 날씨를 위한"
        return label
    }()
    
    private lazy var questionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 27.0, weight: .black)
        label.textColor = .black
        label.text = "간식거리 🍩"
        return label
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25.0, weight: .light)
        label.textColor = .black
        label.text = " 를 볼까요?"
        return label
    }()
    
    private lazy var confirmButton: customButton = {
        let button = customButton(type: .system)
        button.setTitle("검색", for: .normal)
        button.addTarget(self, action: #selector(nextVC), for: .touchUpInside)
        return button
    }()
    
    @objc func nextVC() {
        self.navigationController?.pushViewController(nicknameSelectViewController(), animated: true)
    }
    
    let searchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.hidesBackButton = true
        setup()
    }
}

extension regionSearchViewController {
    private func setup() {
        [titleLabel, questionLabel, subTitleLabel].forEach{view.addSubview($0)}
        
        titleLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(24.0)
            $0.top.equalToSuperview().inset(270.0)
        }
        questionLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(24.0)
            $0.top.equalTo(titleLabel.snp.bottom).offset(5.0)
        }
        subTitleLabel.snp.makeConstraints{
            $0.top.equalTo(questionLabel)
            $0.leading.equalTo(questionLabel.snp.trailing).inset(1.0)
        }
    }
}
