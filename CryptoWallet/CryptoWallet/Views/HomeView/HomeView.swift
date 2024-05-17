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
    @ObservedObject var coinModel = GetCryptoCurrencies()
    @State private var fundsToAdd: String
    @State private var isLoading = false
    
    let colors: [Color] = [Color(.orangee), Color(.yelloww)]

    
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
                                .padding(.top, 20)
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
                                    .padding(.bottom, 12)
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: 300)
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
                    HStack {
                        Text("Your Stock")
                            .font(.custom(FontUtils.MAIN_BOLD, size: 24))
                            .foregroundColor(.black)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 15, height: 15)
                            .foregroundColor(.gray)
                    }
                    .padding(.top, 10)
                    .padding(.horizontal, 30)
                    if isLoading {
                        LoadingView()
                    } else {
                        ScrollView (.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(Array(coinModel.cryptoCurrencies.prefix(6)), id: \.id) { currency in
                                    StockItemCard(coinName: currency.name, coinTicker: currency.symbol, coinImage: currency.image.absoluteString, coinPrice: String(currency.current_price), coinGoingUp: coinModel.isNonNegative(currency.price_change_percentage_24h), coinMove: String(currency.price_change_percentage_24h), coinColors: colors)
                                }
                                .padding(.vertical, 5)
                                .padding(.horizontal, 10)
                                   
                            }
                        }
                        .padding(.horizontal, 15)
                    }

                    
                    Text("Top 4 Crypto Currencies")
                        .font(.custom(FontUtils.MAIN_BOLD, size: 24))
                        .foregroundColor(.black)
                        .padding(.top, 12)
                    if isLoading {
                        LoadingView()
                    } else {
                        ScrollView (.vertical, showsIndicators: false) {
                            VStack (alignment: .leading) {
                                ForEach(Array(coinModel.cryptoCurrencies.prefix(4)), id: \.id) { coin in
                                    ListItemView2(coin: coin)
                                }
                            }
                        }
                        .padding(.top, 12)
                    }

                }
                .background(.creme)
                .task {
                    isLoading = true
                    await coinModel.fetchCryptoCurrencies()
                    isLoading = false
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
