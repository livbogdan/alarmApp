import SwiftUI

struct SettingRowView: View {
    
    // Properties
    let imageName: String
    let title: String
    let tintColor: Color
    
    var body: some View {
        
        HStack {
            
            // Image
            Image(systemName: imageName)
                .imageScale(.small)
                .font(.title)
                .foregroundColor(tintColor)
            
            // Title text
            Text(title)
                .font(.subheadline)
                .foregroundColor(nickel)
        }
    }
}

// Preview
struct SettingRowView_Previews: PreviewProvider {
    static var previews: some View {
        SettingRowView(imageName: "gear", title: "Version", tintColor: nickel)
    }
}
