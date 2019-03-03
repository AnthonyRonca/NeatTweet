//
//  LoginViewController.swift
//  Twitter
//
//  Created by Anthony Ronca on 2/19/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view
        

    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if ( UserDefaults.standard.bool(forKey: "userLoggedIn") == true ){
            
            self.performSegue(withIdentifier: "LoginSegeue", sender: self)
        }
        
    }
    
    
    
    //  Login Button Action Connection
    @IBAction func LoginButton(_ sender: Any) {
        
        // Counts amount of logins
    
        //  Login URL
        let MyURL = "https://api.twitter.com/oauth/request_token"
        
        //  Code Runs if Login is successful
        TwitterAPICaller.client?.login(url: MyURL, success: {
            
            print("Welcome!")
            
            UserDefaults.standard.set(true, forKey: "userLoggedIn")
            
            self.performSegue(withIdentifier: "LoginSegeue", sender: self)

            //  Code Runs if Login fails
        }, failure: { (Error) in
            
            print("Please try again - Username/Password not recognized")
            
        })
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
