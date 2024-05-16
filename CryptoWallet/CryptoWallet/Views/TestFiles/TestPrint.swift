//
//
//  Created by Mitch Munro on 16/5/2024.
//

import SwiftUI

struct TestPrint: View {
    var body: some View {
        Button("Tap me") {
            print("Button tapped!")
        }
    }
}

#Preview {
    TestPrint()
}
