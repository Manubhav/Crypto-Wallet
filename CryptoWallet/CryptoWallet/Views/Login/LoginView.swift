//
//  LoginView.swift
//  CryptoWallet
//
//  Created by Rishik  Sood on 09/05/24.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        Image("Login")
            .resizable()
            .scaledToFill()
            .frame(width: 250, height: 200)
            .padding(.vertical,32)
        VStack(spacing: 24) {
            InputView(text: $email,
                      title: "Email Address",
                      placeholder: "name@example.com")
            .autocapitalization(.none)
            InputView(text: $password,
                      title: "Password",
                      placeholder: "Enter your password",
                      isSecureField: true)
        }
        .padding(.horizontal)
        .padding(.top, 12)
        
        Button {
            Task {
                try await viewModel.signIn(withEmail: email, password: password)
            }
            
        } label: {
                HStack {
                    Text("SIGN IN")
                        .fontWeight(.semibold)
                }
                .foregroundColor(.white)
                .frame(width: UIScreen.main.bounds.width - 32, height: 48)
            }
        .background(Color(.systemBlue))
        .cornerRadius(10)
        .padding(.top, 24)
        
        Spacer()
    }
}

#Preview {
    LoginView()
}
