//
//  EstablishmentService.swift
//  GoPass-Test
//
//  Created by Juan on 5/10/20.
//

import Foundation

struct EstablishmentService {
    let restCleint: RestClient

    func getAll(completion: @escaping (Result<[Establishment], Error>) -> Void) {
        restCleint.run(.allEstablishments, method: .get) { (result: Result<ServerResponse<[Establishment]>, Error>) in
            switch result {
            case .success(let response):
                if !response.hasData, let message = response.message {
                    completion(.failure(ServerError(message: message)))
                } else if let establishments = response.data {
                    completion(.success(establishments))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
