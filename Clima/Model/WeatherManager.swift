import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    
    var delegate: WeatherManagerDelegate?
    
    var weatherURL: String {
            if let apiKey = loadAPIKey() {
                return "https://api.openweathermap.org/data/2.5/weather?appid=\(apiKey)&units=metric"
            } else {
                fatalError("API Key not found")
            }
        }
    
    func loadAPIKey() -> String? {
        if let path = Bundle.main.path(forResource: ".env", ofType: "") {
            do {
                let contents = try String(contentsOfFile: path)
                
                // Parse the file for the "API_KEY" line
                for line in contents.split(separator: "\n") {
                    let keyValue = line.split(separator: "=")
                    if keyValue.count == 2, keyValue[0].trimmingCharacters(in: .whitespaces) == "API_KEY" {
                        return String(keyValue[1]).trimmingCharacters(in: .whitespaces)
                    }
                }
            } catch {
                print("Error reading .env file: \(error)")
            }
        }
        print(".env file not found")
        return nil
    }
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        //1. Create a URL
        if let url = URL(string: urlString) {
            //2. Create a URLSession
            let session = URLSession(configuration: .default)
            //3. Give the session a task
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let weather = parseJSON(safeData) {
                        delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            //4. Start the task
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodableData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodableData.weather[0].id
            let temp = decodableData.main.temp
            let name = decodableData.name
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            return weather
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
