//
//  Ingredient.swift
//  Recipedia
//
//  Created by Pablo García López on 6/12/25.
//

import Foundation

enum IngredientUnit: String, CaseIterable, Codable, Identifiable {
    
    var id: String { rawValue }
    
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
    
    case unknown = "Unknown"
    
    var displayName: String { rawValue }
    
    static var orderedForUI: [Self] {
        let others = allCases
            .filter { $0 != .unknown }
            .sorted { $0.displayName < $1.displayName }
        return [.unknown] + others
    }
}

enum IngredientName: String, CaseIterable, Codable, Identifiable {
    var id: String { rawValue }
    
    // Liquids & Oils
    case water = "Water"
    case oliveOil = "Olive oil"
    case vegetableOil = "Vegetable oil"
    case coconutMilk = "Coconut milk"
    case vinegar = "Vinegar"
    case soySauce = "Soy sauce"
    case broth = "Broth"
    case stock = "Stock"
    case lemonJuice = "Lemon juice"
    case orangeJuice = "Orange juice"
    
    // Dairy & Eggs
    case milk = "Milk"
    case cream = "Cream"
    case yogurt = "Yogurt"
    case butter = "Butter"
    case cheese = "Cheese"
    case eggs = "Eggs"
    
    // Baking & Sweeteners
    case flour = "Flour"
    case wholeWheatFlour = "Flour (whole wheat)"
    case sugar = "Sugar"
    case cocoaPowder = "Cocoa powder"
    case vanillaExtract = "Vanilla extract"
    case bakingPowder = "Baking powder"
    case bakingSoda = "Baking soda"
    case honey = "Honey"
    
    // Produce - Vegetables
    case onion = "Onion"
    case garlic = "Garlic"
    case tomato = "Tomato"
    case potato = "Potato"
    case carrot = "Carrot"
    case bellPepper = "Bell pepper"
    case celery = "Celery"
    case mushrooms = "Mushrooms"
    case spinach = "Spinach"
    case zucchini = "Zucchini"
    case broccoli = "Broccoli"
    case corn = "Corn"
    case peas = "Peas"
    case ginger = "Ginger"
    case chiliPepper = "Chili pepper"
    
    // Produce - Fruits
    case lemon = "Lemon"
    case orange = "Orange"
    case apple = "Apple"
    case banana = "Banana"
    case lime = "Lime"
    case pineapple = "Pineapple"
    case mango = "Mango"
    case strawberry = "Strawberry"
    case blueberry = "Blueberry"
    
    // Grains, Pasta & Legumes
    case rice = "Rice"
    case pasta = "Pasta"
    case lentils = "Lentils"
    case beans = "Beans"
    case quinoa = "Quinoa"
    case couscous = "Couscous"
    case oats = "Oats"
    case barley = "Barley"
    
    // Meats & Seafood
    case chicken = "Chicken"
    case beef = "Beef"
    case pork = "Pork"
    case fish = "Fish"
    case shrimp = "Shrimp"
    case turkey = "Turkey"
    case lamb = "Lamb"
    case tuna = "Tuna"
    case salmon = "Salmon"
    
    // Herbs & Spices
    case salt = "Salt"
    case blackPepper = "Black pepper"
    case paprika = "Paprika"
    case cinnamon = "Cinnamon"
    case basil = "Basil"
    case parsley = "Parsley"
    case thyme = "Thyme"
    case oregano = "Oregano"
    case cumin = "Cumin"
    case chiliPowder = "Chili powder"
    case nutmeg = "Nutmeg"
    case coriander = "Coriander"
    case turmeric = "Turmeric"
    case rosemary = "Rosemary"
    
    // Condiments & Sauces
    case mustard = "Mustard"
    case mayonnaise = "Mayonnaise"
    case ketchup = "Ketchup"
    case hotSauce = "Hot sauce"
    case bbqSauce = "BBQ sauce"
    case tahini = "Tahini"
    
    // Nuts & Seeds
    case almonds = "Almonds"
    case walnuts = "Walnuts"
    case peanuts = "Peanuts"
    case cashews = "Cashews"
    case chiaSeeds = "Chia seeds"
    case sesameSeeds = "Sesame seeds"
    
    // Breads & Bakery
    case bread = "Bread"
    case breadcrumbs = "Breadcrumbs"
    case tortilla = "Tortilla"
    
    // Canned & Packaged
    case cannedTomatoes = "Canned tomatoes"
    case tomatoPaste = "Tomato paste"
    case coconutOil = "Coconut oil"
    
    var displayName: String { rawValue }
    
    // Unknown / Misc
    case unknown = "Unknown"
    
    static var orderedForUI: [Self] {
        let others = allCases
            .filter { $0 != .unknown }
            .sorted { $0.displayName < $1.displayName }
        return [.unknown] + others
    }
    
}

struct Ingredient: Identifiable, Codable {
    private(set) var id: UUID
    var name: IngredientName
    var quantity: Double
    var unit: IngredientUnit
    
    init(id: UUID = UUID(), name: IngredientName = .unknown, quantity: Double = 0, unit: IngredientUnit = .grams) {
        self.id = id
        self.name = name
        self.quantity = quantity
        self.unit = unit
    }
}


