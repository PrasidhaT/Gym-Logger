//
//  ItemsViewController.swift
//  GymLogger
//
//  Created by Prasidha Timsina on 10/28/20.
//

import UIKit

class ItemsViewController: UITableViewController {
    
    var itemStore: ItemStore!
    
    @IBAction func addNewItem(_ sender: UIBarButtonItem) {
        // Make a new index path for the 0th section, last row
//        let lastRow = tableView.numberOfRows(inSection: 0)
//        let indexPath = IndexPath(row: lastRow, section: 0)
//        // Insert this new row into the table
//        tableView.insertRows(at: [indexPath], with: .automatic)
        // Create a new item and add it to the store
        let newItem = itemStore.createItem()
        // Figure out where that item is in the array
        if let index = itemStore.allItems.firstIndex(of: newItem) {
           let indexPath = IndexPath(row: index, section: 0)
           // Insert this new row into the table
           tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
    
    @IBAction func loadCSV(_ sender: UIBarButtonItem) {

        for exercise in CSVstring{
            let exerciseArray = exercise.components(separatedBy: ",")
            print(exerciseArray)
            let newItem = Item.init(name: exerciseArray[0], liftingDay: exerciseArray[1], weight: Int(exerciseArray[2]) ?? 130)
            itemStore.allItems.append(newItem)
            if let index = itemStore.allItems.firstIndex(of: newItem) {
               let indexPath = IndexPath(row: index, section: 0)
               // Insert this new row into the table
               tableView.insertRows(at: [indexPath], with: .automatic)
            }
        }

    }
    
    
    var CSVstring = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://raw.githubusercontent.com/PrasidhaT/Gym-Logger/main/csvToLoadData.csv")!

        let task = URLSession.shared.downloadTask(with: url) { localURL, urlResponse, error in
            if let localURL = localURL {
                if let string = try? String(contentsOf: localURL) {
                    let array = string.components(separatedBy: "\n")
                    let exercise1 = (array[0]).dropLast(1)
                    let exercise2 = (array[1]).dropLast(1)
                    let exercise3 = (array[2]).dropLast(1)
                    let exercise4 = (array[3]).dropLast(1)
                    let exercise5 = (array[4]).dropLast(1)
                    let exercise6 = (array[5]).dropLast(1)
                    self.CSVstring.append(String(exercise1))
                    self.CSVstring.append(String(exercise2))
                    self.CSVstring.append(String(exercise3))
                    self.CSVstring.append(String(exercise4))
                    self.CSVstring.append(String(exercise5))
                    self.CSVstring.append(String(exercise6))

                }
            }
        }

        task.resume()
        
        tableView.rowHeight = 65
        tableView.estimatedRowHeight = 65
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // If the triggered segue is the "showItem" segue
        switch segue.identifier {
        case "showItem"?:
            // Figure out which row was just tapped
            if let row = tableView.indexPathForSelectedRow?.row {
                // Get the item associated with this row and pass it along
                let item = itemStore.allItems[row]
                let detailViewController
                    = segue.destination as! DetailViewController
                detailViewController.item = item
            }
        default:
            preconditionFailure("Unexpected segue identifier.")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemStore.allItems.count
    }
    
    override func tableView(_ tableView: UITableView,
        cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            // Creating an instance of UITableViewCell
//            let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
            let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell",
            for: indexPath) as! ItemCell
            // Set the text on the cell with the description of the item
            // that is at the nth index of items, where n = row this cell
            // will appear in on the tableview
            let item = itemStore.allItems[indexPath.row]
            
//            cell.textLabel?.text = item.name
//            cell.detailTextLabel?.text = "$\(item.weight)"
            // Configure the cell with the Item
            cell.nameLabel.text = item.name
            cell.exerciseGroupLabel.text = item.liftingDay
            cell.currentWeightLabel.text = "\(item.weight) Lbs"
            
            return cell
    }
    
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                let item = itemStore.allItems[indexPath.row]
                
                
                let title = "Delete \(item.name)?"
                let message = "Are you sure you want to delete this exercise?"
                
                let ac = UIAlertController(title: title,
                    message: message,
                    preferredStyle: .actionSheet)
                
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                ac.addAction(cancelAction)
                
                let deleteAction = UIAlertAction(title: "Delete", style: .destructive,
                    handler: { (action) -> Void in
                        // Remove the item from the store
                        self.itemStore.removeItem(item)
                        
                        // Also remove that row from the table view with an animation
                        self.tableView.deleteRows(at: [indexPath], with: .automatic)
                })
                ac.addAction(deleteAction)
                
                // Present the alert controller
                present(ac, animated: true, completion: nil)
            }
    }
    
    override func tableView(_ tableView: UITableView,
    moveRowAt sourceIndexPath: IndexPath,
    to destinationIndexPath: IndexPath) {
         // Update model
         itemStore.moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }

}
