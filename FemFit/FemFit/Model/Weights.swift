//
//  Weights.swift
//  FemFit
//
//  Created by Leila on 5/12/21.
//  Copyright © 2021 User. All rights reserved.
//

import Foundation
import CoreData

public class Weight: NSObject, Codable, NSCoding {
    var date: String = ""
    var kg: Int = 0
    
    enum Key:String {
        case date = "date"
        case kg = "kg"
    }
    
    init(date: String, kg:  Int) {
        self.date = date
        self.kg = kg
    }
    
    public override init() {
        super.init()
    }
    
    public func encode(with aCoder: NSCoder) {
        
        aCoder.encode(date, forKey: Key.date.rawValue)
        aCoder.encode(kg, forKey: Key.kg.rawValue)
    }
    
    public required convenience init?(coder aDecoder: NSCoder) {
        
        let mKg = aDecoder.decodeInt32(forKey: Key.kg.rawValue)
        let mDate = aDecoder.decodeObject(forKey: Key.date.rawValue) as! String
        
        self.init(date:
            mDate, kg: Int(mKg))
    }

}
