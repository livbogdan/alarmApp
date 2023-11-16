import SwiftUI

// MARK: - LogInScreenView

struct LogInScreenView: View {

// MARK: - Properties
  
  @State private var email = ""
  
  @State private var password = ""
  
  @State private var showMainView = false
    
  @State private var isSignin = false
  
  @EnvironmentObject var authViewModel: AuthViewModel
  // Create an instance of AuthViewModel for authentication

// MARK: - Body
  
  var body: some View {

    NavigationStack {
    
      VStack {
      
        EmailTextFieldView(email: $email)
              // Input field for email
              
        PasswordTextFieldView(password: $password)
        // Input field for password
        
      }
      .padding()

// MARK: - Sign In
      
      // Sign In button
      Button {
          // Perform user login action
          Task {
              try await authViewModel.signIn(withEmail: email, password: password)
              print("logged in")
          }
          
      } label: {
        ButtonView(text: "Log In")
        // Display "Log In" button
      }
      .disabled(!formIsValid)
      .opacity(formIsValid ? 1.0 : 0.5)

// MARK: - Navigation
      
      // Navigation link to RegistrationView
      NavigationLink {
        RegistrationView()
          .navigationBarBackButtonHidden(true)
          // Hide the back button in the navigation bar
      } label: {
        ButtonView(text: "Register")
        // Display "Register" button to navigate to the registration screen
      }
    }
  }
}

// MARK: - Form Validation

extension LogInScreenView: AuthenticationFormProtocol {

  var formIsValid: Bool {
      return !email.isEmpty
      && email.contains("@")
      && !password.isEmpty
      && password.count > 5
  }

}

// MARK: - Preview

struct SignInScreenView_Previews: PreviewProvider {

  static var previews: some View {
    LogInScreenView() // Preview this view
  }

}
