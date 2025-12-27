//
//  Recipe.swift
//  Recipedia
//
//  Created by Pablo García López on 6/12/25.
//

import Foundation
import SwiftUI

enum Cost: String, Codable, CaseIterable, Hashable {
    case cheap = "Cheap", medium = "Medium", pricy = "Pricy"
    
    var symbol: String {
        switch self {
            case .cheap: return "$"
            case .medium: return "$$"
            case .pricy: return "$$$"
        }
    }
    
    var description: String {
        rawValue
    }
}

enum Difficulty: String, Codable, CaseIterable, Hashable {
    case easy = "Easy", medium = "Medium", hard = "Hard"
    
    var color: Color {
        switch self {
            case .easy: return .green
            case .medium: return .orange
            case .hard: return .red
        }
    }
    
    var description: String {
        rawValue
    }
}

struct Recipe: Codable {
    private(set) var recipeId: UUID
    var name: String
    var description: String
    var cost: Cost
    var time: Int // minutes
    var difficulty: Difficulty?
    var numPeople: Int
    var ingredients: [Ingredient]
    var steps: [Step]
    var imageId: String?
    
    init(
        recipeId: UUID = UUID(),
        name: String = "",
        description: String = "",
        cost: Cost = .cheap,
        time: Int = 25,
        difficulty: Difficulty? = nil,
        numPeople: Int = 4,
        steps: [Step] = [],
        ingredients: [Ingredient] = [],
        imageId: String? = nil
    ) {
        self.recipeId = recipeId
        self.name = name
        self.description = description
        self.time = time
        self.cost = cost
        self.difficulty = difficulty
        self.numPeople = numPeople
        self.steps = steps
        self.ingredients = ingredients
        
        // ImageId is by default the image from the recipe
        if imageId == nil { self.imageId = "\(self.recipeId)" }
        else { self.imageId = imageId }
    }
}
