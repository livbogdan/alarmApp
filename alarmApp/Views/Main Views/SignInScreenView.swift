import SwiftUI
import FirebaseAuth

struct SignInScreenView: View {

  @State private var email = ""
  @State private var password = ""

  @State private var user: User?

  var body: some View {

    VStack {

      EmailTextFieldView(email: $email)
      PasswordTextFieldView(password: $password)

      Button("Sign In") {
        signInUser()
      }

      Button("Register") {
        RegistrationView()
      }

    }

  }

  func signInUser() {
    
    Auth.auth().signIn(withEmail: email, password: password) { result, error in
    
      if let error = error {
        print(error)
        return
      }
      
      guard let user = result?.user else { return }
      self.user = user
      
      // Go to main view
    }

  }

  func registerUser() {

    Auth.auth().createUser(withEmail: email, password: password) { result, error in

      if let error = error {
        print(error)
        return
      }

      guard let user = result?.user else { return }
      self.user = user
      
      // Go to main view

    }

  }

}

    
struct SignInScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SignInScreenView()
    }
}



