//
//  ItemStore.swift
//  GymLogger
//
//  Created by Prasidha Timsina on 10/28/20.
//

import UIKit
class ItemStore {
    var allItems = [Item]()
    
    
    @discardableResult func createItem() -> Item {
        let newItem = Item(random: true)
        allItems.append(newItem)
        return newItem
    }
    
    
//    init() {
//    for _ in 0..<5 {
//            createItem()
//            print("ASDF!")
//        }
//    }
    
    
}
