//
//  RegionSelectViewController.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/01/03.
//

import UIKit
import SnapKit

class RegionSelectViewController: UIViewController {
    
    private var selectRegion: String = "서울특별시"
    private var selectRegionList = ["서울", "경기", "인천", "대전", "세종", "충북", "충남", "광주", "전북", "전남", "대구", "부산", "울산", "경북", "경남", "강원", "제주"]
    private let requestRegionList = ["서울특별시", "경기도", "인천광역시", "대전광역시", "세종특별자치시", "충청북도", "충청남도", "광주광역시", "전라북도", "전라남도", "대구광역시", "부산광역시", "울산광역시", "경상북도", "경상남도", "강원도", "제주도"]
    
    private var midScaleRegionList: [RegionList] = []
    
    // MARK: - subviews
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
    
    private lazy var titleLabel: TitleLabel = {
        let label = TitleLabel()
        label.questionLabel.text = "간식거리🍩"
        return label
    }()
    
    private lazy var confirmButton: CustomButton = {
        let button = CustomButton(type: .next)
        button.addTarget(self, action: #selector(fetchData), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Private Method
    @objc private func nextVC() {
       
        let nextVC = MidRegionListViewController()
        nextVC.delegate = self
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc private func fetchData() {
        let urlString = "\(URLString.regionURL)\(selectRegion)"
        guard let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return}
        
        let url = URL(string: encodedString)
        let session = URLSession(configuration: .default)
        session.dataTask(with: url!) { data, _, error in
            guard let data = data, error == nil else {return print(error.debugDescription)}
            let decoder = JSONDecoder()
            let midRegionList = try? decoder.decode(RegionModel.self, from: data)
            
            guard let regionList: RegionModel = midRegionList else {return print(error.debugDescription)}
            self.midScaleRegionList = regionList.data.regionList
            DispatchQueue.main.async {
                self.nextVC()
            }
        }.resume()
    }
    
    // MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = ""
        view.backgroundColor = .white
        
        setupView()
    }
}

extension RegionSelectViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectRegionList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RegionCollectionViewCell", for: indexPath) as? RegionCollectionViewCell
        let region = selectRegionList[indexPath.row]
        cell?.setup(region: region)
        
        if indexPath.item == 0 {
            cell?.isSelected = true
            collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .init())
        }
        
        return cell ?? RegionCollectionViewCell()
    }
}

extension RegionSelectViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: (view.frame.width - 98.0 - 30) / 4, height: (view.frame.width - 98.0 - 30) / 4 * 0.6)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let region = requestRegionList[indexPath.row]
        selectRegion = region

        // User 대분류 지역 저장
        UserInfo.shared.region = selectRegionList[indexPath.row]
    }
}

extension RegionSelectViewController {
    // MARK: - Layout
    private func setupView() {
        [
            titleLabel,
            collectionView,
            confirmButton
        ].forEach {view.addSubview($0)}
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(174.0)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(359.0)
            $0.width.equalTo(view.frame.width - 96.0)
            $0.height.equalTo((view.frame.width - 96.0) * 0.85)
            $0.centerX.equalToSuperview()
        }
        
        confirmButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(view.frame.height * 0.096)
            $0.width.equalTo(view.frame.width - 96.0)
            $0.height.equalTo((view.frame.width - 96.0) * 0.15)
        }
    }
}

extension RegionSelectViewController: RegionSendDelegate {
    func sendData() -> [RegionList] {
        return midScaleRegionList
    }
}
