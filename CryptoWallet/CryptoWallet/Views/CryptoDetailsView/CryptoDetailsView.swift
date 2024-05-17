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
    
//    var body: some View {
//        Text("hello1")
//        
//        if let unrappedDetails = viewModel.cryptoCurrencyDetails{
//            Text("hello2")
//            
//            Text(unrappedDetails.name)
//        }
//    }
    
    var body: some View {
        ScrollView (.vertical, showsIndicators: false) {
            VStack {
               if isLoading {
                   LoadingView()
                       .padding(.top, UIScreen.main.bounds.height/2)
               } else {
                   
                   if let cryptoDeets = viewModel.cryptoCurrencyDetails{
                       Text("Details:")
                           .font(.custom(FontUtils.MAIN_BOLD, size: 24))
                           .foregroundColor(.black)
                           .multilineTextAlignment(.leading)
                           .padding(.top, 12)
                       Text("Coin Name: " + cryptoDeets.name)
                       Text("Coin Symbol: " + cryptoDeets.symbol)
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

    }
}

#Preview {
    CryptoDetailsView(coinName: "Bitcoin")
}
