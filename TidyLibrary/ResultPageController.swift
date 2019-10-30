//
//  ResultPage.swift
//  TidyLibrary
//
//  Created by David Latil on 29/10/2019.
//  Copyright © 2019 David Latil. All rights reserved.
//

import Foundation
import UIKit
import CoreData
class ResultPageController:UIViewController {
    var searchedCode:String = ""
    var item :[Any] = []
    var found:Bool!
    
    @IBOutlet weak var foundLabel: UILabel!
    @IBOutlet weak var success: UIImageView!
    @IBOutlet weak var resultImage: UIImageView!
    @IBOutlet weak var album: UILabel!
    @IBOutlet weak var artist: UILabel!
    @IBOutlet weak var genre: UILabel!
    override func viewDidLoad() {
        found=false
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        var locations  = [Album]()
        let fetchRequest =  NSFetchRequest<NSFetchRequestResult>(entityName: "Album")
        fetchRequest.returnsObjectsAsFaults = false
        locations = try! context.fetch(fetchRequest) as! [Album]
        for location in locations
        {
            item.append(location)
            if location.code==searchedCode{
                found=true
                resultImage.isHidden=true
                artist.text=location.artist
                album.text=location.name
                genre.text=location.genre
            }
        }
        
        if !found {
            foundLabel.text="Album introuvable"
            album.text="Vous pouvez l'ajouter"
            artist.text="via le menu principal"
            genre.text=""
            success.isHidden=true
        }
    }
}
