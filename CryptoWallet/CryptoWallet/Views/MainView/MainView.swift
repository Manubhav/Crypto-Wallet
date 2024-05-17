//
//  MainView.swift
//  CryptoWallet
//
//  Created by Rishik  Sood on 09/05/24.
//

import SwiftUI

struct MainView: View {
    @State var selectedIndex = 0
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        ZStack(alignment: .bottom) {
//            Color(.creme)
//                .edgesIgnoringSafeArea(.all)
            ScrollView {
                    ZStack {
                        switch selectedIndex {
                        case 0:
                        HomeView()
                                .frame(height: UIScreen.main.bounds.height)
                            .padding(.top, 50)
                            .background(Color.creme)

                        case 1:
                            CryptoListView()
                                .padding(.top, 50)
                                .background(Color.black)
                        case 2:
                            ProfileView()
                                .frame( height: UIScreen.main.bounds.height)
                                .padding(.top, 50)
                                .background(Color.creme)
                        default:
                            ProfileView()
                                .padding(.top, 50)
                        }
                    }
            }
            .edgesIgnoringSafeArea(.top)
            BottomNavigationView(selectedIndex: $selectedIndex)
                .edgesIgnoringSafeArea(.bottom)
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    MainView()
        .environmentObject(AuthViewModel())
}
