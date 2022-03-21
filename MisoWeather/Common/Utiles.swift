//
//  Utiles.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/02/15.
//

import Foundation

public class Utils {
    internal static func getAppVersion() -> String { return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
    }
    
    internal static func getBuildVersion() -> String { return Bundle.main.infoDictionary?["CFBundleVersion"] as! String
    }
}
