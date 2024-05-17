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
                           .foregroundColor(.white)
                           .multilineTextAlignment(.leading)
                           .padding(.top, 12)
                           
                       AsyncImage(url: cryptoDeets.image.large) { image in
                           image.resizable()
                       } placeholder: {
                           Color.gray
                       }
                       .frame(width: 90, height: 90)
                       .scaledToFit()
                       .clipShape(RoundedRectangle(cornerRadius: 40))
                       .padding(.bottom, 2)
                       
                       
                       
                       VStack{
                           Text("Price:")
                               .padding(.vertical, 2)
                               .font(.system(size: 15))
                               .foregroundColor(.lilacLight)
                           Text("$" + formatNumberToString(number: cryptoDeets.market_data.current_price.aud))
                               .font(.system(size: 24, weight: .bold))
                               .bold()
                               .padding(.bottom, 12)
                               .foregroundColor(.white)
                       }
                       .frame(maxWidth: .infinity, minHeight: 85)
                       .background(.dark)
                       .cornerRadius(10)
                       .padding(.bottom, 15)
                       .padding(.horizontal, 12)

                       VStack(alignment: .center) {
                           
                           Text("Change")
                               .font(.system(size: 18))
                               .bold()
                               .padding(.bottom, 2)
                               .foregroundColor(.white)
                               .padding(.top, 12)
                           
                           changeRow(labelText: "7d:", number: cryptoDeets.market_data.price_change_percentage_7d)
                           changeRow(labelText: "14d:", number: cryptoDeets.market_data.price_change_percentage_14d)
                           changeRow(labelText: "30d:", number: cryptoDeets.market_data.price_change_percentage_30d)
                           changeRow(labelText: "1Y:", number: cryptoDeets.market_data.price_change_percentage_1y)
                               .padding(.bottom, 12)

                       }
                       .frame(maxWidth: .infinity)
                       .background(.dark)
                       .cornerRadius(10)
                       .padding(.horizontal, 12)
                       
                       HStack{
                           VStack{
                               Text("24h Range")
                                   .font(.system(size: 16))
                                   .bold()
                                   .padding(.bottom, 2)
                                   .foregroundColor(.orange2)
                                   .padding(.top, 12)
                               Spacer()
                               
                               Text("$\(formatNumberToString(number: cryptoDeets.market_data.low_24h.aud))")
                                   .font(.system(size: 14))
                                   .foregroundColor(.white)
                               Text(" - ")
                                   .font(.system(size: 14))
                                   .foregroundColor(.white)
                               Text("$\(formatNumberToString(number: cryptoDeets.market_data.high_24h.aud))")
                                   .font(.system(size: 14))
                                   .foregroundColor(.white)
                                   .padding(.bottom, 7)
                           }
                           .frame(maxWidth: .infinity, maxHeight:.infinity)
                           .background(.dark)
                           .cornerRadius(10)
                           
                           VStack{
                               Text("Market Cap:")
                                   .font(.system(size: 16))
                                   .bold()
                                   .padding(.bottom, 2)
                                   .foregroundColor(.orange2)
                                   .padding(.top, 12)
                               
                               Text("Rank: \(formatNumberToString(number: cryptoDeets.market_data.market_cap_rank, minDecimalPlaces: 0))")
                                   .foregroundColor(.white)
                               Spacer()
                               Text("$ " + formatNumberToString(number: cryptoDeets.market_data.market_cap.aud))
                                   .foregroundColor(.white)
                                   .padding(.bottom, 12)
                                   .font(.system(size: 13))
                               
                           }
                           .frame(maxWidth: .infinity, maxHeight:.infinity)
                           .background(.dark)
                           .cornerRadius(10)
                       }
                       .frame(maxWidth: .infinity, maxHeight: 100)
                       .padding(.horizontal, 12)
                       .padding(.bottom, 20)
                        
                       Button {
                           //Not implemented yet
                       } label: {
                           Text("Buy")
                               .font(.system(size: 20, weight: .semibold))
                               .foregroundColor(.white)
                               .padding(10)
                       }
                            .frame(maxWidth: .infinity, minHeight: 40)
                            .padding(5)
                            .background(Color.orange2)
                            .overlay(
                               RoundedRectangle(cornerRadius: 30)
                                    .stroke(Color.black, lineWidth: 2)
                            )
                            .cornerRadius(30)
                            .padding(.horizontal, 30)
                       
                       Spacer()
                   }
                   
               }
               else{
                   Text("Error loading")
                       .font(.custom(FontUtils.MAIN_BOLD, size: 24))
                       .foregroundColor(.red)
                       .multilineTextAlignment(.leading)
//                       .padding(.top, 12)
               }
           }
        }
        .background(.black)
        .task {
           isLoading = true
           await viewModel.fetchCryptoCurrencyDetails()
           isLoading = false
        }
        
        .background(.black)
    }
    
    func changeRow(labelText: String, number: Double) -> some View{
        let percentageString = formatNumberToString(number: number, maxDecimalPlaces: 3)
        var isPositive = true
        
        if number < 0 {
            isPositive = false;
        }
        
        return HStack(alignment: .center){
            HStack{
                Spacer()
                Text("\(labelText) ")
                    .foregroundColor(.white)
            }
            HStack{
                Image(systemName: isPositive ? "chevron.up" : "chevron.down")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 12)
                    .foregroundColor(isPositive ? .green : .red)
                    .font(Font.title.weight(.bold))
                Text(percentageString + "%")
                    .foregroundColor(isPositive ? .green : .red)
                Spacer()
            }
        }
        .padding(.trailing, 30)
    }
    
    func formatNumberToString(number: Double, minDecimalPlaces: Int = 2, maxDecimalPlaces: Int = 15) -> String{
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = minDecimalPlaces
        formatter.maximumFractionDigits = maxDecimalPlaces
        
        if let formattedString = formatter.string(from: NSNumber(value: number)) {
            return formattedString
        } else {
            print("Error formatting number - returning empty string.")
            return ""
        }
    }
}

#Preview {
    CryptoDetailsView(coinName: "bitcoin")
}
