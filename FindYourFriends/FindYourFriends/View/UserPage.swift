//
//  UserPage.swift
//  FindYourFriends
//
//  Created by Giuseppe Diciolla on 30/09/2020.
//

import Foundation
import UIKit

class UserPage: UIViewController{
    
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var userStreet: UILabel!
    @IBOutlet weak var userPhone: UILabel!
    @IBOutlet weak var editButton: UIButton!
    
    var mydata: Friend = Friend(id: 0,
                                name: "Giuseppe Diciolla",
                                lat: "-1",
                                lng: "-1")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            // Always adopt a light interface style.
            overrideUserInterfaceStyle = .light
        }
        
        // my data
        //TODO: Create a shared pref variable that shares the user infos
        mydata.name = "Giuseppe Diciolla"
        mydata.street = "Via molisana 30F 50593 Montecatini"
        mydata.phone = "+39 334 8839405"
        
        username.text = mydata.name
        userStreet.text = mydata.street
        userPhone.text = mydata.phone
        
        editButton.layer.cornerRadius = 20
    }
}
