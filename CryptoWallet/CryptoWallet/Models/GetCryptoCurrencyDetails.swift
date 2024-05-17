//
//  GetCryptoCurrencyDetails.swift
//  CryptoWallet
//
//  Created by Mitch Munro on 16/5/2024.
//

import Foundation
import SwiftUI

class GetCryptoCurrencyDetails: ObservableObject {
    
    @Published var cryptoCurrencyDetails: CryptoCurrencyDetailsModel?
    let coinName: String
    
    init(coinName: String){
        self.coinName = coinName
    }
    
    func fetchCryptoCurrencyDetails() async {
       
        let url = URL(string: "https://api.coingecko.com/api/v3/coins/" + coinName)!
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
//        let queryItems: [URLQueryItem] = [
//          URLQueryItem(name: "vs_currency", value: "usd"),
//        ]
//        components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems

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
            self.cryptoCurrencyDetails = try decoder.decode(CryptoCurrencyDetailsModel.self, from: data)
            print(cryptoCurrencyDetails!)

        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
}
    

    
