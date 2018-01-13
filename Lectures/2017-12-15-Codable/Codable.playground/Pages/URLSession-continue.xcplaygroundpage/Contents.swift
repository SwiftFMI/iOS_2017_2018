import UIKit
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

struct Weather {
    let location: String
    let date: String
    let day: String
    let condtion: String
    
    enum WeatherKeys: String, CodingKey {
        case location
        case date
        case day
        case condtion = "skytext"
    }
    
    enum ResponseKeys: String, CodingKey {
        case data
    }
}

extension Weather: Decodable {
    init(from decoder: Decoder) throws {
        let response = try decoder.container(keyedBy: ResponseKeys.self)
        let weather = try response.nestedContainer(keyedBy: WeatherKeys.self, forKey: .data)
        location = try weather.decode(String.self, forKey: .location)
        date = try weather.decode(String.self, forKey: .date)
        day = try weather.decode(String.self, forKey: .day)
        condtion = try weather.decode(String.self, forKey: .condtion)
    }
}

var components = URLComponents()
components.scheme = "https"
components.host = "www.5dayweather.org"
components.path = "/api.php"

let cityParameter = URLQueryItem(name: "city", value: "Sofia")
components.queryItems = [cityParameter]

let url = components.url!

let session = URLSession.shared
let task = session.dataTask(with: url) { (data, response, error) in
    guard let data = data else {
        return
    }
    
    let decoder = JSONDecoder()
    do {
        let currentWeather = try decoder.decode(Weather.self, from: data)
        print(currentWeather.location)
    } catch let err {
        print(err)
    }
    
    PlaygroundPage.current.finishExecution()
}

task.resume()
