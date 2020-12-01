//
//  Item.swift
//  GymLogger
//
//  Created by Prasidha Timsina on 10/28/20.
//

import UIKit
class Item: NSObject, NSCoding {
    
    var name: String
    var weight: Int
    var liftingDay: String?
    let dateCreated: Date
    
    init(name: String, liftingDay: String?, weight: Int) {
        self.name = name
        self.liftingDay = liftingDay
        self.weight = weight
        self.dateCreated = Date()
        
        super.init()
    }
    
    convenience init(random: Bool = false) {
        if random {
            let adjectives = ["Bodyweight", "Weighted", "PR"]
            let nouns = ["Squats", "Bench Press", "Deadlifts"]
            let bodyParts = ["Chest", "Arms", "Biceps", "Triceps", "Back", "Shoulders", "Legs (Never skip leg day)"]
            
            var idx = arc4random_uniform(UInt32(adjectives.count))
            let randomAdjective = adjectives[Int(idx)]
            
            idx = arc4random_uniform(UInt32(nouns.count))
            let randomNoun = nouns[Int(idx)]
            let randomBodyPart = bodyParts[Int(idx)]
            let randomName = "\(randomAdjective) \(randomNoun)"
            let randomWeight = Int(arc4random_uniform(100))
            
            self.init(name: randomName,
                liftingDay: randomBodyPart,
                weight: randomWeight)
        } else {
            self.init(name: "", liftingDay: nil, weight: 0)
        }
    }
    
    func encode(with aCoder: NSCoder) {
     aCoder.encode(name, forKey: "name")
     aCoder.encode(dateCreated, forKey: "dateCreated")
     aCoder.encode(liftingDay, forKey: "liftingDay")
     aCoder.encode(weight, forKey: "weight")
    }
    
    required init(coder aDecoder: NSCoder) {
     name = aDecoder.decodeObject(forKey: "name") as! String
     dateCreated = aDecoder.decodeObject(forKey: "dateCreated") as! Date
     liftingDay = aDecoder.decodeObject(forKey: "liftingDay") as! String?
     weight = aDecoder.decodeInteger(forKey: "weight")
     super.init()
    }
    
}
