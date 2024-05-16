//
//  GetCryptoCurrencyDetails.swift
//  CryptoWallet
//
//  Created by Mitch Munro on 16/5/2024.
//

import Foundation
import SwiftUI

struct CryptoCurrencyDetails: Codable, Identifiable {
    let id: String
    let symbol: String
    let name: String
    let image: URL
    let current_price: Double
    let market_cap: Double
    let price_change_percentage_24h: Double
}


class GetCryptoCurrencyDetails: ObservableObject {
    
    @Published var cryptoCurrencyDetails: CryptoCurrencyDetails?
    
    func fetchCryptoCurrencies() async {
       
        let url = URL(string: "https://api.coingecko.com/api/v3/coins/id")!
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        let queryItems: [URLQueryItem] = [
          URLQueryItem(name: "vs_currency", value: "usd"),
        ]
        components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
          "accept": "application/json",
          "x-cg-demo-api-key": "CG-otzAwL4DRtkkp9oLz8FEyyyY"
        ]
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decoder = JSONDecoder()
            self.cryptoCurrencyDetails = try decoder.decode(CryptoCurrencyDetails.self, from: data)
            print(cryptoCurrencyDetails ?? "No cryptocurrency details found.")
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
}
    

    
