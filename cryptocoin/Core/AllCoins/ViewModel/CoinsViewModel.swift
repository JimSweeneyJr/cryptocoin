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
    @Published var errorMessage: String?
    
    private let service = CoinDataService()
    
    init() {
        
    }
    
    func fetchPrice(coin: String) {
        service.fetchPrice(coin: coin) { priceFromService in
            print("DEBUG: Price from service is \(priceFromService)")
        }
    }
}
