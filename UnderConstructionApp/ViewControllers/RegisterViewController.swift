//
//  RegisterViewController.swift
//  UnderConstructionApp
//
//  Created by Amparo Iglesias on 6/9/19.
//  Copyright © 2019 Amparo Iglesias. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class RegisterViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var registerBackView: UIView!
    
    @IBOutlet weak var registerButton: UIButton!
    var db: Firestore!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.HideKeyboard()
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillLayoutSubviews() {
        registerBackView.backgroundColor = .white
        registerBackView.dropShadow(color: .gray, opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
        registerButton.layer.cornerRadius = 15
        registerButton.clipsToBounds = true
        emailTextField.layer.cornerRadius = 15
        emailTextField.clipsToBounds = true
        passwordTextField.layer.cornerRadius = 15
        passwordTextField.clipsToBounds = true
        userNameTextField.layer.cornerRadius = 15
        userNameTextField.clipsToBounds = true
        
    }
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//        if segue.identifier == "RegisterToHomeSegue"{
//            let homeViewController = (segue.destination as! HomeViewController)
//
//        }
//    }
    

    @IBAction func registerButtonAction(_ sender: Any) {
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!){ (user, error) in
            if error == nil {
                let user = User()
                user.email = self.emailTextField.text!
                user.username = self.userNameTextField.text!
                if !(ModelManager.shared.users.contains(where: { $0.email == user.email })){
                    ModelManager.shared.users.append(user)
                }
                var ref: DocumentReference? = nil
                ref = self.db.collection("users").addDocument(data: [
                    "username": user.username,
                    "useremail": user.email,
                    "userRealName": user.name,
                    "userAddress" : user.address,
                    "userPhone" : user.phone
                ]) { err in
                    if let err = err {
                        print("Error adding document: \(err)")
                    } else {
                        print("Document added with ID: \(ref!.documentID)")
                    }
                }
                
                self.performSegue(withIdentifier: "RegisterToHomeSegue", sender: self)
            }
            else{
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)

                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
}

extension RegisterViewController {
    
    func HideKeyboard(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self , action: #selector(DismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func DismissKeyboard(){
        view.endEditing(true)
    }
    
    
}

