//
//  SearchController.swift
//  TidyLibrary
//
//  Created by David Latil on 30/10/2019.
//  Copyright © 2019 David Latil. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class SearchController: UITableViewController {
    
    var albumList = [Album]()
    var fetchResults = [Album]()
    
    var context : NSManagedObjectContext!
    var fetchRequest : NSFetchRequest<NSFetchRequestResult>!
    
    var dataManager : DataManager!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        dataManager=DataManager()
        albumList=dataManager.getAllAlbums()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumList.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Titre - Artiste - Genre"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)
        let nameToDisplay = albumList[indexPath.row].name
        let artistToDisplay = albumList[indexPath.row].artist
        let genreToDisplay = albumList[indexPath.row].genre
        cell.textLabel?.text = nameToDisplay! + " - " + artistToDisplay! + " - " + genreToDisplay!
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      if editingStyle == .delete {
        dataManager.deleteAlbumFromCode(targetCode : albumList[indexPath.row].code!)
        self.albumList.remove(at: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: .automatic)
      }
    }
}


