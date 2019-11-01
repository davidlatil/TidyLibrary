//
//  AddConfirmationController.swift
//  TidyLibrary
//
//  Created by David Latil on 29/10/2019.
//  Copyright © 2019 David Latil. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class AddConfirmationController:UIViewController {
    var code: String!
    var name: String!
    var artist: String!
    var genre: String!
    
    @IBOutlet weak var confirmation: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !DataManager().addAlbum(code: code, name: name, artist: artist, genre: genre){
            confirmation.text="Album déjà ajouté !"
        }
        
    }
    
}
