//
//  NetworkManager.swift
//  PokemonWiki
//
//  Created by Luis Valdés on 24-08-22.
//

import Foundation

struct NetworkManager {
    enum Search {
        case pokemonList
        case singlePokemon
    }
    enum NetworkError: Error {
        case invalidUrl
        case invalidData
    }

    private func createRequest(for url: String) -> URLRequest? {
        guard let url = URL(string: url) else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        return request
    }

    private func executeRequest<T: Codable>(request: URLRequest, completion: ((T?, Error?) -> Void)?) {
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                completion?(nil, error)
                return
            }
            if let decodedResponse = try? JSONDecoder().decode(T.self, from: data) {
                DispatchQueue.main.async {
                    completion?(decodedResponse, nil)
                }
            } else {
                completion?(nil, NetworkError.invalidData)
            }
        }
        dataTask.resume()
    }

    typealias ListCompletionClosure = ((PokemonList?, Error?) -> Void)

    public func listPokemon(limit: Int, offset: Int, completion: ListCompletionClosure?) {
        let api = "https://pokeapi.co/api/v2/pokemon?limit=\(limit)&offset=\(offset)"
        print("URL: \(api)")
        guard let request = createRequest(for: api) else {
            completion?(nil, NetworkError.invalidUrl)
            return
        }
        executeRequest(request: request, completion: completion)
    }

    typealias FetchCompletionClosure = ((PokemonDetail?, Error?) -> Void)

    public func fetchPokemon(name: String, completion: FetchCompletionClosure?) {
        let api = "https://pokeapi.co/api/v2/pokemon/\(name)"
        print("URL: \(api)")
        guard let request = createRequest(for: api) else {
            completion?(nil, NetworkError.invalidUrl)
            return
        }
        executeRequest(request: request, completion: completion)
    }
}
