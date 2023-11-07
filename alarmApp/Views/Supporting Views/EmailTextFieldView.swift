

import SwiftUI

struct EmailTextFieldView: View {

  let placeholder = "E-mail"
  @Binding var email: String
  
  // Add a state variable to track validation error
  @State private var showError = false

  var body: some View {
      
      if showError {
            Text("Invalid email")
              .font(.caption)
              .foregroundColor(.red)
          }

    VStack {
      

        
      TextField(placeholder, text: $email)
        .keyboardType(.emailAddress)
        .autocapitalization(.none)
        .autocorrectionDisabled(true)
      
      // Check if email is valid on change
      .onChange(of: email) { newValue in
        showError = !newValue.isValidEmail()
      }
      
      // Display error message if invalid
        
      
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

// Email validation extension
extension String {

  func isValidEmail() -> Bool {

    // Updated regex to check for:
    // - At least one character before @
    // - At least two characters after .
    // - Top level domain is 2-6 characters
    let emailReg = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}$"

    let emailPred = NSPredicate(format:"SELF MATCHES %@", emailReg)
    return emailPred.evaluate(with: self)

  }

}


struct TextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            EmailTextFieldView(email: .constant("  sf  ddf"))
            
            EmailTextFieldView(email: .constant("emailus@.com"))
        }
        .padding()
    }
}
