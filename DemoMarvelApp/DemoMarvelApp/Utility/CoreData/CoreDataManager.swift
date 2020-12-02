//
//  CoreDataManager.swift
//  DemoMarvelApp
//
//  Created by Rahul Ranjan Kashyap on 03/12/20.
//  Copyright © 2020 Rahul Ranjan Kashyap. All rights reserved.
//

import Foundation
import CoreData
import UIKit


class CoreDataManager: NSObject {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    ///add data from database

    class func addRecord(object:ListModel) {
        
        let appDele = UIApplication.shared.delegate as! AppDelegate
        let context = appDele.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "MyList", in: context)
        let objManageContext = NSManagedObject(entity: entity!, insertInto: context)
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"MyList")
        fetchRequest.predicate = NSPredicate(format: "imageid = %d", (object.imageid)!)
        do
        {
            let fetchedResults = try context.fetch(fetchRequest)
            if(fetchedResults.count == 0)
            {
                objManageContext.setValue(object.imageid, forKey: "imageid")
                let data = UIImage(named:object.imageName!)!.pngData()!
                objManageContext.setValue(data, forKey: "imageName")
                objManageContext.setValue(object.desc, forKey: "desc")
                objManageContext.setValue(object.title, forKey: "title")
                do {
                    try context.save()
                    
                } catch let error as NSError {
                    print("Could not save. \(error), \(error.userInfo)")
                }
            }
            else
            {
                
                print("Already Added")
            }
        }
        catch
        {
            print("Something went wrong")
            
        }
    }
    
    ///delete data from database

    class func deleteItems(imageID:Int) {
        
        let appDele = UIApplication.shared.delegate as! AppDelegate
        let context = appDele.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "MyList", in: context)
        let objManageContext = NSManagedObject(entity: entity!, insertInto: context)
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"MyList")
        fetchRequest.predicate = NSPredicate(format: "imageid = %d", (imageID))
        do
        {
            let fetchedResults =  try context.fetch(fetchRequest) as? [NSManagedObject]
            if(fetchedResults!.count > 0)
            {
                for entity in fetchedResults! {
                    
                    
                    context.delete(entity)
                    do
                    {
                        try context.save()
                        
                    }
                    catch let error as Error?
                    {
                        print(error!.localizedDescription)
                    }
                }
            }            
        }
        catch _ {
            print("Could not delete")
        }
    }
    
    
    ///fetch image ids from database
    class func fetchItemsData(completion: (_ result: [Int]) -> Void){
        
        var arrayData = [Int]()
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MyList")
        var imageId: Int?
        
        do {
            let fetchedResults = try context.fetch(fetchRequest)
            
            print(fetchedResults.count)
            for record in fetchedResults {
                
                if let imageid = (record as AnyObject).value(forKey: "imageid") as? Int
                {
                    imageId = imageid
                    
                }
                if(imageId! > 0)
                {
                    arrayData.append(imageId!)
                }
            }
            
            print(arrayData)
            completion(arrayData)
            
            
        }catch let err as NSError {
            print(err.debugDescription)
        }
        
        
    }
    
}
