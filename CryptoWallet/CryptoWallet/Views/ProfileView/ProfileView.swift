//
//  ProfileView.swift
//  CryptoWallet
//
//  Created by Rishik  Sood on 01/05/24.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {

        ZStack {
            
            if let user = viewModel.currentUser {
                
                List {
                    Section {
                        HStack {
                            Text(user.initials)
                                .font(.title)
                                .fontWeight(.semibold)
                                .foregroundColor(.orange2)
                                .frame(width: 72, height: 72)
                                .background(Color(.black))
                                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                                .padding(.vertical, 10)
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(user.fullname)
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .padding(.top, 4)
                                    .foregroundColor(.white)
                                
                                Text(user.email)
                                    .font(.footnote)
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    .listRowBackground(Color.lilacDark)

                    
                    
                    Section("General") {
                        HStack {
                            SettingsRowView(imageName: "character.bubble", title: "Language", tintColor: Color(.lilacDark))
                        }
                        HStack {
                            SettingsRowView(imageName: "moon", title: "Dark Mode", tintColor: Color(.lilacDark))
                        }

                    }
                    .listRowBackground(Color.creme)
                    
                    Section("Notifications") {
                        HStack {
                            SettingsRowView(imageName: "bell", title: "Price Alerts", tintColor: Color(.lilacDark))
                        }
                        HStack {
                            SettingsRowView(imageName: "checkmark.seal", title: "Push notifications", tintColor: Color(.lilacDark))
                        }
                    }
                    .listRowBackground(Color.creme)

                    
                    Section("Account") {
                        HStack {
                            SettingsRowView(imageName: "person.3", title: "Refer a Friend", tintColor: Color(.lilacDark))
                            
                        }
                        HStack {
                            SettingsRowView(imageName: "key.horizontal", title: "Security", tintColor: Color(.lilacDark))
                            
                        }
                        Button {
                            viewModel.signOut()
                        } label: {
                            SettingsRowView(imageName: "arrow.left.circle.fill", title: "Sign Out", tintColor: .red)
                        }
                        
                        Button {
                            viewModel.deleteAccount()
                        } label: {
                            SettingsRowView(imageName: "xmark.circle.fill", title: "Delete Account", tintColor: .red)
                        }
                    }
                    .listRowBackground(Color.creme)

                    Section("Support") {
                        HStack {
                            SettingsRowView(imageName: "questionmark.app", title: "Help & Support", tintColor: Color(.lilacDark))
                        }
                        HStack {
                            SettingsRowView(imageName: "ladybug", title: "Report a bug", tintColor: Color(.lilacDark))
                        }
                        HStack {
                            SettingsRowView(imageName: "doc", title: "Terms of Use", tintColor: Color(.lilacDark))
                        }
                    }
                    .listRowBackground(Color.creme)

                    
                }
                .background(Color.creme)
                .scrollContentBackground(.hidden)
            }
        }
    }
}


#Preview {
    ProfileView()
        .environmentObject(AuthViewModel())
}

    
