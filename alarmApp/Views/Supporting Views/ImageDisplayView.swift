

import SwiftUI

struct ImageDisplayView: View {
    let name: String
    let width: CGFloat
    var body: some View {
        Image(name)
            .resizable()
            .scaledToFit()
            .frame(width: width)
    }
}

struct ImageDisplayView_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            ImageDisplayView(name: standardView, width: 50)
            
            Spacer()
            
            ImageDisplayView(name: circularView, width: 50)
        }
        .padding()

    }
}
