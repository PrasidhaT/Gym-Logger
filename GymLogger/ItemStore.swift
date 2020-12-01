//
//  ItemStore.swift
//  GymLogger
//
//  Created by Prasidha Timsina on 10/28/20.
//

import UIKit
class ItemStore {
    var allItems = [Item]()
    
    let itemArchiveURL: URL = {
     let documentsDirectories =
    FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
     let documentDirectory = documentsDirectories.first!
     return documentDirectory.appendingPathComponent("items.archive")
    }()
    
    
    @discardableResult func createItem() -> Item {
        let newItem = Item(random: true)
        allItems.append(newItem)
        return newItem
    }
    
    func removeItem(_ item: Item) {
        if let index = allItems.firstIndex(of: item) {
            allItems.remove(at: index)
        }
    }
    
    func moveItem(from fromIndex: Int, to toIndex: Int) {
         if fromIndex == toIndex {
            return
         }
         // Get reference to object being moved so you can reinsert it
         let movedItem = allItems[fromIndex]
         // Remove item from array
         allItems.remove(at: fromIndex)
         // Insert item in array at new location
         allItems.insert(movedItem, at: toIndex)
    }
    
    
//    init() {
//    for _ in 0..<5 {
//            createItem()
//            print("ASDF!")
//        }
//    }
    
    func saveChanges() -> Bool {
     print("Saving log to: \(itemArchiveURL.path)")
     return NSKeyedArchiver.archiveRootObject(allItems, toFile: itemArchiveURL.path)
    }
    
    init() {
        if let archivedItems = NSKeyedUnarchiver.unarchiveObject(withFile: itemArchiveURL.path) as? [Item] {
            allItems = archivedItems
        }
    }
    
    
}
