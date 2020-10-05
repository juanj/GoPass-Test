//
//  RestClient.swift
//  GoPass-Test
//
//  Created by Juan on 5/10/20.
//

import Foundation

class RestClient {
    enum RestError: Error {
        case badUrl
        case httpError(Int)
        case responseError(Int)
        case noData
    }
    private let baseURL = "https://test.gopass.com.co/"
    var session = URLSession(configuration: .default)

    func run<ResponseData: Decodable>(_ endpoint: Endpoint, method: RequestMethod, data: Data? = nil, completion: @escaping (Result<ServerResponse<ResponseData>, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)\(endpoint.rawValue)") else {
            completion(.failure(RestError.badUrl))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.stringValue
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        if let data = data {
            request.httpBody = data
        }

        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let response = response as? HTTPURLResponse else {
                completion(.failure(RestError.responseError(0)))
                return
            }

            guard (200...299).contains(response.statusCode) else {
                completion(.failure(RestError.httpError(response.statusCode)))
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

        task.resume()
    }
}
