//
//  NetworkService.swift
//  WeatherApp
//
//  Created by Göksu Bayram on 11.08.2024.
//

import Foundation

protocol NetworkServiceProtocol {
    func request<T: Codable>(endpoint: APIEndpoint, completion: @escaping (Result<T, Error>) -> Void)
}

enum NetworkError: Error {
    case invalidRequest
    case noData
    case decodingError
    case unauthorized
    case notFound
    case serverError
    case unknownError(statusCode: Int)
    case customError(message: String)
}

class NetworkService: NetworkServiceProtocol {
    func request<T: Codable>(endpoint: APIEndpoint, completion: @escaping (Result<T, Error>) -> Void) {
        guard let request = endpoint.request else {
            completion(.failure(NetworkError.invalidRequest))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(NetworkError.customError(message: error.localizedDescription)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NetworkError.unknownError(statusCode: 0)))
                return
            }
            
            switch httpResponse.statusCode {
            case 200...299:
                guard let data = data else {
                    completion(.failure(NetworkError.noData))
                    return
                }
                
                do {
                    let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decodedResponse))
                } catch {
                    completion(.failure(NetworkError.decodingError))
                }
                
            case 401:
                completion(.failure(NetworkError.unauthorized))
                
            case 404:
                completion(.failure(NetworkError.notFound))
                
            case 500...599:
                completion(.failure(NetworkError.serverError))
                
            default:
                completion(.failure(NetworkError.unknownError(statusCode: httpResponse.statusCode)))
            }
        }.resume()
    }
}
