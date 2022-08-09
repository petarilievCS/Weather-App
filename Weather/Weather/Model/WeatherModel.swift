//
//  WeatherModel.swift
//  Weather
//
//  Created by Petar Iliev on 9.8.22.
//

import Foundation

struct WeatherModel {
    let conditionID: Int
    let cityName: String
    let temperature: Double
    
    var conditionName: String {
        switch conditionID {
        case (200...232):
            return "cloud.bolt.rain"
        case (300...321):
            return "cloud.drizzle"
        case (500...531):
            return "cloud.rain"
        case (600...622):
            return "cloud.snow"
        case (700...781):
            return "cloud.fog"
        case (800):
            return "sun.max"
        case (801...804):
            return "cloud"
        default:
            return "cloud"
        }
    }
    
    var stringTemperature: String {
        return String(format: "%.1f", temperature)
    }
}

