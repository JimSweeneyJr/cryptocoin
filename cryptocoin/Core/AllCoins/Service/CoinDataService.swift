//
//  CoinDataService.swift
//  cryptocoin
//
//  Created by James Sweeney on 5/31/24.
//

import Foundation

class CoinDataService {
    func fetchPrice(coin: String, completion: @escaping(Double) -> Void) {
        let urlString = "https://api  .coingecko.com/api/v3/simple/price?ids=\(coin)&vs_currencies=usd"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.sync {
                if let error = error {
                    print("DEBUG: Failed with errro \(error.localizedDescription)")
//                    self.errorMessage = error.localizedDescription
                    return
                }
                guard let httpResponse = response as? HTTPURLResponse else {
//                    self.errorMessage = "Bad HTTP Response."
                    return
                }
                
                guard httpResponse.statusCode == 200 else {
//                    self.errorMessage = "Failed to fetch with status code \(httpResponse.statusCode)"
                    return
                }
                
                guard let data = data else { return }
                guard let jsonObject = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else { return }
                guard let value = jsonObject[coin] as? [String: Double] else {
                    print("Failed to parse value")
                    return
                }
                guard let price = value["usd"] else { return }
                
//                self.coin = coin.capitalized
//                self.price = "$\(price)"
                print("DEBUG: Price in service is \(price)")
                completion(price)
            }
        }.resume()
    }
}
