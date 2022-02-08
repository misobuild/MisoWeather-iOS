//
//  BigRegionViewController.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/01/03.
//

import UIKit
import SnapKit
import KakaoSDKCommon

final class BigRegionViewController: UIViewController {
    
    private let model = BigRegionViewModel()
    private var midScaleRegionList: [RegionList] = []
    
    private var selectRegion: String = ""
    private var selectRegionList = ["서울", "경기", "인천", "대전", "세종", "충북", "충남", "광주", "전북", "전남", "대구", "부산", "울산", "경북", "경남", "강원", "제주"]
    
    // MARK: - subviews
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.register(BigRegionCollectionViewCell.self, forCellWithReuseIdentifier: "RegionCollectionViewCell")
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
    private func showAlert() {
        let alert = UIAlertController(title: "지역을 선택해 주세요.",
                                      message: "",
                                      preferredStyle: UIAlertController.Style.alert)
        
        let confirm = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(confirm)
        present(alert, animated: true, completion: nil)
    }
    
    @objc private func nextVC() {
        let nextVC = MidRegionListViewController()
        nextVC.delegate = self
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    // 2단계 지역 리스트 가져오기
    @objc private func fetchData() {
        if selectRegion == "" {
            self.showAlert()
        }
        model.fetchRegionData(region: selectRegion) {
            self.midScaleRegionList = self.model.midleRegionList
            DispatchQueue.main.async {
                self.nextVC()
            }
        }
    }
    
    // MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
//        // MARK: test 시뮬레이터 키체인에 Token, ID 저장
//        let token = TokenUtils()
//        token.create("kakao", account: "accessToken", value: "bcHIUrVU5To7BYugt55LUkGqPeoOJ8xmXmRJ7Aopb7gAAAF-xOiRSw")
//        token.create("kakao", account: "userID", value: "2063494098")
        
        setupView()
    }
     
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
}

// MARK: - Extension
extension BigRegionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectRegionList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RegionCollectionViewCell", for: indexPath) as? BigRegionCollectionViewCell
        let region = selectRegionList[indexPath.row]
        cell?.setup(region: region)
        return cell ?? BigRegionCollectionViewCell()
    }
}

extension BigRegionViewController: UICollectionViewDelegateFlowLayout {
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
        let region = selectRegionList[indexPath.row]
        selectRegion = region

        // User 대분류 지역 저장
        UserInfo.shared.region = selectRegionList[indexPath.row]
    }
}

extension BigRegionViewController {
  
    // MARK: - Layout
    private func setupView(width: CGFloat = UIScreen.main.bounds.width, height: CGFloat = UIScreen.main.bounds.height) {
        [
            titleLabel,
            collectionView,
            confirmButton
        ].forEach {view.addSubview($0)}
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(height * 0.2)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(height * 0.4)
            $0.width.equalTo(width - (width * 0.23))
            $0.height.equalTo((width - (width * 0.23)) * 0.85)
            $0.centerX.equalToSuperview()
        }
        
        confirmButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(height * 0.1)
            $0.width.equalTo(width - (width * 0.14))
            $0.height.equalTo((width - (width * 0.23)) * 0.15)
        }
    }
}

extension BigRegionViewController: RegionSendDelegate {
    func sendData() -> [RegionList] {
        return midScaleRegionList
    }
}
