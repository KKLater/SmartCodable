//
//  SmartDecodable.swift
//  SmartCodableDemo
//
//  Created by 罗树新 on 2021/1/31.
//

import Foundation


public protocol SmartDecoder {
    func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T
}

extension JSONDecoder: SmartDecoder {}

#if canImport(ObjectiveC) || swift(>=5.1)
extension PropertyListDecoder: SmartDecoder{}
#endif

extension SmartJSONDecoder: SmartDecoder {}

public extension Data {
    func decoded<T: Decodable>(as type: T.Type = T.self, using decoder: SmartDecoder = {
        if T.self is SmartDecodable.Type {
            let decoder = SmartJSONDecoder()
            if T.self is SnakeCasable.Type {
                decoder.keyDecodingStrategy = .convertFromSnakeCase
            }
            return decoder
        } else {
            let decoder = JSONDecoder()
            if T.self is SnakeCasable.Type {
                decoder.keyDecodingStrategy = .convertFromSnakeCase
            }
            return decoder
        }
    }()) throws -> T {
        return try decoder.decode(T.self, from: self)
    }
    
}

public extension Decoder {
    func decodeSingleValue<T: Decodable>(as type: T.Type = T.self) throws -> T {
        let container = try singleValueContainer()
        return try container.decode(type)
    }
    
    func decode<T: Decodable>(_ key: String, as type: T.Type = T.self) throws -> T {
        return try decode(SmartCodingKey(key), as: type)
    }
    
    func decode<T: Decodable, K: CodingKey>(_ key: K, as type: T.Type = T.self) throws -> T {
        let container = try self.container(keyedBy: K.self)
        return try container.decode(type, forKey: key)
    }
    
    func decodeIfPresent<T: Decodable>(_ key: String, as type: T.Type = T.self) throws -> T?{
        return try decodeIfPresent(SmartCodingKey(key), as: type)
    }
    
    func decodeIfPresent<T: Decodable, K: CodingKey>(_ key: K, as type: T.Type = T.self) throws -> T? {
        let container = try self.container(keyedBy: K.self)
        return try container.decodeIfPresent(type, forKey: key)
    }

    func decode<F: SmartDateFormatter>(_ key: String, using formatter: F) throws -> Date {
        return try decode(SmartCodingKey(key), using: formatter)
    }
    
    func decode<K: CodingKey, F: SmartDateFormatter>(_ key: K, using formatter: F) throws -> Date {
        let container = try self.container(keyedBy: K.self)
        let rawString = try container.decode(String.self, forKey: key)
        guard let date = formatter.date(from: rawString) else {
            throw DecodingError.dataCorruptedError(forKey: key, in: container, debugDescription: "Unable to format date string")
        }
        return date
    }
}

protocol CaseIterableDefaultsLast: SmartDecodable & CaseIterable & RawRepresentable
where RawValue: Decodable, AllCases: BidirectionalCollection { }

extension CaseIterableDefaultsLast {
    init(from decoder: Decoder) throws {
        self = try Self(rawValue: decoder.singleValueContainer().decode(RawValue.self)) ?? Self.allCases.last!
    }
}
