// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    private let baseURL = "https://api.themoviedb.org/3"
    private let apiKey = "7fabaf502ac30aa72cc40bb5f42eec9a"
    
    private init() {}
    
    func fetchMovies(completion: @escaping (Result<[Movie], Error>) -> Void ){
        let urlStr = "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)"
        guard let url = URL(string: urlStr) else {
            completion(.failure(NSError(domain:"", code: -1, userInfo: [ NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain:"", code: -2, userInfo: [ NSLocalizedDescriptionKey: "No data received"])))
                return
            }
            do {
                let movieResponse = try JSONDecoder().decode(MoviesResponse.self, from: data)
                completion(.success(movieResponse.results))
            } catch {
                completion(.failure(error))
            }
        } .resume()
    }
}
