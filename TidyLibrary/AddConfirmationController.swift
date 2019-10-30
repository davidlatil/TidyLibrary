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
    var albumE: String!
    var artist: String!
    var genre: String!
    var continueAdd: Bool!
    
    @IBOutlet weak var confirmation: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        continueAdd=true
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        var locations  = [Album]()
        let fetchRequest =  NSFetchRequest<NSFetchRequestResult>(entityName: "Album")
        fetchRequest.returnsObjectsAsFaults = false
        locations = try! managedContext.fetch(fetchRequest) as! [Album]
        for location in locations
        {
            if location.code==self.code{
                confirmation.text="Album déjà ajouté !"
                continueAdd=false
            }
        }
        
        if continueAdd {
            let albumEntity = NSEntityDescription.entity(forEntityName: "Album", in: managedContext)!
            
            let album = NSManagedObject(entity: albumEntity, insertInto: managedContext)
            album.setValue(code, forKeyPath: "code")
            album.setValue(albumE, forKeyPath: "name")
            album.setValue(artist, forKeyPath: "artist")
            album.setValue(genre, forKeyPath: "genre")
                    
            do {
                try managedContext.save()
                
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
            print("Addition successful")
        }
        
    }
    
}
