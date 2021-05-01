//
//  Meal.swift
//  FemFitDraft
//
//  Created by Leila on 4/26/21.
//  Copyright © 2021 Leila. All rights reserved.
//

import Foundation
struct Meal: Codable {
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
struct MealsResponse:Codable{
    var count: Int?
    var next: String?
    var previous: Int?
    var results: [Meal]?
}
struct NutritionPlan: Codable {
    let id: Int?
    let creation_date: String?
    let description: String?
    let get_nutritional_values: Bool?
    let meals: [MealsFull]?
}
struct MealsFull: Codable{
    let id:Int?
    let plan:Int?
    let order:Int?
    let time: String?
    let meal_items:[MealItems]?
}
struct MealItems: Codable{
    let id:Int?
    let meal:Int?
    let ingredient_obj: [IngredientObj]?
    let ingredient:Int?
    let amount:String?
}
struct IngredientObj:Codable{
    let id:Int?
    let name:String?
    let creation_date:String?
    let update_date:String?
    let energy:Int?
    let protein:String?
    let carbohydrates:String?
    let carbohydrates_sugar:String?
    let fat:String?
    let fat_saturated:String?
    let fibres:String?
    let sodium:String?
}
struct NutritionPlanResponse:Codable{
    var count: Int?
    var next: String?
    var previous: Int?
    var results: [NutritionPlan]
}
struct NutritionalValues:Codable{
    struct Total:Codable{
        let energy: Float?
        let protein:Float?
        let carbohydrates:Float?
        let carbohydrates_sugar:Float?
        let fat:Float?
        let fat_saturated:Float?
        let fibres:Float?
        let sodium:Float?
        let energy_kilojoule:Float?
    }
//    struct percent:Codable{
//        let protein:Float?
//        let carbohydrates:Float?
//        let fat:Float?
//    }
//    struct per_kg:Codable{
//        let protein:Float?
//        let carbohydrates:Float?
//        let fat:Float?
//    }
}
