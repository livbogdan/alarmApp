
import SwiftUI

struct PasswordTextFieldView: View {
    @Binding var password: String
      
      var body: some View {
          VStack {
              SecureField("Password", text: $password)
                  .disableAutocorrection(true)
          }
          .padding()
          .background(white)
          .cornerRadius(5)
          .shadow(color: nickel.opacity(0.3), radius: 5)
          .overlay(
            RoundedRectangle(cornerRadius: 5)
               .stroke(nickel, lineWidth: 1)
          )
      }
}

struct PasswordTextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            PasswordTextFieldView(password: .constant(""))
            
            PasswordTextFieldView(password: .constant("password"))
        }.padding()
    }
}
