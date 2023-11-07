

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct RegistrationView: View {
    
    @State private var email = ""
    @State private var password = ""
    @State private var name = ""
    
    let db = Firestore.firestore()
    
    var body: some View {
        
        VStack {
            
            Image(systemName: "person.circle")
                .resizable()
                .frame(width: 150, height: 150)
            
            Spacer()
            
            VStack(spacing: 20) {
                
                EmailTextFieldView(email: $email)
                
                EmailTextFieldView(email: $name)
                
                PasswordTextFieldView(password: $password)
                
            }
            
            Spacer()
            
            Button(action: registerUser) {
                ButtonView(text: "Register")
            }
            
            Spacer()
            
        }
        .padding(40)
        
    }
    
    private func registerUser() {
        
        // Create user in Auth
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) { result, error in
            
            if let error = error {
                print("Registration failed: \(error)")
                return
            }
            
            // Add user to Firestore
            db.collection("users").addDocument(data: [
                "uid": result!.user.uid,
                "email": self.email,
                "name": self.name
            ]) { error in
                if let error = error {
                    print("Error adding user to Firestore: \(error)")
                    return
                }
                
                print("Successfully added user to Firestore")
            }
            
        }
    }
    
    struct RegisterTextFieldView_Previews: PreviewProvider {
        static var previews: some View {
            RegistrationView()
        }
    }
    
}
