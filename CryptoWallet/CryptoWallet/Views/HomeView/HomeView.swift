//
//  HomeView.swift
//  CryptoWallet
//
//  Created by Rishik  Sood on 01/05/24.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel = HomeViewModel()

    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    Text("Current balance")
                        .fontWeight(.light)
                    Text("$\(viewModel.walletValue, specifier: "%.2f")")
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
                        Text("$\(viewModel.currentFunds, specifier: "%.2f")")
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
                        TextField("Enter amount", text: $viewModel.fundsToAdd)
                            .padding()
                            .background(Color.greyLight.opacity(0.2))
                            .cornerRadius(5)
                        HStack {
                            Button("Submit") {
                                viewModel.addFunds()
                                viewModel.showingAddFundsOverlay = false
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
                Spacer()
            }
            .padding()
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
