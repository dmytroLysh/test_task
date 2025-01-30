//
//  ExchangeRatesResponse.swift
//  Test
//
//  Created by Dmytro Lyshtva on 30.01.2025.
//

import Foundation

struct ExchangeRatesResponse: Codable {
    let base: String
    let date: String
    let rates: [String: Double]
}

extension ExchangeRatesResponse {
    func toCurrencyCells(excluding selectedCurrency: String) -> [CurrencyCell] {
        return rates
            .filter { $0.key.lowercased() != selectedCurrency.lowercased() }
            .map { CurrencyCell(code: $0.key, amount: String(format: "%.4f", $0.value)) }
    }
}
