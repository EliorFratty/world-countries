//
//  Country.swift
//  world countries
//
//  Created by User on 01/09/2019.
//  Copyright © 2019 User. All rights reserved.
//

import Foundation

struct Country {
    let alpha3Code: String
    let nativeName: String
    let englishName: String
    let area: Int
    let borderingCountries: [String]
    let flag: String
    
    init(jsonDict: NSDictionary) {
        
         alpha3Code = jsonDict["alpha3Code"] as? String ?? "Nil"
         nativeName = jsonDict["nativeName"] as? String ?? "Nil"
         englishName = jsonDict["name"] as? String ?? "Nil"
         area = jsonDict["area"] as? Int ?? 0
         borderingCountries = jsonDict["borders"] as? [String] ?? []
         flag = jsonDict["flag"] as? String ?? "Nil"
    }
}
