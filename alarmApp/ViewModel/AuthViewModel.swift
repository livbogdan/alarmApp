// MARK: - Imports

import Foundation
import Firebase
import FirebaseFirestoreSwift

// MARK: - Form Validation Protocol

protocol AuthenticationFormProtocol {
  var formIsValid: Bool {get}
}

// MARK: - AuthViewModel

@MainActor
class AuthViewModel: ObservableObject {

  // MARK: - Properties
  
  @Published var userSession: FirebaseAuth.User?
  
  @Published var currentUser: User?
   
  // MARK: - Initialization
  
  init() {
   
    self.userSession = Auth.auth().currentUser
   
    Task{
      await fetchUser()
    }
    
  }

  // MARK: - Sign In
  
  func signIn(withEmail email: String, password: String) async throws {
    
    do {
    
      let result = try await Auth.auth().signIn(withEmail: email, password: password)
      
      self.userSession = result.user
      
      await fetchUser()
      
    } catch {
        
    }
    
  }
  
  // MARK: - Create User
  
  func createUseer(withEmail email: String, password: String, fullname: String)async throws {

    do {
    
      let result = try await Auth.auth().createUser(withEmail: email, password: password)
      
      self.userSession = result.user
      
      let user = User(id: result.user.uid, fullName: fullname, email: email)
      
      let encodedUser = try Firestore.Encoder().encode(user)
      
      try await Firestore.firestore().collection("user").document(user.id).setData(encodedUser)
      
      await fetchUser()
      
    } catch {
    
      print("DEBUG: Failed to create user with error \(error.localizedDescription)")
      
    }

  }
  
  // MARK: - Sign Out
  
  func signOut() {
  
    do {
    
      try Auth.auth().signOut()
      
      self.userSession = nil
      
      self.currentUser = nil
      
    } catch {
    
      print("Failed to sign out\(error.localizedDescription)")
      
    }
  
  }

  // MARK: - Delete Account
  
    func deleteAccount() {
      do {
        try Auth.auth().currentUser?.delete()
        self.userSession = nil
      } catch {
        print("Failed to delete user: \(error)")
      }
    }



  // MARK: - Fetch User

  func fetchUser() async {

    guard let uid = Auth.auth().currentUser?.uid else {return}
    
    guard let snapshot = try? await Firestore.firestore().collection("user").document(uid).getDocument() else {return}
    
    self.currentUser = try? snapshot.data(as: User.self)
    
    //print("Current user is \(String(describing: self.currentUser))")

  }
  
}
