//
//  WeatherData.swift
//  Weather
//
//  Created by Petar Iliev on 9.8.22.
//

struct WeatherData: Decodable {
    
    let name: String
    let main: main
    let weather: [weather]
    
}

struct main: Decodable {
    let temp: Double
}

struct weather: Decodable {
    let id: Int
}
