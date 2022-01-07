//
//  RegionListViewController.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/01/07.
//

import UIKit
import SnapKit

class RegionListViewController: UIViewController, SendDataDelegate {
    
    var region = "값 없음"
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 26.0, weight: .light)
        label.textColor = .black
        label.text = "어떤 지역의 날씨를 위한"
        return label
    }()
    
    private lazy var questionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 26.0, weight: .black)
        label.textColor = .black
        label.text = "간식거리🍩         "
        return label
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 26.0, weight: .light)
        label.textColor = .black
        label.text = " 를 볼까요?"
        return label
    }()
    
    private lazy var regionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 50.0, weight: .bold)
        label.textColor = .black
        label.text = region
        return label
    }()
    
    private lazy var confirmButton: customButton = {
        let button = customButton(type: .system)
        button.addTarget(self, action: #selector(nextVC), for: .touchUpInside)
        return button
    }()
    
    @objc func nextVC() {
        self.navigationController?.pushViewController(NicknameSelectViewController(), animated: true)
    }
    
    func sendData(data: String) {

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationController?.navigationBar.topItem?.title = ""
        
        setup()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination.children.first as? RegionSelectViewController {
            vc.delegate = self
        }
    }
}

extension RegionListViewController {
 
    private func setup() {
        [
             titleLabel,
             questionLabel,
             subTitleLabel,
             regionLabel,
             confirmButton,
        ].forEach{ view.addSubview($0) }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(48.0)
            $0.top.equalToSuperview().inset(174.0)
        }
        
        questionLabel.snp.makeConstraints {
            $0.leading.equalTo(titleLabel)
            $0.top.equalTo(titleLabel.snp.bottom).offset(10.0)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.leading.equalTo(questionLabel.snp.trailing).inset(5.0)
            $0.top.equalTo(titleLabel.snp.bottom).offset(10.0)
        }
        regionLabel.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(questionLabel.snp.bottom).offset(100.0)
        }
        
        confirmButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(view.frame.height * 0.096)
            $0.width.equalTo(view.frame.width - 96.0)
            $0.height.equalTo((view.frame.width - 96.0) * 0.15)
            
        }
    }
}

