//
//  SmartCodable.swift
//  SmartCodableDemo
//
//  Created by 罗树新 on 2021/1/31.
//

import Foundation

public protocol SmartEncoder {
    func encode<T: Encodable>(_ value: T) throws -> Data
}

extension SmartJSONEncoder: SmartEncoder {}
extension JSONEncoder: SmartEncoder {}

#if canImport(ObjectiveC) || swift(>=5.1)
extension PropertyListEncoder: SmartEncoder {}
#endif

public extension Encodable {
    func encoded(using encoder: SmartEncoder = {
        if Self.self is SmartEncodable.Type {
            let encoder = SmartJSONEncoder()
            if Self.self is EncodeSnakeCasable.Type {
                encoder.keyEncodingStrategy = .convertToSnakeCase
            }
            return encoder
        } else {
            let encoder = JSONEncoder()
            if Self.self is EncodeSnakeCasable.Type {
                encoder.keyEncodingStrategy = .convertToSnakeCase
            }
            return encoder
        }
    }()) throws -> Data {
        return try encoder.encode(self)
    }
}

public extension Encoder {
    func encodeSingleValue<T: Encodable>(_ value: T) throws {
        var container = singleValueContainer()
        try container.encode(value)
    }
    
    func encode<T: Encodable>(_ value: T, for key: String) throws {
        try encode(value, for: SmartCodingKey(key))
    }
    
    func encode<T: Encodable, K: CodingKey>(_ value: T, for key: K) throws {
        var container = self.container(keyedBy: K.self)
        try container.encode(value, forKey: key)
    }
    
    func encode<F: SmartDateFormatter>(_ date: Date, for key: String, using formatter: F) throws {
        try encode(date, for: SmartCodingKey(key), using: formatter)
    }
    
    func encode<K: CodingKey, F: SmartDateFormatter>(_ date: Date, for key: K, using formatter: F) throws {
        let string = formatter.string(from: date)
        try encode(string, for: key)
    }
    
}


