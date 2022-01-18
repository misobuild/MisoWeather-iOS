//
//  SendDelegate.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/01/11.
//

protocol RegionSendDelegate: AnyObject {
    
    func sendData() -> [RegionList]
}

protocol nickNameSendDelegate: AnyObject {
    
    func sendData() -> NicknameModel.Data
}
