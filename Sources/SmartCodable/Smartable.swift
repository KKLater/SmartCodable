//
//  Smartable.swift
//  SmartableDemo
//
//  Created by 罗树新 on 2021/1/31.
//

import Foundation

/// 标识使用 SmartEncoder
public protocol SmartEncodable {}

/// 标识使用 SmartDecoder
public protocol SmartDecodable {}

/// 标识使用 SmartEncoder 或 SmartDecoder
public typealias SmartCodable = SmartEncodable & SmartDecodable
