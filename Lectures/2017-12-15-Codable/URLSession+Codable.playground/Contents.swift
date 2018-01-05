//: Playground - noun: a place where people can play

import UIKit
//import PlaygroundSupport
//PlaygroundPage.current.needsIndefiniteExecution = true

struct Toy: Codable {
    var name: String
}

struct Child: Codable {
    var name: String
    var id: Int
    var favoriteToy: Toy
}

extension Child: CustomDebugStringConvertible {
    var debugDescription: String {
        
        let vowels = "aeiouy"
        favoriteToy.name.lowercased()
        let gift = "\(vowels.contains(favoriteToy.name.lowercased().first!) ? "an" : "a") \(favoriteToy.name)"
        
        return "\(id): \(name) wants \(gift) for Christmass"
    }
}

//extension Child {
//    enum CodingKeys: String, CodingKey {
//        case id = "childId"
//        case name
//        case favoriteToy = "gift"
//    }
//}
//
//extension Child: Encodable {
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(name, forKey: .name)
//        try container.encode(id, forKey: .id)
//        try container.encode(favoriteToy, forKey: .favoriteToy)
//    }
//}
//
//extension Child: Decodable {
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        name = try values.decode(String.self, forKey: .name)
//        id = try values.decode(Int.self, forKey: .id)
//        favoriteToy = try values.decode(Toy.self, forKey: .favoriteToy)
//    }
//}
//
////Codable with custom keys
//let json = """
//{
// "name": "Ivancho",
// "childId": 1,
// "gift": {
//  "name":"Robot"
// }
//}
//""".data(using: .utf8)!

// Codable
let json = """
{
 "name": "Ivancho",
 "id": 1,
 "favoriteToy": {
  "name":"Robot"
 }
}
""".data(using: .utf8)!

do {
    let jsonDecoder = JSONDecoder()
    let childDecoded = try jsonDecoder.decode(Child.self, from: json)
    
    print(childDecoded)
} catch let error {
    print(error)
}

//
//let toy = Toy(name: "Teddy Bear")
//let child = Child(name: "John", id: 1, favoriteToy: toy)
//
//print(child)
//
//let jsonEncoder = JSONEncoder()
//let jsonData = try jsonEncoder.encode(child)
//let jsonString = String(data: jsonData, encoding: .utf8)!
//
//print(jsonString)

//struct Weather {
//    let location: String
//    let temperature: Int
//    let condition: String
//    let wind: Int
//    let day: String
//    let date: String
////    let date: Date
//
//    enum CodingKeys: String, CodingKey {
//        case location
//        case temperature
//        case condition = "skytext"
//        case wind
//        case day
//        case date
//    }
//
//    enum ResponseKeys: String, CodingKey {
//        case data
//    }
//}
//
//extension Weather: Decodable {
//    init(from decoder: Decoder) throws {
//        let response = try decoder.container(keyedBy: ResponseKeys.self)
//        let weatherValues = try response.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
//
//        location = try weatherValues.decode(String.self, forKey: .location)
//
//        let temp = try weatherValues.decode(String.self, forKey: .temperature)
//        temperature = Int(temp)!
//
//        condition = try weatherValues.decode(String.self, forKey: .condition)
//
//        let windSpd = try weatherValues.decode(String.self, forKey: .wind).filter {"0123456789".contains($0)}
//        wind = Int(windSpd)!
//
//        day = try weatherValues.decode(String.self, forKey: .day)
//        date = try weatherValues.decode(String.self, forKey: .date)
////        let rawDate = try weatherValues.decode(String.self, forKey: .date)
////        let dateFormatter = DateFormatter()
////        dateFormatter.dateFormat = "YYYY-MM-dd"
////
////        date = dateFormatter.date(from: rawDate)!
//    }
//}
//
//let url = URL(string: "https://5dayweather.org/api.php?city=Sofia")!
//let session = URLSession.shared
//let task = session.dataTask(with: url) { (data, response, error) in
//    guard let data = data else {
//        return
//    }
//
//    do {
//        let deserialized = try JSONSerialization.jsonObject(with: data)
//        print(deserialized)
//    } catch let err {
//        print(err)
//    }
//
////    do {
////        let decoder = JSONDecoder()
////        let weather = try decoder.decode(Weather.self, from: data)
////
////        print(weather)
////    } catch let err {
////        print(err)
////    }
//
//    PlaygroundPage.current.finishExecution()
//}
//
//task.resume()


