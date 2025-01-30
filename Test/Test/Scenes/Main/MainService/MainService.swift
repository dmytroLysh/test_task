//
//  MainService.swift
//  Test
//
//  Created by Dmytro Lyshtva on 30.01.2025.
//

import Alamofire
import Foundation
import OSLog

protocol MainService: AnyObject {
    func fetch(base: String, symbols: [String], completion: @escaping (Result<ExchangeRatesResponse, Error>) -> Void)
}

final class MainAPIService {
    
    let apiClient: APIService
    
    private let logger = Logger(subsystem: "com.mainAPIService", category: "mainAPIService")
    
    init(apiClient: APIService) {
        self.apiClient = apiClient
    }
}

extension MainAPIService: MainService {
    
    func fetch(base: String, symbols: [String], completion: @escaping (Result<ExchangeRatesResponse,Error>) -> Void) {
        let symbolsList = symbols.joined(separator: ",")
        let url = "https://data.fixer.io/api/latest?access_key=\(APIKeys.apiKey)&base=\(base)&symbols=\(symbolsList)"
        
        apiClient.fetchData(url: url) { result in
            
            switch result {
            case .success(let success):
                let decoder = JSONDecoder()
                
                do {
                    let decodedData = try decoder.decode(ExchangeRatesResponse.self, from: success)
                    completion(.success(decodedData))

                } catch {
                    self.logger.fault("Error decoding JSON: \(error)")
                    completion(.failure(CustomError.decodingError))
                }
                
            case .failure(let failure):
                self.logger.fault("Error fetch JSON: \(failure.localizedDescription)")
                
                if failure.isSessionTaskError {
                    completion(.failure(CustomError.internetError))
                } else {
                    completion(.failure(CustomError.otherError))
                }
            }
        }
    }
}


