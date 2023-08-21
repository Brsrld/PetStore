//
//  Encodable+Extension.swift
//  PetStore
//
//  Created by Brsrld on 21.08.2023.
//

import Foundation
import UIKit

struct JSON {
    static let encoder = JSONEncoder()
}

extension Encodable {
    subscript(key: String) -> Any? {
        return dictionary[key]
    }
    var dictionary: [String: Any] {
        return (try? JSONSerialization.jsonObject(with: JSON.encoder.encode(self))) as? [String: Any] ?? [:]
    }
}
