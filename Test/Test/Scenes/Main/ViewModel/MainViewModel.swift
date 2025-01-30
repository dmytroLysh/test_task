//
//  MainViewModel.swift
//  Test
//
//  Created by Dmytro Lyshtva on 30.01.2025.
//

protocol MainNavigation: AnyObject {
}

protocol MainViewModelDelegate: AnyObject {
    func didUpdateCurrency(value: String)
    func didUpdateData(cells: [CurrencyCell])
    func didStartFetch()
    func didFetchError(message:String)
}

final class MainViewModel {
    private var navigation: MainNavigation
    weak var delegate: MainViewModelDelegate?
    private var service: MainService
    private var data: ExchangeRatesResponse?
    private var selectedCurrencies: [String] = ["usd","cad","gbp"]
    
    private var selectedCurrency: String = "EUR"
    
    init(navigation: MainNavigation,service: MainService) {
        self.navigation = navigation
        self.service = service
        loadSelectedCurrencies()
    }
    
     
    func createCurrencyCells() -> [CurrencyCell] {
        let allCurrencies = Countries.currencyCodes
        let selectedCurrencies = RealmManager.shared.getSelectedCurrencies()
        
        let filteredCodes = allCurrencies.filter {
            $0.lowercased() != selectedCurrency.lowercased() && !selectedCurrencies.contains($0)
        }

        let cells = filteredCodes.map { CurrencyCell(code: $0, amount: "0.0") }
        return cells
    }



    func fetchData() {
        delegate?.didStartFetch()
        
        let selectedCurrencies = RealmManager.shared.getSelectedCurrencies()

        service.fetch(base: selectedCurrency, symbols: selectedCurrencies) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                self.data = data
                self.delegate?.didUpdateData(cells: data.toCurrencyCells(excluding: selectedCurrency))
            case .failure(let error):
                handleFetchError(error)
            }
        }
    }

    
    func getSelectedCurrencies() -> [String] {
        return selectedCurrencies
    }
    
    private func handleFetchError(_ error: Error) {
        let message: String
        
        if let customError = error as? CustomError {
            switch customError {
            case .internetError:
                message = "Немає інтернеру, спробуйте перепідключити інтернет."
            case .decodingError:
                message = "В безкоштовній версії лише для EUR."
            case .otherError:
                message = "Невідома помилка: "
            }
        } else {
            message = "An unexpected error occurred: \(error.localizedDescription)"
        }
        
        delegate?.didFetchError(message: message) 
    }
        private func loadSelectedCurrencies() {
            let savedCurrencies = RealmManager.shared.getSelectedCurrencies()
            
            if savedCurrencies.isEmpty {
                selectedCurrencies = ["usd", "cad", "gbp"]
                RealmManager.shared.saveSelectedCurrencies(selectedCurrencies)
            } else {
                selectedCurrencies = savedCurrencies
            }
        }
}

extension MainViewModel: PopUpModalDelegate {
    
    func didTapCancel() {
    }
    
    func didTapAccept(selectedValue: String?) {
        let currency = selectedValue ?? ""
        selectedCurrency = currency
        delegate?.didUpdateCurrency(value: currency)
        fetchData()
    }
}


extension MainViewModel: CurrencySelectionDelegate {
    func didSelectCurrencies(_ selectedCurrencies: [String]) {
        self.selectedCurrencies = selectedCurrencies
        RealmManager.shared.saveSelectedCurrencies(selectedCurrencies)
        fetchData()
    }
}
