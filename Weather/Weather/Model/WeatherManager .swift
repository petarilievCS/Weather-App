//
//  WeatherManager .swift
//  Weather
//
//  Created by Petar Iliev on 9.8.22.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?units=metric&appid=4dc0e5b7731beacfa5467e395435ae36"
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let URLString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: URLString)
    }
    
    func fetchWeather(latitude: Double, longitude:  Double) {
        let URLString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: URLString)
    }
    
    func didLoadWithError(error: Error) {
        print(error)
    }
    
    func performRequest(with urlString: String) {
        // Step 1: Create URL
        if let URL = URL(string: urlString) {
            
            // Step 2: Create URL Session
            let session = URLSession(configuration: .default)
            
            // Step 3: Assign task to URL Session
            let task = session.dataTask(with: URL) { data, response, error in
                if (error != nil) {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let weather = self.parseJSON(weatherData: safeData) {
                        self.delegate?.didUpdateWeather(weather: weather)
                    }
                }
            }
            
            // Step 4: Start task
            task.resume()
        }
    }
    
    func parseJSON(weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let name = decodedData.name
            let temp = decodedData.main.temp
            let weather = WeatherModel(conditionID: id, cityName: name, temperature: temp)
            return weather
        } catch {
            didLoadWithError(error: error)
            return nil
        }
    }
}

