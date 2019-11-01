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
@available(iOS 13.0, *)
class ResultPageController:UIViewController {
    var searchedCode:String = ""
    var albumList :[Album] = []
    var found:Bool!
    
    @IBOutlet weak var foundLabel: UILabel!
    @IBOutlet weak var success: UIImageView!
    @IBOutlet weak var resultImage: UIImageView!
    @IBOutlet weak var album: UILabel!
    @IBOutlet weak var artist: UILabel!
    @IBOutlet weak var genre: UILabel!
    
    override func viewDidLoad() {
        var returnedAlbum : Album
        (found, returnedAlbum) = DataManager().searchAlbum(code : searchedCode)
        
        if !found {
            foundLabel.text="Album introuvable"
            album.text="Vous pouvez l'ajouter"
            artist.text="via le menu principal"
            genre.text=""
            success.isHidden=true
        } else {
            resultImage.isHidden=true
            artist.text=returnedAlbum.artist
            album.text=returnedAlbum.name
            genre.text=returnedAlbum.genre
        }
    }
}
