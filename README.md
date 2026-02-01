# Recipedia

Recipedia is an iOS app designed to help users **store and consult personal recipes** in a structured and convenient way.

The app originated from my own need to digitally save recipes I created myself or wanted to keep for future reference, instead of relying on notes, screenshots, or memory. Recipedia focuses on making recipes easy to store, revisit, and understand at a glance.

---

## Features

### Recipes
- Create and save recipes for long-term reference
- Each recipe can include:
  - Title and description
  - A picture of the dish
  - A list of ingredients with quantities
  - The number of people the recipe is intended for
- When consulting a recipe, the number of people can be adjusted and ingredient quantities are recalculated dynamically

### User Profile
- User authentication via email and password
- Profile customization:
  - Change email and password
  - Add or edit a bio
  - Upload a profile picture

### Settings
- Basic account and profile management
- Secure update of user credentials

---

## Architecture

The app is implemented following the **MVVM (Model–View–ViewModel)** architectural pattern.

In brief:
- **Model**  
  Defines the core data structures and business logic (e.g. recipes, ingredients, user data).
- **View**  
  SwiftUI views responsible solely for presenting the UI and handling user interaction.
- **ViewModel**  
  Connects the View and the Model by:
  - Fetching and transforming data
  - Holding UI state
  - Exposing observable properties consumed by the Views

This separation of concerns improves maintainability, testability, and scalability of the codebase.

---

## Backend

Recipedia uses **Google Firebase** to handle backend functionality:

- **Firebase Authentication**  
  Manages user sign-up, login, and credential updates using email and password.

- **Firebase Database**  
  Stores user data and recipes persistently.

- **Firebase Storage**  
  Handles image uploads for both recipes and user profile pictures.

Firebase abstracts the backend logic, allowing the app to remain focused on client-side behavior and user experience.

---

## Tech Stack

- Language: Swift
- UI Framework: SwiftUI
- Architecture: MVVM
- Backend: Firebase (Authentication, Database, Storage)

---

## License

This project was developed for personal and educational purposes.
