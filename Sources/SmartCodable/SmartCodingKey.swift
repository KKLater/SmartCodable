//
//  SmartCodingKey.swift
//  SmartCodableDemo
//
//  Created by 罗树新 on 2021/1/31.
//

import Foundation

struct SmartCodingKey: CodingKey {
    var stringValue: String
    var intValue: Int?
    
    init(_ string: String) {
        stringValue = string
    }
    
    init?(stringValue: String) {
        self.stringValue = stringValue
    }
    
    init?(intValue: Int) {
        self.intValue = intValue
        self.stringValue = String(intValue)
    }
}
