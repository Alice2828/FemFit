//
//  NoteRecord+CoreDataProperties.swift
//  
//
//  Created by Leila on 5/11/21.
//
//

import Foundation
import CoreData


extension NoteRecord {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<NoteRecord> {
        return NSFetchRequest<NoteRecord>(entityName: "NoteRecord")
    }
    
    @NSManaged public var date: String?
    @NSManaged public var cals: String?
    @NSManaged public var ingredients: Ingredients?
    @NSManaged public var weight: Double?
}
