//
//  RegionSelectViewController.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/01/03.
//

import UIKit
import SnapKit

class RegionSelectViewController: UIViewController {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 26.0, weight: .light)
        label.textColor = .black
        label.text = "어떤 지역의 날씨를 위한"
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .gray
        
        collectionView.register(RegionCollectionViewCell.self, forCellWithReuseIdentifier: "RegionCollectionViewCell")
        
        return collectionView
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
        label.text = "  를 볼까요?"
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
}

extension RegionSelectViewController {
    private func setup() {
        
        view.backgroundColor = .white
        navigationItem.hidesBackButton = true
        
        [
            collectionView,
             titleLabel,
             questionLabel,
             subTitleLabel,
             confirmButton
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
        
        collectionView.snp.makeConstraints{
            $0.leading.equalTo(48.0)
            $0.trailing.equalTo(48.0)
            $0.top.equalTo(questionLabel.snp.bottom).offset(109.0)
            $0.height.equalTo(collectionView.snp.width)
        }
        
        confirmButton.snp.makeConstraints {
            $0.leading.equalTo(titleLabel)
            $0.trailing.equalToSuperview().inset(48.0)
            $0.height.equalTo(48.0)
            $0.bottom.equalToSuperview().inset(87.0)
        }
    }
}

extension RegionSelectViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RegionCollectionViewCell", for: indexPath)

        return cell
    }
}

extension RegionSelectViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width - 32.0, height: collectionView.frame.width - 32.0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0.0, left: 16.0 , bottom: 0.0, right: 16.0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        32.0
    }
    
}
