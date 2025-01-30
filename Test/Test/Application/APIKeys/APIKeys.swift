//
//  APIKeys.swift
//  Test
//
//  Created by Dmytro Lyshtva on 29.01.2025.
//

import Foundation

struct APIKeys {
    static var apiKey: String {
        guard let apiKey = ProcessInfo.processInfo.environment["API_KEY"], !apiKey.isEmpty else {
            fatalError("API Key is missing. Add it to environment variables.")
        }
        return apiKey
    }
}


