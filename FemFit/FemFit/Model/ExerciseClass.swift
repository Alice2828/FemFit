//
//  File.swift
//  FemFit
//
//  Created by User on 24.04.2021.
//  Copyright © 2021 User. All rights reserved.
//

import Foundation

struct Exercise: Codable{
    var id: Int?
    var uuid: String?
    var name: String?
    var status: String?
    var description: String?
    var creation_date : String?
    var category: Int?
    var muscles: [Int]?
    var muscles_secondary: [Int]?
    var equipment: [Int]?
    var language: Int?
    var license: Int?
    var license_author: String?
    var variations: [Int]?
//
//    init(json: [String: Any]){
//        self.id = json["id"] as? Int
//        self.uuid = json["uuid"] as? String
//        self.name = json["name"] as? String
//        self.status = json["status"] as? String
//        self.description = json["description"] as? String
//        self.creation_date = json["creation_date"] as? String
//        self.category = json["category"] as? Int
//        self.muscles = json["muscles"] as? [Int]
//        self.muscles_secondary = json["muscles_secondary"] as? [Int]
//        self.equipment = json["equipment"] as? [Int]
//        self.language = json["language"] as? Int
//        self.license = json["license"] as? Int
//        self.license_author = json["license_author"] as? String
//        self.variations = json["variations"] as? [Int]
//    }
}

struct ExerciseResponse:Codable{
    var count: Int?
    var next: String?
    var previous: Int?
    var results: [Exercise]?
}
