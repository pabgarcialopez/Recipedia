//
//  Constants.swift
//  RecipeApp
//
//  Created by Pablo García López on 7/8/25.
//

import Foundation
import FirebaseAuth

// MARK: - App meta data
let APP_NAME = "Recipedia"

// MARK: - Storage settings
let MAX_SIZE: Int64 = 10 * 1024 * 1024 // 10 MB

// MARK: - Recipe defaults
let DEFAULT_RECIPE_NUM_PEOPLE = 4
let DEFAULT_RECIPE_NUM_PEOPLE_RANGE = 1...16
let DEFAULT_RECIPE_COVER = "defaultRecipeCover"

let INGREDIENTS: [IngredientName] = IngredientName.orderedForUI

// MARK: - User defaults
let DEFAULT_PROFILE_PICTURE = "defaultProfilePicture"

// MARK: - About / Privacy policy / Legal disclaimer / Terms & Conditions
let ABOUT = "About this app"
let PRIVACY_POLICY = "Privacy policy"
let LEGAL_DISCLAIMER = "Legal disclaimer"
let TERMS_AND_CONDITIONS = "Terms and conditions"

// MARK: - Firestore collections
let USERS_COLLECTION = "users"
let RECIPES_COLLECTION = "recipes"

// MARK: - Firestore Storage paths
let PROFILE_PICTURES_PATH = "images/profiles"
let RECIPES_PICTURES_PATH = "images/recipes"

let IMAGE_FORMAT = "jpg"
