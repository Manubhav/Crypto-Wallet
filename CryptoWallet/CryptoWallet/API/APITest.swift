//
//  APITest.swift
//  CryptoWallet
//
//  Created by Mitch Munro on 10/5/2024.
//

import Foundation

class APITest {
    
    
    func fetchData() async throws -> Data {
        let url = URL(string: "https://pro-api.coingecko.com/api/v3/ping")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
            "accept": "application/json",
            "x-cg-pro-api-key": "CG-NxtbLJQ2qTihqFGWtCPS1v1W"
        ]

        let (data, _) = try await URLSession.shared.data(for: request)
        return data
    }
}
