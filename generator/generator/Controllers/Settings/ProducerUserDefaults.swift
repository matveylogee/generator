//
//  ProducerUserDefaults.swift
//  generator
//
//  Created by Матвей on 08.04.2024.
//

import Foundation
import UIKit

protocol ProducerUserDefaultsProtocol {
    func set(_ object: Any?, forKey key: ProducerUserDefaults.Keys)
    func string(forKey key: ProducerUserDefaults.Keys) -> String?
}

final class ProducerUserDefaults {
    
    public enum Keys: String {
        case producerName
        case producerNickName
    }
    
    private let userDefaults = UserDefaults.standard
    
    private func store(_ object: Any?, key: String) {
        userDefaults.set(object, forKey: key)
    }
    
    private func restore(forKey key: String) -> Any? {
        userDefaults.object(forKey: key)
    }
}

// MARK: - ProducerUserDefaultsProtocol
extension ProducerUserDefaults: ProducerUserDefaultsProtocol {
    func string(forKey key: Keys) -> String? {
        restore(forKey: key.rawValue) as? String
    }
    
    func set(_ object: Any?, forKey key: Keys) {
        store(object, key: key.rawValue)
    }
    
}
