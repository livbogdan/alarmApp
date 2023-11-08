// MARK: - ProfileView

import SwiftUI

struct ProfileView: View {

  // MARK: - Properties
  
  @EnvironmentObject var authViewModel: AuthViewModel
  
  // MARK: - Body

  var body: some View {

    if let user = authViewModel.currentUser {

      List {

        // MARK: - User Info Section
        
        Section {
          
          HStack {
            Text(user.initials)
              .font(.title)
              .fontWeight(.semibold)
              .foregroundColor(white)
              .frame(width: 72, height: 72)
              .background(gray)
              .clipShape(Circle())
              
            VStack (alignment: .leading, spacing: 4) {
              Text(user.fullName)
                .font(.subheadline)
                .fontWeight(.semibold)
                .padding(.top, 4)
              
              Text(user.email)
                .font(.footnote)
                .accentColor(black)
            }
          }
          
        }
        
        // MARK: - General Section
        
        Section("General") {
          HStack {
            SettingRowView(imageName: "gear", title: "Version", tintColor: nickel)
            
            Spacer()
            
            Text("1.0.0")
          }
        }
        
        // MARK: - Account Section
        
        Section("Account") {
          
          Button {
            authViewModel.signOut()
          } label: {
            SettingRowView(imageName: "arrow.uturn.backward.circle", title: "Sign Out", tintColor: .red)
          }
          
          Button {
            authViewModel.deleteAccount()
          } label: {
            SettingRowView(imageName: "trash.circle", title: "Delete account", tintColor: .red)
          }
          
        }
        
      }
      
    }
    
  }
  
}

// MARK: - Preview

struct ProfileView_Previews: PreviewProvider {

  static var previews: some View {
    ProfileView()
      .environmentObject(AuthViewModel())
  }

}
