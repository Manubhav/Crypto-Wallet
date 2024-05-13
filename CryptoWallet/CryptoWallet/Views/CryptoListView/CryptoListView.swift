//
//  CryptoListView.swift
//  CryptoWallet
//
//  Created by Rishik  Sood on 12/05/24.
//

import SwiftUI

struct CryptoListView: View {
    
    @ObservedObject var viewModel = GetCryptoCurrencies()
    @State private var isLoading = false
    
    var body: some View {
        ScrollView (.vertical, showsIndicators: false) {
            VStack {
               if isLoading {
                   LoadingView()
                       .padding(.top, UIScreen.main.bounds.height/2)
               } else {
                   Text("Trending")
                       .font(.custom(FontUtils.MAIN_BOLD, size: 24))
                       .foregroundColor(.black)
                       .multilineTextAlignment(.leading)
                       .padding(.top, 12)
                   ScrollView (.vertical, showsIndicators: false) {
                       VStack (alignment: .leading) {
                           ForEach(Array(viewModel.cryptoCurrencies), id: \.id) { coin in
                               ListItemView(coin: coin)
                           }
                       }
                   }
                   .padding(.top, 12)               }
           }
           .task {
               isLoading = true
               await viewModel.fetchCryptoCurrencies()
               isLoading = false
           }
        }

    }
}

#Preview {
    CryptoListView()
}
