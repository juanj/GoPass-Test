//
//  UserService.swift
//  GoPass-Test
//
//  Created by Juan on 5/10/20.
//

import Foundation

struct UserService {
    let restCleint: RestClient

    func register(body: RegisterRequestBody, completion: @escaping (Result<User, Error>) -> Void) {
        // To late I discover the backend expects x-www-form-urlencoded insetad of JSON 🤦
        // There is not enough time to write a custom encoder
        // This part of the code was planed with the objective of using JSONEncoder

        // Please pardon this manual encoding
        var encodedString = ""
        encodedString += "tipoDocumento=\(body.documentType)"
        encodedString += "&numeroIdentificacion=\(body.documentNumber)"
        encodedString += "&nombres=" + (body.name.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "")
        encodedString += "&apellidos=" + (body.lastName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "")
        encodedString += "&telefonoMovil=\(body.phoneNumber)"
        encodedString += "&correo=" + (body.email.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "")
        encodedString += "&password=" + (body.password.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "")

        guard let data = encodedString.data(using: .utf8) else { return }

        restCleint.run(.registerUser, method: .post, data: data) { (result: Result<ServerResponse<User>, Error>) in
            switch result {
            case .success(let response):
                if !response.hasData, let message = response.message {
                    completion(.failure(ServerError(message: message)))
                } else if let user = response.data {
                    completion(.success(user))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
