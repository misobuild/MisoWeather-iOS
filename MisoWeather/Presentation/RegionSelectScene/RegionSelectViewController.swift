//
//  RegionSelectViewController.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/01/03.
//

import UIKit
import SnapKit

class RegionSelectViewController: UIViewController {
    
    private var selectRegion: String = "서울"
    private var viewModel = RegionSelectViewModel()
    
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
    
    private lazy var confirmButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: "nextButton"), for: .normal)
        button.addTarget(self, action: #selector(nextVC), for: .touchUpInside)
        return button
    }()
    
    @objc func nextVC() {
        let nextVC = RegionListViewController()
        nextVC.delegate = self
        
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    private func setupBinding() {
        viewModel.storage.bind({ [weak self] _ in
            guard let self = self else {return}
            self.collectionView.reloadData()
        })
    }
    
    // MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = ""
        view.backgroundColor = .white
        
        viewModel.fetchData()
        setupView()
        setupBinding()
    }
}

extension RegionSelectViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.storage.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RegionCollectionViewCell", for: indexPath) as? RegionCollectionViewCell
        let region = viewModel.storage.value[indexPath.row]
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
        let region = viewModel.storage.value[indexPath.row]
        selectRegion = region
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

extension RegionSelectViewController: SendDelegate {
    func sendData() -> String {
        return selectRegion
    }
}
