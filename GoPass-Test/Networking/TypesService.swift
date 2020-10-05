//
//  TypesService.swift
//  GoPass-Test
//
//  Created by Juan on 5/10/20.
//

import Foundation

struct TypesService {
    let restCleint: RestClient

    func getDocumentTypes(completion: @escaping (Result<[DocumentType]?, Error>) -> Void) {
        restCleint.run(.documentType, method: .get) { (result: Result<ServerResponse<[DocumentType]>, Error>) in
            switch result {
            case .success(let response):
                completion(.success(response.data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
