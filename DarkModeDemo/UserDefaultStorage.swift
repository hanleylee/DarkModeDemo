//
//  UserDefaultStorage.swift
//  HLUtils
//
//  Created by Hanley Lee on 2020/11/30.
//

import Foundation

@propertyWrapper
public struct UserDefaultStorage<T: Codable> {
    var value: T?

    let keyName: String

    let queue = DispatchQueue(label: (UUID().uuidString))

    public init(keyName: String) {
        value = UserDefaults.standard.value(forKey: keyName) as? T
        self.keyName = keyName
    }

    public var wrappedValue: T? {

        get { value }

        set {
            value = newValue
            let keyName = self.keyName
            queue.async {
                if let value = newValue {
                    UserDefaults.standard.setValue(value, forKey: keyName)
                } else {
                    UserDefaults.standard.removeObject(forKey: keyName)
                }
            }
        }
    }
}
