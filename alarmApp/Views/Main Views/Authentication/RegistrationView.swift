import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct RegistrationView: View {
    
    // MARK: - Properties
    
    @State private var email = "" // Store user's email input
    @State private var name = ""  // Store user's name input
    @State private var password = ""  // Store user's password input
    @State private var confirmPassword = "" // Store user's password confirmation input
    
    @Environment(\.dismiss) var dismiss // Environment variable for dismissing the current view
    @EnvironmentObject var authViewModel: AuthViewModel // Auth view model
    
    // MARK: - Body
    
    var body: some View {
        
        VStack {
            
            // Display a person circle image
            Image(systemName: "person.circle")
                .resizable()
                .frame(width: 150, height: 150)
            
            Spacer()
            
            VStack(spacing: 20) {
                
                // Display an email text field
                EmailTextFieldView(email: $email)
                
                // Consider changing this to TextField
                EmailTextFieldView(email: $name)
                
                // Display a password text field
                PasswordTextFieldView(password: $password)
                
                // Display a text field for confirming the password
                ZStack(alignment: .trailing) {
                    PasswordTextFieldView(password: $confirmPassword)
                    
                    if !password.isEmpty && !confirmPassword.isEmpty {
                        if password == confirmPassword {
                            Image(systemName: "checkmark.circle")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundColor(Color(.systemGreen))
                        } else {
                            Image(systemName: "xmark.circle")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundColor(Color(.systemRed))
                        }
                    }
                }
            }
            
            Spacer()
            
            Button {
                // Action to sign up the user (you should implement user registration logic)
                Task{
                    try await authViewModel.createUseer(withEmail: email, password: password, fullname: name)
                }
                
            } label: {
                // Display a "Register" button
                ButtonView(text: "Register")
            }
            .disabled(!formIsValid)
            .opacity(formIsValid ? 1.0 : 0.5)
            
            Button {
                // Action to navigate to the login screen (make sure this is a valid navigation logic)
                LogInScreenView()
                
            } label: {
                // Display a "Sign In" button
                ButtonView(text: "Sign In")
            }
            
            Spacer()
        }
        .padding(40)
    }
}

// MARK: - Form Validation

extension RegistrationView: AuthenticationFormProtocol {
    
    var formIsValid: Bool {
        return !email.isEmpty
            && email.contains("@")
            && !password.isEmpty
            && password.count > 5
            && confirmPassword == password
            && !name.isEmpty
    }
}

// MARK: - Preview

struct RegisterTextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
