//
//  CryptoCurrencyDetailsModel.swift
//  CryptoWallet
//
//  Created by Mitch Munro on 17/5/2024.
//

import Foundation

struct CryptoCurrencyDetailsModel: Codable, Identifiable{
    let id: String
    let symbol: String
    let name: String
    let image: ImageURLs
    let market_data: _market_data
//    let current_price: Double
//    let market_cap: Double
//    let price_change_percentage_24h: Double
    
    struct ImageURLs: Codable {
        let thumb: URL
        let small: URL
        let large: URL
    }
    
    struct _market_data: Codable{
        let current_price: _current_price
        let market_cap: _market_cap
        let market_cap_rank: Double
        let high_24h: _high_24h
        let low_24h: _low_24h
        let price_change_percentage_24h: Double
        let price_change_percentage_7d: Double
        let price_change_percentage_14d: Double
        let price_change_percentage_30d: Double
        let price_change_percentage_1y: Double
        let last_updated: String

    }
    
    struct _current_price: Codable{
        let aud: Double
    }
    
    struct _market_cap: Codable{
        let aud: Double
    }
    
    struct _high_24h: Codable{
        let aud: Double
    }
    
    struct _low_24h: Codable{
        let aud: Double
    }
}
