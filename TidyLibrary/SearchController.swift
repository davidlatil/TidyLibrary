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
    
    var item :[Any] = []
    var context : NSManagedObjectContext!
    var locations  = [Album]()
    override func viewDidLoad(){
        super.viewDidLoad()
        //persistant container
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let fetchRequest =  NSFetchRequest<NSFetchRequestResult>(entityName: "Album")
        fetchRequest.returnsObjectsAsFaults = false
        locations = try! context.fetch(fetchRequest) as! [Album]
        for location in locations
        {
            item.append(location)
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return item.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Titre - Artiste - Genre"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)
        
        cell.textLabel?.text = (item[indexPath.row] as AnyObject).name + " - " + (item[indexPath.row] as AnyObject).artist! + " - " + (item[indexPath.row] as AnyObject).genre!
        
        
        return cell
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      if editingStyle == .delete {
        print("Deleted")

        
        
        let fetchRequest =  NSFetchRequest<NSFetchRequestResult>(entityName: "Album")
        fetchRequest.returnsObjectsAsFaults = false
        locations = try! context.fetch(fetchRequest) as! [Album]
        for location in locations
        {
            if location.code==(item[indexPath.row] as AnyObject).code {
                context.delete(location)
            }
        }
        do {
            try context.save()
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        self.item.remove(at: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: .automatic)
      }
    }
}


