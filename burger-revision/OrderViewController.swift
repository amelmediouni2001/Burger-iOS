//
//  OrderViewController.swift
//  burger-revision
//
//  Created by Apple Esprit on 31/10/2025.
//

import UIKit
import CoreData


class OrderViewController: UIViewController, UITableViewDataSource {
    
    //data
    var orders = [Double]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
            return orders.count
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderCell")
        let label = cell?.viewWithTag(1) as! UILabel
        
        label.text = "$\(orders[indexPath.row])"
        return cell!
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        getAll()

        // Do any additional setup after loading the view.
    }
    
    func getAll() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let persistentContainer = appDelegate.persistentContainer
        let managedContext = persistentContainer.viewContext
        
        let request = NSFetchRequest<NSManagedObject>(entityName: "Order")
        do {
            let result = try managedContext.fetch(request)
            
            for item in result {
                orders.append(item.value(forKey: "price") as! Double)
            }
        } catch {
            print("Fetching error: \(error)")
        }
        
    }
    


}
