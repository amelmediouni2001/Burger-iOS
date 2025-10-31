//
//  ViewController.swift
//  burger-revision
//
//  Created by Apple Esprit on 30/10/2025.
//sandwitch = order

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate {
    
    //Data
    var ingredients = ["Argula", "Bacon", "Cheddar","Cucumber", "Egg", "Gruyere","Ham", "Lettuce", "Mashroom", "Ognion", "Tomato" ]
    var prices = [2.8, 2.2, 0.4, 0.3, 1.0, 1.2, 1.5, 0.4, 0.5, 0.50, 3.0]
    var sandwitch = ["Top", "Bottom" ]
    var price = 2.0
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var FinalPriceLabel: UILabel!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sandwitch.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tvCell")
        let imageView = cell?.viewWithTag(1) as! UIImageView
        imageView.image = UIImage(named: sandwitch[indexPath.row])
        
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: "cvCell", for: indexPath)
        let imageView = item.viewWithTag(1) as! UIImageView
        let label = item.viewWithTag(2) as! UILabel
        
        imageView.image =   UIImage(named: ingredients[indexPath.row])
        label.text = "$\(prices[indexPath.row])"
        return item
    }
    
    //PROCESSUS D'AJOUT DINGREDIENT AU SANDWITCH
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        sandwitch.insert(ingredients[indexPath.row], at: 1)
        //reload ll table view fi affichage kol matzidou haja
        tableView.reloadData()
        //price yethaz w yetzed + maah fi total
        price += prices[indexPath.row]
        FinalPriceLabel.text = "$\(price)"
    }
    
    
    
   
    //DELETE FUNCTION
    //Activation swipe left
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let index = ingredients.firstIndex(of: sandwitch[indexPath.row])!
            //price yethaz w yon9os maah fi total
            price -= prices[index]
            FinalPriceLabel.text = "$\(price)"
            
            sandwitch.remove(at: indexPath.row)
            //reload ll table view fi affichage kol matfassakh haja
            tableView.reloadData()
        }
    }

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        tableView.dataSource = self
        collectionView.dataSource = self
        FinalPriceLabel.text = "$\(price)"
        

        
        
        // Do any additional setup after loading the view.
    }
    

    //METHODE AJOUT FI CORE DATA
    func insertCoreData() {
        
        // Les 3 méthodes classiques Core Data
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let persistentContainer = appDelegate.persistentContainer
        let managedContext = persistentContainer.viewContext
        
        // ✅ guard let - si l'entity existe, on continue
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "Order", in: managedContext) else {
            print("❌ Error: Could not find entity description for Order")
            return  // ⚠️ On sort de la fonction si pas trouvé
        }
        
        // ✅ Ici entityDescription existe, on peut l'utiliser
        let managedObject = NSManagedObject(entity: entityDescription, insertInto: managedContext)
        managedObject.setValue(price, forKey: "price")
        
        do {
            try managedContext.save()
            print("✅ Burger saved successfully! Price: $\(price)")
            
                       
            //ALERT DE CONFIRMATION
            let alert = UIAlertController(title: "Success", message: "Order Success", preferredStyle: .alert)

            let action = UIAlertAction(title: "OK", style: .default)
            alert.addAction(action)
            self.present(alert, animated: true)
            
            
            
          
            
            
        } catch {
            print("❌ Error inserting Burger: \(error)")
        }
    }
            
            
    @IBAction func purchaseBurger(_ sender: Any) {
        insertCoreData()
    }
        
    
}
    

