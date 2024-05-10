import Cocoa
import Foundation

// Define the parameters
let ids = "bitcoin,ethereum,solana" // Example coins' ids, comma-separated
let vsCurrencies = "usd,eur,aud" // Example target currencies, comma-separated

// Construct the URL with parameters
var urlComponents = URLComponents(string: "https://api.coingecko.com/api/v3/simple/price")!
urlComponents.queryItems = [
    URLQueryItem(name: "ids", value: ids),
    URLQueryItem(name: "vs_currencies", value: vsCurrencies)
]
guard let url = urlComponents.url else {
    fatalError("Invalid URL")
}

var request = URLRequest(url: url)
request.httpMethod = "GET"
request.timeoutInterval = 10
request.allHTTPHeaderFields = [
  "accept": "application/json",
  "x-cg-demo-api-key": "CG-NxtbLJQ2qTihqFGWtCPS1v1W"
]

Task {
    do {
        let (data, _) = try await URLSession.shared.data(for: request)
        if let responseString = String(data: data, encoding: .utf8) {
            print(responseString)
        } else {
            print("Invalid UTF-8 data received")
        }
    } catch {
        print("Error: \(error)")
    }
}
