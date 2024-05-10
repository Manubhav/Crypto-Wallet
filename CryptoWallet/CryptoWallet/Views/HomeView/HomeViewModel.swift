//
//  HomeViewModel.swift
//  CryptoWallet
//
//  Created by Manuela Penuela on 3/5/2024.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var profitLoss: Double = 0.0
    @Published var showingAddFundsOverlay = false

    init() {
        loadInitialData()
    }

    func loadInitialData() {
        profitLoss = 500.00
    }
}
