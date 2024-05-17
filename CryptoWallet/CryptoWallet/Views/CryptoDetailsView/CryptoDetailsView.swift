//
//  CryptoDetailsView.swift
//  CryptoWallet
//
//  Created by Mitch Munro on 16/5/2024.
//

import SwiftUI

struct CryptoDetailsView: View {
    
    let coinName: String
    
    @ObservedObject var viewModel: GetCryptoCurrencyDetails
    @State private var isLoading = false
    
    init(coinName: String) {
        self.coinName = coinName
        viewModel = GetCryptoCurrencyDetails(coinName: coinName)
    }
    
    var body: some View {
        
            VStack {
               if isLoading {
                   LoadingView()
                       .padding(.top, UIScreen.main.bounds.height/2)
               } else {
                   
                   if let cryptoDeets = viewModel.cryptoCurrencyDetails{
                       
                       VStack{
                           Text(cryptoDeets.name)
                               .font(.custom(FontUtils.MAIN_BOLD, size: 32))
                               .foregroundColor(.black)
                               .multilineTextAlignment(.leading)
                               .padding(.top, 12)

                           
                           AsyncImage(url: cryptoDeets.image.large) { image in
                               image.resizable()
                           } placeholder: {
                               Color.gray
                           }
                           .frame(width: 100, height: 100)
                           .scaledToFit()
                           .clipShape(RoundedRectangle(cornerRadius: 40))
                           
                           Text(cryptoDeets.symbol)
                               .bold()
                               .padding(.bottom, 12)
                           
                           Text("Price:")
                               .padding(.bottom, 2)
                           Text("$" + formatNumberToString(number: cryptoDeets.market_data.current_price.aud))
                               .font(.custom(FontUtils.MAIN_BOLD, size: 24))
                               .bold()
                               .padding(.bottom, 12)
                           

                           VStack(alignment: .leading) {
                               
                               VStack (alignment: .leading){
                                   Text("Change 24h:   \(showChange(number: cryptoDeets.market_data.price_change_percentage_24h))%")
                                   Text("Change 7d:   \(showChange(number: cryptoDeets.market_data.price_change_percentage_7d))%")
                                   Text("Change 14d:   \(showChange(number: cryptoDeets.market_data.price_change_percentage_14d))%")
                                   Text("Change 30d:   \(showChange(number: cryptoDeets.market_data.price_change_percentage_30d))%")
                                   Text("Change 1Y:   \(showChange(number: cryptoDeets.market_data.price_change_percentage_1y))%")
                               }
                               .padding(.bottom, 7)
                               
                               Text("24h Range:   $\(formatNumberToString(number: cryptoDeets.market_data.low_24h.aud))  -  \(formatNumberToString(number: cryptoDeets.market_data.high_24h.aud))")
                                   .padding(.bottom, 7)
                               
                               
                               VStack (alignment: .leading){
                                   Text("Market Cap Rank: \(formatNumberToString(number: cryptoDeets.market_data.market_cap_rank, minDecimalPlaces: 0))")
                                   Text("Market Cap:   $" + formatNumberToString(number: cryptoDeets.market_data.market_cap.aud))
                               }
                               
                               
                               
                           }
                           .padding()
                           .frame(maxWidth:.infinity, alignment: .leading)
                           
                           
                           
                           
                           Spacer()
                       }
                       
                   }
                   else{
                       Text("Error loading")
                           .font(.custom(FontUtils.MAIN_BOLD, size: 24))
                           .foregroundColor(.red)
                           .multilineTextAlignment(.leading)
                           .padding(.top, 12)
                   }
               }
           }
           .task {
               isLoading = true
               await viewModel.fetchCryptoCurrencyDetails()
               isLoading = false
           }
        

    }
    
    func formatNumberToString(number: Double, minDecimalPlaces: Int = 2) -> String{
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = minDecimalPlaces
        formatter.maximumFractionDigits = 15
        
        if let formattedString = formatter.string(from: NSNumber(value: number)) {
            return formattedString
        } else {
            print("Error formatting number - returning empty string.")
            return ""
        }
    }
    
    func showChange(number: Double) -> String {
        var returnedString = String(number)
        
        if number > 0 {
            returnedString = "+" + String(number)
        }
        
        return returnedString
    }
}

#Preview {
    CryptoDetailsView(coinName: "bitcoin")
}
