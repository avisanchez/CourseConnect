//
//  AuthViewModel.swift
//  CourseConnect
//
//  Created by Avi Sanchez on 7/27/22.
//

import SwiftUI
import Firebase

class AuthViewModel: ObservableObject {
    
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    private let service = UserService()

    init() {
        self.userSession = Auth.auth().currentUser
        self.fetchUser()
    }
    
    func login(withEmail email: String, password: String) {
        print("DEBUG: Login with email \(email)")
        
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: Failed to login with error \(error.localizedDescription)")
                return
            }
            
            guard let user = result?.user else { return }
            self.userSession = user
            self.fetchUser()
            
            print("DEBUG Logged in user sucessfully")
        }
        
    }
    
    func register(withEmail email: String, password: String, fullname: String, school: String, grade: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: Failed to register with error \(error.localizedDescription)")
                return
            }
            
            guard let user = result?.user else { return }
            self.userSession = user
            
            print("DEBUG: Registered user successfully")
            //print("DEBUG: User is \(self.userSession)")
            
            let data = ["email": email,
                        "fullname": fullname,
                        "school": school,
                        "grade": grade]
            
            Firestore.firestore().collection("users").document(user.uid)
                .setData(data) { _ in
                    print("DEBUG: Did upload user data...\(user.uid)")
                }
            
            
            
            let fillerData: [String: Any] = ["MandatoryDefaultParam" : ""]
            
            // create post collection
            Firestore.firestore().collection("users").document(user.uid).collection("user-posts").document("DefaultDocument")
                .setData(fillerData) { _ in
                    print("DEBUG: Did create post collection")
                }
            
            // create comment collection
            Firestore.firestore().collection("users").document(user.uid).collection("user-comments").document("DefaultDocument")
                .setData(fillerData) { _ in
                    print("DEBUG: Did create post collection")
                }
            
    
            
            self.fetchUser()
        }
    }
    
    func signOut() {
        // sets user session to nil so we show login view
        userSession = nil

        // signs user out on server
        try? Auth.auth().signOut()
    }
    
    func resetPassword(withEmail email: String) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                print("DEBUG: Failed to send reset link \(error.localizedDescription)")
                return
            }
        }
    }
    
    func fetchUser() {
        guard let uid = self.userSession?.uid else { return }
        
        service.fetchUser(withUid: uid) { user in
            self.currentUser = user
        }
    }

    
    
}
