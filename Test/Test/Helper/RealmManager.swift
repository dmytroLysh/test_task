//
//  RealmManager.swift
//  Test
//
//  Created by Dmytro Lyshtva on 30.01.2025.
//

import RealmSwift

final class RealmManager {
    static let shared = RealmManager()
    
    private let realm: Realm
    
    private init() {
        do {
            realm = try Realm()
        } catch {
            fatalError("Unable to initialize Realm: \(error.localizedDescription)")
        }
    }

    func getSelectedCurrencies() -> [String] {
        return realm.objects(SelectedCurrency.self).map { $0.code }
    }

    func saveSelectedCurrencies(_ currencies: [String]) {
        let existingCurrencies = getSelectedCurrencies()
        

        guard Set(existingCurrencies) != Set(currencies) else { return }
        
        do {
            try realm.write {
                realm.delete(realm.objects(SelectedCurrency.self))
                currencies.forEach { code in
                    let currency = SelectedCurrency(code: code)
                    realm.add(currency)
                }
            }
        } catch {
            print("Error saving currencies to Realm: \(error.localizedDescription)")
        }
    }
}

