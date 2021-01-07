//
//  LocalizedWrapper.swift
//  ProxyModule
//
//  Created by Appg on 2021/01/07.
//

import Foundation

@propertyWrapper
public struct Localized {
    
    //String Localized
    public var wrappedValue : String {
        didSet {
            wrappedValue = NSLocalizedString(wrappedValue, comment: "")
        }
    }
    
    public init(wrappedValue: String) {
        self.wrappedValue = NSLocalizedString(wrappedValue, comment: "")
    }
    
}
