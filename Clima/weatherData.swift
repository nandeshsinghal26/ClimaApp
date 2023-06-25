//
//  weatherData.swift
//  Clima
//
//  Created by Nandesh Singhal on 22/06/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

struct weatherData: Codable {
    
    var name: String
    var main: tempData
    var weather: [climateData]
    
}
