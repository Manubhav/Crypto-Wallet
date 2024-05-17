//
//  GetCryptoCurrencies.swift
//  CryptoWallet
//
//  Created by Rishik  Sood on 13/05/24.
//

import Foundation
import SwiftUI

struct CryptoCurrency: Codable, Identifiable {
    let id: String
    let symbol: String
    let name: String
    let image: URL
    let current_price: Double
    let market_cap: Double
    let price_change_percentage_24h: Double
}


class GetCryptoCurrencies: ObservableObject {
    @Published var cryptoCurrencies: [CryptoCurrency] = []
    
    func formatNumber(_ number: Double) -> String {
        let absNumber = abs(number)
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        
        if absNumber < 1_000 {
            return "\(formatter.string(from: NSNumber(value: number))!)"
        } else if absNumber < 1_000_000 {
            return "\(formatter.string(from: NSNumber(value: number / 1_000))!)K"
        } else if absNumber < 1_000_000_000 {
            return "\(formatter.string(from: NSNumber(value: number / 1_000_000))!)M"
        } else if absNumber < 1_000_000_000_000 {
            return "\(formatter.string(from: NSNumber(value: number / 1_000_000_000))!)B"
        } else {
            return "\(formatter.string(from: NSNumber(value: number / 1_000_000_000_000))!)T"
        }
    }
    
    func isNonNegative(_ number: Double) -> Bool {
        return number >= 0
    }
    
    func fetchCryptoCurrencies() async {
       
        let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets")!
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        let queryItems: [URLQueryItem] = [
          URLQueryItem(name: "vs_currency", value: "aud"),
        ]
        components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems

        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
          "accept": "application/json",
          "x-cg-demo-api-key": "CG-otzAwL4DRtkkp9oLz8FEyyyY"
        ]
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decoder = JSONDecoder()
            self.cryptoCurrencies = try decoder.decode([CryptoCurrency].self, from: data) 
//            print(cryptoCurrencies)
        } catch {
            print("Error: \(error.localizedDescription)")
        }
        
        
        
    }
}

