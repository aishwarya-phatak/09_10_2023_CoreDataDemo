//
//  ViewController.swift
//  09_10_2023_CoreDataDemo
//
//  Created by Vishal Jagtap on 12/01/24.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //insertPersonData()
        retrivePersonRecords()
        deletePersonRecord()
        retrivePersonRecords()
    }
    
    func insertPersonData(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let personEntityDescription = NSEntityDescription.entity(
            forEntityName: "Person",
            in: managedContext)
        
        for i in 1...3{
            let person = NSManagedObject(
                entity: personEntityDescription!,
                insertInto: managedContext)
            person.setValue("Person\(i)", forKey: "name")
            person.setValue("Person\(i)@gmail.com", forKey: "email")
        }
        
        do{
           try managedContext.save()
        }catch{
            print(error)
        }
    }
    
    func retrivePersonRecords(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "Person")
        do{
            let fetchResults = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
            
            for eachFetchResult in fetchResults{
                print(eachFetchResult.value(forKey: "name") as! String)
                print(eachFetchResult.value(forKey: "email") as! String)
            }
        }catch{
           print(error)
        }
    }
    
    func deletePersonRecord(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "Person")
        
        fetchRequest.predicate = NSPredicate(
            format: "name = %@", "Person2")
        do{
            let fetchResults  = try managedContext.fetch(fetchRequest)
            print(fetchResults)
           let objectToBeDeleted = fetchResults[0] as! NSManagedObject
            managedContext.delete(objectToBeDeleted)
            do{
                try managedContext.save()
            } catch {
                print(error)
            }
        } catch {
            print(error)
        }
    }
}
