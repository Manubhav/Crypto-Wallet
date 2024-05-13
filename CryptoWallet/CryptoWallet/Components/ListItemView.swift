//
//  ListItemView.swift
//  CryptoWallet
//
//  Created by Rishik  Sood on 11/05/24.
//

import SwiftUI

struct ListItemView: View {
    @ObservedObject var viewModel = GetCryptoCurrencies()
    var coin: CryptoCurrency
    
    var body: some View {
        HStack {
            AsyncImage(url: coin.image) { image in image.resizable()
                
            } placeholder: { Color.gray }
                .frame(width: 45, height: 45)
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 40))
            
            VStack (alignment: .leading) {
                Text(coin.name)
                    .font(.custom(FontUtils.MAIN_BOLD, size: 16))
                    .foregroundColor(.black)
                    .padding(.bottom, 5)
                
                HStack (alignment: .center) {
                    Image(systemName: viewModel.isNonNegative(coin.price_change_percentage_24h) ? "chevron.up" : "chevron.down")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 12)
                        .foregroundColor(viewModel.isNonNegative(coin.price_change_percentage_24h) ? .green : .red)
                        .font(Font.title.weight(.bold))
                    
                    Text("\(String(format: "%.3f", coin.price_change_percentage_24h))%")
                        .font(.custom(FontUtils.MAIN_REGULAR, size: 14))
                        .foregroundColor(viewModel.isNonNegative(coin.price_change_percentage_24h) ? .green : .red)
                    
                }
                
                
            }
            
            Spacer()
            
            VStack (alignment: .trailing) {
                Text("$\(String(format: "%.3f", coin.current_price))")
                    .font(.custom(FontUtils.MAIN_BOLD, size: 16))
                    .foregroundColor(.black)
                    .padding(.bottom, 5)
                
                Text("MCap $\(String(format: "%.1f", coin.market_cap))")
                    .font(.custom(FontUtils.MAIN_REGULAR, size: 13))
                    .foregroundColor(.black)
            }
            
        }
        .padding(.horizontal, 30)
        .padding(.bottom, 10)
    }
}

#Preview {
    ListItemView(coin: CryptoCurrency(id: "bitcoin", symbol: "BTC", name: "Bitcoin", image: URL(string: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1696501400")!, current_price: 17000.0, market_cap: 893.12, price_change_percentage_24h: 0.0))
}
