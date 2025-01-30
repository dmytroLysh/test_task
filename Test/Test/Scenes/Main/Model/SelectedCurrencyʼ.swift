//
//  SelectedCurrencyʼ.swift
//  Test
//
//  Created by Dmytro Lyshtva on 30.01.2025.
//

import RealmSwift

class SelectedCurrency: Object {
    @Persisted var code: String
    
    convenience init(code: String) {
        self.init()
        self.code = code
    }
}
