//
//
//  Created by Mitch Munro on 16/5/2024.
//

import SwiftUI

struct TestPrint: View {
    var body: some View {
        
        VStack{
            Button("Tap me") {
                print("Button tapped!")
            }
            Spacer()
            Text("test")
        }
        .frame(maxWidth:.infinity, alignment: .leading)
        

    }
}

#Preview {
    TestPrint()
}
