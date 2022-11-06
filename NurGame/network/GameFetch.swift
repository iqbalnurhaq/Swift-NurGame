//
//  GameFetch.swift
//  NurGame
//
//  Created by Iqbal Nur Haq on 06/11/22.
//

import Foundation

class GameFetch: ObservableObject {
    
    let apiKey = "d86e6a5a50474ad59c2e4ab44e2c5648"
    
    @Published var data = [Game]()
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    init(){
        getAllGame()
    }
    
    func getAllGame() {
        let api = ApiService()
        
        var components = URLComponents(string: "https://api.rawg.io/api/games")!
        components.queryItems = [
            URLQueryItem(name: "key", value: apiKey)
        ]
    
        
        api.fetch(url: components.url!) { [unowned self] result in
            
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                case .success(let games):
                    self.data = games.game!
                }
            }
                
        }
    }
    
}
