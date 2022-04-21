//
//  Parser.swift
//  MyApp
//
//  Created by Andrey Sushkov on 21.04.22.
//

import Foundation

struct Parser {
    
    static func parse(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let dataFromJSON = try decoder.decode(WeatherData.self, from: weatherData)
            let id = dataFromJSON.weather[0].id
            let temperature = dataFromJSON.main.temp
            let cityName = dataFromJSON.name
            let weather = WeatherModel(conditionId: id, cityName: cityName, temperature: temperature)
            return weather
        } catch {
            print ("error while parsing")
            return nil
        }
    }
}
