//
//  APIService.swift
//  Test
//
//  Created by Dmytro Lyshtva on 30.01.2025.
//

import Alamofire
import Foundation

final class APIService {

    private let session: Session
    
    init() {
        let configuration = URLSessionConfiguration.default
        
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        
        configuration.timeoutIntervalForRequest = 5
        configuration.timeoutIntervalForResource = 15
        
        configuration.networkServiceType = .responsiveData
        
        configuration.allowsCellularAccess = true
        configuration.waitsForConnectivity = true
        
        configuration.httpMaximumConnectionsPerHost = 6
        configuration.httpShouldUsePipelining = true
        
        
        self.session = Session(configuration: configuration,
                               startRequestsImmediately: false)
    }
    
    func fetchData(url: String, completion: @escaping (Result<Data, AFError>) -> Void) {
        if let encodedURLString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            if let url = URL(string: encodedURLString) {
                session.request(url, method: .get).responseData(queue: .main) { response in
                    switch response.result {
                    case .success(let data):
                        completion(.success(data))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }.resume()
            }
        }
    }
}
