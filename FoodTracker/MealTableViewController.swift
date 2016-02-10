//
//  MealTableViewController.swift
//  FoodTracker
//
//  Created by mrensel on 2/9/16.
//  Copyright © 2016 mti. All rights reserved.
//

import UIKit

class MealTableViewController: UITableViewController {
    
    //MARK: Properties
    
    var meals = [Meal]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadMeals()
        
    }
    
    //load our meal data
    func loadMeals() {
        
        //fetch meal data
        if let mealData = fetchMeals() {
            for item in mealData {
                let name = item["name"] as! String
                let rating = item["rating"] as! Int
                let photo = UIImage(named: item["photo"] as! String)
                
                meals.append(Meal(name: name, photo: photo, rating: rating)!)
                
            }
        }
    
    }
    
    //fetch meal data
    //currently fetches from json file, but could be altered to make an http request or pull from core data
    func fetchMeals() -> [[String: AnyObject]]?{
        
        if let path = NSBundle.mainBundle().pathForResource("meals", ofType: "json") {
            if let jsonData = NSData(contentsOfFile: path){
                var json: NSArray?
                do {
                    json = try NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions()) as? NSArray
                } catch {
                    print(error)
                }
            
                if let theseMeals = json as? [[String: AnyObject]] {
                    return theseMeals
                }
                
            
            }
        }
        
        return nil
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        //we're showing 1 section only - basic list
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return meals.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("mealTableCell", forIndexPath: indexPath) as! MealTableViewCell
        let meal = meals[indexPath.row]

        cell.nameLabel.text = meal.name
        cell.photoImageView.image = meal.photo
        cell.ratingControl.rating = meal.rating
        

        return cell
    }
    
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        
        if let sourceViewController = sender.sourceViewController as? MealViewController, meal = sourceViewController.meal {
            //add a new meal
            let newIndexPath = NSIndexPath(forRow: meals.count, inSection: 0)
            
            meals.append(meal)
            
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
        }
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
