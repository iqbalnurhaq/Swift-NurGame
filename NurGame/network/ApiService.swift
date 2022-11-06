//
//  ApiService.swift
//  NurGame
//
//  Created by Iqbal Nur Haq on 06/11/22.
//

import Foundation

struct ApiService {
    
    func fetch(url: URL?, completion: @escaping(Result<Games, ApiError>) -> Void) {
        
        guard let url = url else {
            let error = ApiError.badURL
            completion(Result.failure(error))
            return
        }
        
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error as? URLError {
                completion(Result.failure(ApiError.url(error)))
            }else if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                completion(Result.failure(ApiError.badResponse(statusCode: response.statusCode)))
            }else if let data = data {
                let decoder = JSONDecoder()
                do {
                    let res = try decoder.decode(Games.self, from: data)
                    completion(Result.success(res))
                    
                }catch {
                    completion(Result.failure(ApiError.parsing(error as? DecodingError)))
                }
            }
            
        }
        
        task.resume()
    }
}
