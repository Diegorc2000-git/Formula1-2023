//
//  Extensions.swift
//  Formula1
//
//  Created by Diego Rodriguez Casillas on 17/3/23.
//

import Foundation

extension Encodable {
    
    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
        else {
            throw NSError()
        }
        return dictionary
    }
    
}

extension Decodable {
    
    init(fromDictionary: Any) throws {
        let data = try JSONSerialization.data(withJSONObject: fromDictionary, options: .prettyPrinted)
        let decoder = JSONDecoder()
        self = try decoder.decode(Self.self, from: data)
    }
    
}

extension String {
    
    func splitString() -> [String] {
        var stringArray: [String] = []
        let trimmed = String(self.filter { !" \n\t\r".contains($0)})
        
        for (index, _) in trimmed.enumerated() {
            let prefixIndex = index+1
            let subStringPrefix = String(trimmed.prefix(prefixIndex)).lowercased()
            stringArray.append(subStringPrefix)
        }
        return stringArray
    }
    
}
