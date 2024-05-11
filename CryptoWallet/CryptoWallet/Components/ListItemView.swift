//
//  ListItemView.swift
//  CryptoWallet
//
//  Created by Rishik  Sood on 11/05/24.
//

import SwiftUI

struct ListItemView: View {
    
    var coin: Coin
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: coin.coinImage)) { image in image.resizable()
                
            } placeholder: { Color.gray }
                .frame(width: 45, height: 45)
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 40))
            
            VStack (alignment: .leading) {
                Text(coin.coinName)
                    .font(.custom(FontUtils.MAIN_BOLD, size: 16))
                    .foregroundColor(.black)
                    .padding(.bottom, 5)
                
                HStack (alignment: .center) {
                    Image(systemName: coin.coinGoingUp ? "chevron.up" : "chevron.down")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 12)
                        .foregroundColor(coin.coinGoingUp ? .green : .red)
                        .font(Font.title.weight(.bold))
                    
                    Text("\(coin.coinMove)%")
                        .font(.custom(FontUtils.MAIN_REGULAR, size: 14))
                        .foregroundColor(coin.coinGoingUp ? .green : .red)
                    
                }
                
                
            }
            
            Spacer()
            
            VStack (alignment: .trailing) {
                Text("$\(coin.coinPrice)")
                    .font(.custom(FontUtils.MAIN_BOLD, size: 16))
                    .foregroundColor(.black)
                    .padding(.bottom, 5)
                
                Text("MCap $\(coin.mcap) Bn")
                    .font(.custom(FontUtils.MAIN_REGULAR, size: 13))
                    .foregroundColor(.black)
            }
            
        }
        .padding(.horizontal, 30)
        .padding(.bottom, 10)
    }
}

#Preview {
    ListItemView(coin: Coin(coinName: "Bitcoin", coinTicker: "BTC", coinImage: "https://icons.iconarchive.com/icons/cjdowner/cryptocurrency-flat/1024/Bitcoin-BTC-icon.png", coinPrice: "17,000", coinGoingUp: true, coinMove: "2.5", coinColors: [Color("#FEA82E"), Color("#F49219")], mcap: "893.12"))
}
