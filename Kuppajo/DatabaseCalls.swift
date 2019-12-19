//
//  DatabaseCalls.swift
//  Kuppajo
//
//  Created by Luna on 2019-09-27.
//  Copyright © 2019 Sagar. All rights reserved.
//

import Foundation
import Firebase
import Promises

let db = Firestore.firestore()


// Add a new document in collection Users ~ For new user
func newUser(FirebaseUser user: User){
    db.collection("users").document(user.uid).setData([
        "name": user.displayName!,
        "email": user.email!,
        "basic_counter": 0,
        "premium_counter": 0
    ]) { err in
        if let err = err {
            print("Error writing document: \(err) - Signup")
        } else {
            print("Document successfully written! User Signed Up")
        }
    }
}

func promiseDocExists(DocumentRef docRef: DocumentReference) -> Promise<Bool> {
    return Promise<Bool>(on: .global(qos: .background)) { (fullfill, reject) in
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                fullfill(true)
            }else{
                fullfill(false)
            }
        }
    }
}
