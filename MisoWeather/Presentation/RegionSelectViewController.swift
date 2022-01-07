//
//  RegionSelectViewController.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/01/03.
//

import UIKit
import SnapKit

class RegionSelectViewController: UIViewController {
    
    private var regionList: [Region] = []
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 26.0, weight: .light)
        label.textColor = .black
        label.text = "어떤 지역의 날씨를 위한"
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white

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
        label.text = " 를 볼까요?"
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
        fetchData()
        setup()
    }
}

extension RegionSelectViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return regionList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RegionCollectionViewCell", for: indexPath) as! RegionCollectionViewCell
        let region = regionList[indexPath.item]
        cell.setup(region: region)
        return cell
    }
}

extension RegionSelectViewController: UICollectionViewDelegateFlowLayout {
    //지정된 셀의 크기를 반환하는 메서드
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width:(view.frame.width - 98.0 - 30) / 4 , height:(view.frame.width - 98.0 - 30) / 4 * 0.6)
    }
    //셀 사이의 최소 간격을 반환하는 메서드.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        5.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let region = regionList[indexPath.item]
        print("Selected cell: (\(indexPath.section), \(region.region))")
    }
}

private extension RegionSelectViewController{
    func fetchData() {
        guard let url = Bundle.main.url(forResource: "Region", withExtension: "plist") else {return}
        
        do{
            let data = try Data(contentsOf: url)
            let result = try PropertyListDecoder().decode([Region].self, from: data)
            regionList = result
        } catch {}
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
            $0.top.equalTo(questionLabel.snp.bottom).offset(109.0)
            $0.width.equalTo(view.frame.width - 96.0)
            $0.height.equalTo((view.frame.width - 96.0) * 0.85)
            $0.centerX.equalToSuperview()
        }
        
        confirmButton.snp.makeConstraints {
            $0.leading.equalTo(titleLabel)
            $0.trailing.equalToSuperview().inset(48.0)
            $0.height.equalTo(48.0)
            $0.bottom.equalToSuperview().inset(87.0)
        }
    }
}
