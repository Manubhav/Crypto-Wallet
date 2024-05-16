//
//  CryptoDetailsView.swift
//  CryptoWallet
//
//  Created by Mitch Munro on 16/5/2024.
//

import SwiftUI

struct CryptoDetailsView: View {
    
    @ObservedObject var viewModel = GetCryptoCurrencyDetails()
    @State private var isLoading = false
    
    var body: some View {
        Text("hello1")
        
        if let unrappedDetails = viewModel.cryptoCurrencyDetails{
            Text("hello2")
            
            Text(unrappedDetails.name)
            
        }
        
        
    }
}

#Preview {
    CryptoDetailsView()
}
