//
//  WeatherData.swift
//  MyApp
//
//  Created by Andrey Sushkov on 21.04.22.
//

import Foundation

struct WeatherData: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Decodable {
    let temp: Double
}

struct Weather: Decodable {
    let description: String
    let id: Int
}
