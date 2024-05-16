//
//  BottomNavigationView.swift
//  CryptoWallet
//
//  Created by Rishik  Sood on 09/05/24.
//

import SwiftUI

struct BottomNavigationView: View {
    
    @Binding var selectedIndex: Int
    let icons = [
        "house",
        "bitcoinsign",
        "person"
    ]
    
    var body: some View {
        VStack {
            ZStack {
                Divider()
                    .shadow(radius: 10)
                    ZStack {
                    }
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .background(.creme)
  
                HStack {
                    ForEach(0..<3, id: \.self) { number in
                        Spacer()
                        
                        Button(action: {
                            self.selectedIndex = number
                        }, label: {
                            if number == 1 {
                                Image(systemName: icons[number])
                                    .font(.system(size: 25, weight: .regular, design: .rounded))
                                    .foregroundColor(.white)
                                    .frame(width: 40, height: 40)
                                    .padding(2)
                                    .background(selectedIndex == number ? .lilacDark : Color(UIColor.black))
                                    .cornerRadius(30)
                            } else {
                                Image(systemName: icons[number])
                                    .font(.system(size: 25, weight: .regular, design: .rounded))
                                    .foregroundColor(selectedIndex == number ? .lilacDark : Color(UIColor.black))
                            }
                        })
                        Spacer()
                    }
                }
            }
        }
    }
}


#Preview {
    BottomNavigationView(selectedIndex: .constant(0))
}
