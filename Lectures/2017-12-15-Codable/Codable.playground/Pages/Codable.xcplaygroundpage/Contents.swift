import Foundation

struct Toy: Codable {
    let name: String
}

extension Toy: CustomStringConvertible {
    var description: String {
        return name
    }
}

struct Child {
    let name: String
    let id: Int
    let favoriteToy: Toy
    
    enum CodingKeys: String, CodingKey {
        case name, id, favoriteToy
    }
}

extension Child: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(id, forKey: .id)
        try container.encode(favoriteToy, forKey: .favoriteToy)
    }
}

extension Child: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try values.decode(String.self, forKey: .name)
        id = try values.decode(Int.self, forKey: .id)
        favoriteToy = try values.decode(Toy.self, forKey: .favoriteToy)
    }
}

extension Child: CustomStringConvertible {
    var description: String {
        return "\(id): \(name) wants \(favoriteToy) for Chirstmas"
    }
}

let json = """
{
 "name": "Ivancho",
 "id": 1,
 "favoriteToy": {
  "name":"Robot"
 }
}
""".data(using: .utf8)!

let child2 = Child(name: "Mariika", id: 2, favoriteToy: Toy(name: "Doll"))
print(child2)

let decoder = JSONDecoder()
let encoder = JSONEncoder()

do {
    let json2 = try encoder.encode(child2)
    print(json2)
    let child3 = try decoder.decode(Child.self, from: json2)
    print(child3.name)
    
} catch let err {
    print(err)
}



 do {
    let child = try decoder.decode(Child.self, from: json)
    print(child)
    
} catch let err {
    print(err)
}
