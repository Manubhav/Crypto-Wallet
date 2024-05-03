//
//  HomeViewModel.swift
//  CryptoWallet
//
//  Created by Manuela Penuela on 3/5/2024.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var walletValue: Double = 0.0
    @Published var profitLoss: Double = 0.0
    @Published var currentFunds: Double = 0.0
    @Published var showingAddFundsOverlay = false
    @Published var fundsToAdd: String = ""

    init() {
        loadInitialData()
    }

    func loadInitialData() {
        walletValue = 10000.00
        profitLoss = 500.00
        currentFunds = 3000.00
    }

    func addFunds() {
        if let amount = Double(fundsToAdd) {
            currentFunds += amount
            fundsToAdd = ""  // reset input after adding funds
        }
        showingAddFundsOverlay = false  // hide alert after adding funds
    }
}
