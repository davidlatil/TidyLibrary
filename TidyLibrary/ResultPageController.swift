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
    var albumList :[Album] = []
    var found:Bool!
    
    @IBOutlet weak var foundLabel: UILabel!
    @IBOutlet weak var success: UIImageView!
    @IBOutlet weak var resultImage: UIImageView!
    @IBOutlet weak var albumLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    
    
    override func viewDidLoad() {
        var returnedAlbum : Album
        (found, returnedAlbum) = DataManager().searchAlbum(code : searchedCode)
        
        if !found {
            foundLabel.text="Album introuvable"
            albumLabel.text="Vous pouvez l'ajouter"
            artistLabel.text="via le menu principal"
            genreLabel.text=""
            success.isHidden=true
        } else {
            resultImage.isHidden=true
            artistLabel.text=returnedAlbum.artist
            albumLabel.text=returnedAlbum.name
            genreLabel.text=returnedAlbum.genre
        }
    }
}
