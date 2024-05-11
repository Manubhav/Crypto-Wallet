//
//  HomeView.swift
//  CryptoWallet
//
//  Created by Rishik  Sood on 01/05/24.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel = HomeViewModel()
    @EnvironmentObject var model: AuthViewModel
    @State private var fundsToAdd: String
    
    
    var coins: [Coin] = [
        Coin(coinName: "Bitcoin", coinTicker: "BTC", coinImage: "https://icons.iconarchive.com/icons/cjdowner/cryptocurrency-flat/1024/Bitcoin-BTC-icon.png", coinPrice: "17,000", coinGoingUp: true, coinMove: "2.5", coinColors: [Color("#FEA82E"), Color("#F49219")], mcap: "893.12"),
            
            Coin(coinName: "Ethreum", coinTicker: "ETH", coinImage: "https://png.pngtree.com/png-vector/20210427/ourmid/pngtree-ethereum-cryptocurrency-coin-icon-png-image_3246438.jpg", coinPrice: "1,100", coinGoingUp: false, coinMove: "1.5", coinColors: [Color("#383838"), Color("#161717")], mcap: "393.12"),
            
            Coin(coinName: "Polygon", coinTicker: "MATIC", coinImage: "https://cloudfront-us-east-1.images.arcpublishing.com/coindesk/DPYBKVZG55EWFHIK2TVT3HTH7Y.png", coinPrice: "0,8", coinGoingUp: false, coinMove: "0.5", coinColors: [Color("#7E43DA"), Color("#6A32CF")], mcap: "33.12"),
            
            
            Coin(coinName: "Solana", coinTicker: "SOL", coinImage: "https://upload.wikimedia.org/wikipedia/en/b/b9/Solana_logo.png", coinPrice: "18", coinGoingUp: true, coinMove: "5", coinColors: [Color("#1DEA97"), Color("#9241F2")], mcap: "3.12")
            
        ]
    
    init(fundsToAdd: String = "") {
            _fundsToAdd = State(initialValue: fundsToAdd)
        }

    var body: some View {
        if let user = model.currentUser {
            NavigationView {
                VStack {
                    VStack {
                        VStack {
                            Text("Current balance")
                                .fontWeight(.light)
                            Text("$\(user.funds, specifier: "%.2f")")
                                .padding(.bottom, 10)
                                .font(.title)
                                .fontWeight(.medium)
                             
                            HStack {
                                Image(systemName: "chart.line.uptrend.xyaxis")
                                    .foregroundColor(.greenDark)
                                Text("$\(viewModel.profitLoss, specifier: "%.2f")")
                                    .font(.title2)
                                    .fontWeight(.regular)
                                    .foregroundColor(.greenDark)
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: 200)
                        .background(LinearGradient(gradient: Gradient(colors: [Color.lilacLight, Color.blueLight]), startPoint: .topLeading, endPoint: .bottomTrailing))
                        .cornerRadius(10)
                        .padding(.bottom, 15)
                        
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Funds")
                                    .fontWeight(.light)
                                Text("$\(user.funds, specifier: "%.2f")")
                                    .font(.title2)
                                    .fontWeight(.medium)
                            }
                            .frame(maxWidth: .infinity, maxHeight: 100, alignment: .leading)
                            .padding(.horizontal, 30)
                            .background(Color.lilacDark)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(.trailing, 15)

                            VStack {
                                Button(action: {
                                    viewModel.showingAddFundsOverlay = true
                                }) {
                                    Image(systemName: "plus")
                                        .font(.system(size: 30))
                                        .foregroundColor(.white)
                                }
                                .frame(width: 100, height: 100)
                                .background(Color.dark)
                                .cornerRadius(10)
                            }
                            .frame(maxWidth: 100, maxHeight: 100)
                            .background(Color.dark)
                            .cornerRadius(10)
                        }
                        .frame(maxWidth: .infinity, maxHeight: 100)
                        
                        if viewModel.showingAddFundsOverlay {
                            VStack {
                                TextField("Enter amount", text: $fundsToAdd)
                                    .padding()
                                    .background(Color.gray.opacity(0.2))
                                    .keyboardType(.decimalPad)
                                    .cornerRadius(5)
                                HStack {
                                    Button("Submit") {
                                        Task {
                                            do {
                                                let currentFunds = Double(user.funds)
                                                let additionalFunds = Double(fundsToAdd) ?? 0.0
                                                let updatedFunds = currentFunds + additionalFunds
                                                try await model.updateFunds(forUserID: user.id, newFundsAmount: updatedFunds)
                                                viewModel.showingAddFundsOverlay = false
                                            } catch {
                                                // Handle error
                                                print("Error updating funds:", error)
                                            }
                                        }
                                    }
                                    .padding()
                                    .background(Color.lilacDark)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                    .padding(.top, 5)
                                    
                                    Button("Cancel") {
                                        viewModel.showingAddFundsOverlay = false
                                    }
                                    .padding()
                                    .background(Color.dark)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                    .padding(.top, 5)
                                }
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                            .padding(.top, 15)
                        }
                    }
                    .padding()
                    ScrollView (.vertical, showsIndicators: false) {
                        VStack (alignment: .leading) {
                            ForEach(coins) { coin in
                                ListItemView(coin: coin)
                            }
                        }
                    }
                    .padding(.top, 24)
                }
            }
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden()
        }
    }
}

#Preview {
    HomeView(fundsToAdd: "0.0")
        .environmentObject(AuthViewModel())
}
