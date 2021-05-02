//
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
    var id: String?
    var date: String?
    var totalCkal: String?
    var dict: [String: String]{
        return [
            "id": id!,
            "date": date!,
            "totalCkal": totalCkal!,
        ]
    }
    init(_ id: String?,_ date: String,_ totalCkal:String){
        self.id = id
        self.date = date
        self.totalCkal = totalCkal
    }
    init(snapshot: DataSnapshot){
        if let value = snapshot.value as? [String:String]{
            id = value["id"]
            date = value["date"]
            totalCkal = value["totalCkal"]
        }
    }
}
