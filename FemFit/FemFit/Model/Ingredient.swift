
//  Meal.swift
//  FemFitDraft
//
//  Created by Leila on 4/26/21.
//  Copyright © 2021 Leila. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct Ingredient: Codable {
    let id: Int?
    let name: String?
    let creation_date: String?
    let update_date:String?
    let energy: Int?
    let protein: String?
    let carbohydrates: String?
    let carbohydrates_sugar: String?
    let fat: String?
    let fat_saturated: String?
    let fibres: String?
    let sodium: String?
    let license: Int?
    let license_author: String?
    let language: Int?
}

public class IngredientCore: NSObject, Codable, NSCoding {
    var id: Int = 0
    var name: String = ""
    var energy: Int = 0
    var gramms: Int = 0
    
    enum Key:String {
        case id = "id"
        case name = "name"
        case energy = "energy"
        case gramms = "gramms"
    }
    
    init(id: Int, name: String, energy: Int, gramms: Int) {
        self.id = id
        self.name = name
        self.energy = energy
        self.gramms = gramms
    }
    
    public override init() {
        super.init()
    }
    
    public func encode(with aCoder: NSCoder) {
        
        aCoder.encode(id, forKey: Key.id.rawValue)
        aCoder.encode(name, forKey: Key.name.rawValue)
        aCoder.encode(energy, forKey: Key.energy.rawValue)
        aCoder.encode(gramms, forKey: Key.gramms.rawValue)
    }
    
    public required convenience init?(coder aDecoder: NSCoder) {
        
        let mId = aDecoder.decodeInt32(forKey: Key.id.rawValue)
        let mName = aDecoder.decodeObject(forKey: Key.name.rawValue) as! String
        let mEnergy = aDecoder.decodeInt32(forKey: Key.energy.rawValue)
        let mGramms = aDecoder.decodeInt32(forKey: Key.gramms.rawValue)
        
        self.init(id: Int(mId), name:
            mName, energy:Int(mEnergy),gramms:Int(mGramms))
    }
}
public class Ingredients: NSObject, NSCoding{
    public var  ingredients:[IngredientCore] = []
    enum Key: String{
        case  ingredients   = "ingredients"
    }
    init(ingredients:[IngredientCore]){
        self.ingredients = ingredients
    }
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(ingredients, forKey: Key.ingredients.rawValue)
    }
    
    public required convenience init?(coder aDecoder: NSCoder) {
        let mIngredients = aDecoder.decodeObject(forKey: Key.ingredients.rawValue) as! [IngredientCore]
        
        self.init(ingredients: mIngredients)
    }
}
struct IngredientsResponse:Codable{
    var count: Int?
    var next: String?
    var previous: Int?
    var results: [Ingredient]?
}
struct Diary: Codable{
    let notes: [Note]?
}
class Note: Codable{
    var date: String?
    var totalCkal: String?
    var dict: [String: String]{
        return [
            "date": date!,
            "totalCkal": totalCkal!,
        ]
    }
    init(_ date: String, _ totalCkal:String){
        self.date = date
        self.totalCkal = totalCkal
    }
    init(snapshot: DataSnapshot){
        if let value = snapshot.value as? [String:String]{
            date = value["date"]
            totalCkal = value["totalCkal"]
        }
    }
}

