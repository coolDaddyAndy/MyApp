//
//  WeatherManager.swift
//  MyApp
//
//  Created by Andrey Sushkov on 21.04.22.
//

import Foundation
import CoreLocation

protocol WeatherDataDelegate {
    func updateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func errorRecieved(_ error: Error)
}

struct WeatherManager {
    var delegate: WeatherDataDelegate?
    
    let mainURL: String = "https://api.openweathermap.org/data/2.5/weather?appid=5366936a1e0b898182073781ca3133e1&units=metric"
    
    func getWeatherViaCity(city: String) {
        let url = "\(mainURL)&q=\(city)"
        sendRequest(url)
    }
    
    func getWeatherViaLatAndLon(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let url = "\(mainURL)&lat=\(latitude)&lon=\(longitude)"
        sendRequest(url)
    }
    
    
    func sendRequest(_ urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let data = data {
                if let weather = Parser.parse(data) {
                    self.delegate?.updateWeather(self, weather: weather)
                }
            } else {
                self.delegate?.errorRecieved(error!)
            }
        }
        task.resume()
    }
}
