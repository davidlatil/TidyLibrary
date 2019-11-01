//
//  DataManager.swift
//  TidyLibrary
//
//  Created by David Latil on 01/11/2019.
//  Copyright © 2019 David Latil. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class DataManager {
    
    var albumList = [Album]()
    var fetchResults = [Album]()
    
    var context : NSManagedObjectContext!
    var fetchRequest : NSFetchRequest<NSFetchRequestResult>!
    
    init() {
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Album")
        fetchRequest.returnsObjectsAsFaults = false
        fetchResults = try! context.fetch(fetchRequest) as! [Album]
    }
    
    func getAllAlbums() -> [Album] {
        for result in fetchResults
        {
            albumList.append(result)
        }
        return albumList
    }
    
    func deleteAlbumFromCode(targetCode: String){
        for result in fetchResults
        {
            if result.code == targetCode {
                context.delete(result)
            }
        }
        
        do {
            try context.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        fetchResults = try! context.fetch(fetchRequest) as! [Album]
    }
    
    func addAlbum(code : String, name : String, artist : String, genre : String) -> Bool {
        for result in fetchResults
        {
            if result.code == code {
                return false
            }
        }
        
        let albumEntity = NSEntityDescription.entity(forEntityName: "Album", in: context)!
        
        let newAlbum = NSManagedObject(entity: albumEntity, insertInto: context)
        newAlbum.setValue(code, forKeyPath: "code")
        newAlbum.setValue(name, forKeyPath: "name")
        newAlbum.setValue(artist, forKeyPath: "artist")
        newAlbum.setValue(genre, forKeyPath: "genre")
        
        do {
            try context.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        fetchResults = try! context.fetch(fetchRequest) as! [Album]
        
        return true
    }
    
    func searchAlbum(code : String) -> (Bool, Album) {
        for album in getAllAlbums(){
            if album.code == code {
                return (true, album)
            }
        }
        let albumEntity = NSEntityDescription.entity(forEntityName: "Album", in: context)!
        return (false, Album.init(entity: albumEntity, insertInto: context))
    }
}
