//
//  CoinsViewModel.swift
//  cryptocoin
//
//  Created by James Sweeney on 5/29/24.
//

import Foundation

class CoinsViewModel: ObservableObject {
    @Published var coin = ""
    @Published var price = ""
    
    init() {
        fetchPrice(coin: "bitcoin")
    }
    
    func fetchPrice(coin: String) {
        let urlString = "https://api.coingecko.com/api/v3/simple/price?ids=\(coin)&vs_currencies=usd"
        guard let url = URL(string: urlString) else { return }
        
        print("Fetching price....")
        URLSession.shared.dataTask(with: url) { data, response, error in
            print("Did receive data \(String(describing: data))")
            guard let data = data else { return }
            guard let jsonObject = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else { return }
            guard let value = jsonObject[coin] as? [String: Int] else { return }
            guard let price = value["usd"] else { return }
            
            DispatchQueue.main.async {
                self.coin = coin.capitalized
                self.price = "$\(price)"
            }
        }.resume()
        
        print("Did reach end of function")
    }
    
}
