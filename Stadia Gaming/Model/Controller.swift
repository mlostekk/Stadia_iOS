// Copyright (c) 2020 Nomad5. All rights reserved.

import Foundation

/// Struct for generating a js readable json that contains the
/// proper values from the native controller
struct Controller: Encodable {

    /// Button of the controller
    public struct Button: Encodable {
        let pressed: Bool
        let value:   Double
    }

    /// Axes and buttons are the only dynamic values
    let axes:    [Double]
    let buttons: [Button?]

    /// Some static ones for proper configuration
    private let connected: Bool   = true
    private let id:        String = "Emulated iOS Controller"
    private let index:     Int    = 0
    private let mapping:   String = "standard"
    private let timestamp: Double = 0

    /// Conversion to json
    var jsonString: String {
        guard let data = try? JSONEncoder().encode(self),
              let string = String(data: data, encoding: .utf8) else {
            return "{}"
        }
        return string
    }
}

