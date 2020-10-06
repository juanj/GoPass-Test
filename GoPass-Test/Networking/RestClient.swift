//
//  RestClient.swift
//  GoPass-Test
//
//  Created by Juan on 5/10/20.
//

import Foundation

class RestClient {
    enum RestError: Error, LocalizedError {
        case badUrl
        case httpError(code: Int, message: String?)
        case responseError(Int)
        case noData

        var errorDescription: String? {
            switch self {
            case .httpError(let code, let message):
                if let message = message {
                    return message
                } else {
                    return "\(code)"
                }
            default:
                return "Error \(self)"
            }
        }
    }
    static let shared = RestClient()
    var session = URLSession(configuration: .default)

    private let baseURL = "https://apiprueba.gopass.com.co/"
    func run<ResponseData: Decodable>(_ endpoint: Endpoint, method: RequestMethod, data: Data? = nil, completion: @escaping (Result<ServerResponse<ResponseData>, Error>) -> Void) {
        var baseURL = self.baseURL// This is just a work arownd to get document types
        if endpoint == .documentType {
            // For some reason calling this endpoint on https://apiprueba.gopass.com.co/ give an error
            // but calling it on https://test.gopass.com.co/tipo/documento/ works
            baseURL = "https://test.gopass.com.co/tipo/documento/"
        }

        guard let url = URL(string: "\(baseURL)\(endpoint.rawValue)") else {
            completion(.failure(RestError.badUrl))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.stringValue
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        if let data = data {
            request.httpBody = data
        }

        let task = session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }

                guard let response = response as? HTTPURLResponse else {
                    completion(.failure(RestError.responseError(0)))
                    return
                }

                guard (200...299).contains(response.statusCode) else {
                    var message: String? = nil
                    if let data = data {
                        do {
                            let decoder = JSONDecoder()
                            let error = try decoder.decode(ServerError.self, from: data)
                            message = error.message
                        } catch {
                            message = String(data: data, encoding: .utf8)
                        }
                    }
                    completion(.failure(RestError.httpError(code: response.statusCode, message: message)))
                    return
                }

                guard let data = data else {
                    completion(.failure(RestError.noData))
                    return
                }

                do {
                    let decoder = JSONDecoder()
                    let decodedResponse = try decoder.decode(ServerResponse<ResponseData>.self, from: data)
                    completion(.success(decodedResponse))
                } catch let error {
                    completion(.failure(error))
                }

            }
        }

        task.resume()
    }
}
