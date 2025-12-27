//
//  Ingredient.swift
//  Recipedia
//
//  Created by Pablo García López on 6/12/25.
//

import Foundation

enum Unit: String, CaseIterable, Codable {
    
    // --- Mass (Weight) ---
    case grams = "g"
    case kilograms = "kg"
    case milligrams = "mg"
    case ounces = "oz"
    case pounds = "lb"

    // --- Volume (Liquid) ---
    case milliliters = "ml"
    case centiliters = "cl"
    case liters = "l"
    case cups = "cup(s)"
    case fluidOunces = "fl oz"
    case pints = "pt"
    case quarts = "qt"
    
    // --- Count (Discrete Items) ---
    case units = "unit(s)"
    case pieces = "piece(s)"
    
    // --- Cooking Measures ---
    case teaspoon = "tsp"
    case tablespoon = "tbsp"
    case pinch = "pinch"
    case dash = "dash"
    
    // --- General/Other ---
    case can = "can(s)"
    case bottle = "bottle(s)"
    case slice = "slice(s)"
}

class Ingredient: Codable {
    private(set) var ingredientId: UUID
    var name: String?
    var quantity: Double?
    var unit: Unit?
    
    init(ingredientId: UUID = UUID(), name: String? = nil, quantity: Double? = nil, unit: Unit? = nil) {
        self.ingredientId = ingredientId
        self.name = name
        self.quantity = quantity
        self.unit = unit
    }
}
