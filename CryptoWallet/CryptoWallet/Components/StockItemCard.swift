//
//  StockItemCard.swift
//  CryptoWallet
//
//  Created by Rishik  Sood on 12/05/24.
//

import SwiftUI
import Charts

struct StockItemCard: View {
    
    var coinName: String
    var coinTicker: String
    var coinImage: String
    var coinPrice: String
    var coinGoingUp: Bool
    var coinMove: String
    var coinColors: [Color]

    var body: some View {
            VStack (alignment: .leading) {
                HStack (alignment: .center) {
                    AsyncImage(url: URL(string: coinImage)) { image in image.resizable()
                        } placeholder: { Color.gray }
                        .frame(width: 45, height: 45)
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 40))

                    VStack (alignment: .leading) {
                        Text(coinName)
                            .font(.custom(FontUtils.MAIN_BOLD, size: 16))
                            .foregroundColor(.white)
                            .padding(.bottom, 5)
                     
                        Text(coinTicker)
                            .font(.custom(FontUtils.MAIN_MEDIUM, size: 14))
                            .foregroundColor(.white)
                            .opacity(0.5)
                    }
                    Spacer()
                }
                Spacer()
                
                HStack {
                    VStack (alignment: .leading) {
                        Text("$\(coinPrice)")
                            .font(.custom(FontUtils.MAIN_BOLD, size: 16))
                            .foregroundColor(.white)
                        
                        HStack (alignment: .center) {
                            Image(systemName: coinGoingUp ? "chevron.up" : "chevron.down")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 12)
                                .foregroundColor(coinGoingUp ? .green : .red)
                                .font(Font.title.weight(.bold))
                            
                            Text("\(coinMove)%")
                                .font(.custom(FontUtils.MAIN_REGULAR, size: 14))
                                .foregroundColor(coinGoingUp ? .green : .red)
                            
                        }
                        .padding(.horizontal, 10)
                        .padding(.vertical, 7)
                        .background(.white)
                        .cornerRadius(30)
                        
                    }
                    
                    Chart {
                        ForEach(0..<5, id: \.self) { item in
                            LineMark(
                                x: .value("x", item),
                                y: .value("y", Int.random(in: 0...5))
                            )
                            .lineStyle(.init(lineWidth: 2))
                            .foregroundStyle(.white)
                            .opacity(0.5)
                            
                        }
                    }
                    .chartYAxis(.hidden)
                    .chartXAxis(.hidden)
                }
                
                
            }
            .padding()
            .frame(width: 190, height: 130)
            .background( LinearGradient(
                colors: coinColors,
                startPoint: .topLeading,
                endPoint: .bottomTrailing))
            
            .cornerRadius(15)
            .shadow(radius: 3)
        
    }
}

#Preview {
    StockItemCard(coinName: "Bitcoin", coinTicker: "BTC", coinImage: "https://icons.iconarchive.com/icons/cjdowner/cryptocurrency-flat/1024/Bitcoin-BTC-icon.png", coinPrice: "17000", coinGoingUp: true, coinMove: "2.5", coinColors: [Color(.orange), Color(.yellow)])
}
