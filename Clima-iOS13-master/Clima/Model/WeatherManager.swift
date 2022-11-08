//
//  WeatherManager.swift
//  Clima
//
//  Created by Дария Григорьева on 07.11.2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?&appid=f4489dee097040a258322f46ce7be326&units=metric"
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String) {
        //1. создать URL-адрес
        if let url = URL(string: urlString) {
            //2. создать сеанс URL
            let session = URLSession(configuration: .default)
            //3. дать сеансу задание
            let task = session.dataTask(with: url, completionHandler: handle(data:response:error:))
            // start the task
            task.resume()
        }
    }
    func handle(data: Data?, response: URLResponse?, error: Error?) -> Void {
        if error != nil {
            print(error!)
            return
        }
        if let safeData = data {
            let dataString = String(data: safeData, encoding: .utf8)
            print(dataString)
            
        }
    }
}
