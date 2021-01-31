//
//  SnakeCasable.swift
//  SmartCodableDemo
//
//  Created by 罗树新 on 2021/1/31.
//

import Foundation

/// 标识，encode 过程，encoder 采用 convertToSnakeCase
public protocol EncodeSnakeCasable {}

/// 标识，decode 过程，decoder 采用 convertFromSnakeCase
public protocol DecodeSnakeCasable {}

/// 标识，encode 过程，encoder 采用 convertToSnakeCase；decode 过程，decoder 采用 convertFromSnakeCase
public typealias SnakeCasable = EncodeSnakeCasable & DecodeSnakeCasable
