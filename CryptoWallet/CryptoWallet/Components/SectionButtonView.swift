//
//  SectionButtonView.swift
//  CryptoWallet
//
//  Created by Rishik  Sood on 12/05/24.
//

import SwiftUI

struct SectionButtonView: View {
    
    var title: String
    var action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }, label: {
            HStack {
                Text(title)
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
        })
    }
}
//
//#Preview {
//    SectionButtonView(title: "My Stock", action: "")
//}
