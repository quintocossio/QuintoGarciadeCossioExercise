//
//  APIServiceManager.swift
//  AlbumExerciseApp
//
//  Created by Quinto Cossio on 10/01/2022.
//

import Foundation

let API_URL_PATH = "https://jsonplaceholder.typicode.com/"
let API_URL_ALBUMS = API_URL_PATH + "albums/"
let API_URL_PHOTOS = API_URL_PATH + "photos/"

class NetworkManager: NSObject{
    
    static let sharedManager = NetworkManager()
    
    func fetchAlbums(completed: @escaping (Result<[Album], APError>) -> Void) {
        guard let url = URL(string: API_URL_ALBUMS) else {
            completed(.failure(.invalidURL))
            return
        }
               
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            
            if let _ =  error {
                completed(.failure(.unableToComplete))
                return
            }
                        
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode([Album].self, from: data)
                completed(.success(decodedResponse))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
    
}

