//
//  SmartDateFormatter.swift
//  SmartCodableDemo
//
//  Created by 罗树新 on 2021/1/31.
//

import Foundation

public protocol SmartDateFormatter {
    func date(from string: String) -> Date?
    func string(from date: Date) -> String
}

extension DateFormatter: SmartDateFormatter {}

@available(iOS 10.0, macOS 10.12, tvOS 10.0, *)
extension ISO8601DateFormatter: SmartDateFormatter{}
