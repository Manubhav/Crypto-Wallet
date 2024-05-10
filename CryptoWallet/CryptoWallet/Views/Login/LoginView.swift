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
    @State private var isLoading = false
    
    var body: some View {
        if isLoading {
            ZStack {
                Color.black.opacity(0.5)
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .foregroundColor(.white)
            }
            .ignoresSafeArea(.all)
        } else {
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
                    isLoading = true // Start loading
                    try await viewModel.signIn(withEmail: email, password: password)
                    isLoading = false // Stop loading after task completion
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
            .disabled(!formIsValid)
            .opacity(formIsValid ? 1.0 : 0.5 )
            .cornerRadius(10)
            .padding(.top, 24)
            Spacer()
        }
//        Spacer()
    }
}

extension LoginView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
    }
}

#Preview {
    LoginView()
        .environmentObject(AuthViewModel())
}
