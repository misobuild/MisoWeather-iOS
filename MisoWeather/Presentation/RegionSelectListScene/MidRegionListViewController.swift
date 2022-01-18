//
//  MidRegionListViewController.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/01/10.
//

import UIKit
import SnapKit

class MidRegionListViewController: UIViewController {
    weak var delegate: RegionSendDelegate?
    
    private var midScaleRegionList: [RegionList] = []
    private var recivedNickName: NicknameModel.Data = NicknameModel.Data(nickname: "", emoji: "")
    
    // MARK: - Subviews
    private lazy var regionSelectListView: RegionSelectListView = {
        let view = RegionSelectListView()
        view.regionList = midScaleRegionList
        view.confirmButton.addTarget(MidRegionListViewController(), action: #selector(fetchData), for: .touchUpInside)
        return view
    }()
    
    @objc func nextVC() {
        if regionSelectListView.selectRegion == "선택 안 함" {
            weak var delegate: nickNameSendDelegate?
            let nextVC = NicknameSelectViewController()
            nextVC.delegate = self
            self.navigationController?.pushViewController(nextVC, animated: true)
        } else {
            let nextVC = SmallRegionListViewController()
            nextVC.delegate = self
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
    
    @objc func fetchData() {
        var urlString = ""
        if regionSelectListView.selectRegion == "선택 안 함" {
            urlString = "\(URLString.nicknameURL)"
        } else {
            urlString = "\(URLString.regionURL)\(midScaleRegionList[0].bigScale)/\(regionSelectListView.selectRegion)"
        }
        guard let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return}
        
        let url = URL(string: encodedString)
        let session = URLSession(configuration: .default)
        session.dataTask(with: url!) { data, _, error in
            guard let data = data, error == nil else {return}
            let decoder = JSONDecoder()
            
            if self.regionSelectListView.selectRegion == "선택 안 함" {
                let recive = try? decoder.decode(NicknameModel.self, from: data)
                if let nickName = recive {
                    self.recivedNickName = nickName.data
                }
            } else {
                let recive = try? decoder.decode(RegionModel.self, from: data)
                if let regionList = recive {
                    self.midScaleRegionList = regionList.data.regionList
                }
            }
            
            DispatchQueue.main.async {
                self.nextVC()
            }
            
        }.resume()
    }
    
    // MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationController?.navigationBar.topItem?.title = ""
        
        if let data = self.delegate?.sendData() {
            self.midScaleRegionList = data
        }
        
        setupView()
    }
}

extension MidRegionListViewController {
    
    // MARK: - Layout
    private func setupView() {
        [
            regionSelectListView
            
        ].forEach {view.addSubview($0)}
        
        regionSelectListView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }
}

extension MidRegionListViewController: RegionSendDelegate {
    func sendData() -> [RegionList] {
        return midScaleRegionList
    }
}

extension MidRegionListViewController: nickNameSendDelegate {
    func sendData() -> NicknameModel.Data{
        return recivedNickName
    }
}
