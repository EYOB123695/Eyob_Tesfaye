Mobile App For Assesment.

Overview

This Mobile App is a Flutter application built as part of the A2SV Eskalate technical interview. The goal is to demonstrate clean architecture implementation, effective state management, and clean UI practices. The application integrates with a public REST API to fetch and display data about countries and supports search functionality.

This version implements:

✅ Home Screen with country list

✅  search by country name

Future enhancements will include country detail view, favoriting system, persistent storage, and more.

Features

🌍 Display Countries: Fetch and show a list of countries with name, population, and flag

🔍 Search Functionality: Filter countries in real time as the user types

💥  Loading States: Feedback to users during data fetching 

Architecture

The app follows Clean Architecture with three layers:

Presentation Layer: UI, widgets, BLoC state management

Domain Layer: Business logic, use cases, and entities

Data Layer: Data models, repositories, and API integration

State management is handled via flutter_bloc .

Project Structure

lib/
├── core/                   # Reusable components and logic
├── data/                   # Data models and API repository
├── domain/                 # Entities, repositories, and usecases
├── presentation/           # UI screens, blocs, and events/states
└── main.dart               # App entry point

Installation

Prerequisites
Flutter SDK
3.22.3 
Dart SDK
3.4.4 

Android Studio or VS Code

Setup

git clone <https://github.com/EYOB123695/Eyob_Tesfaye>
cd eyobtesfaye
flutter pub get
flutter run

Usage

On launch, the app fetches and displays a list of independent countries.

Use the search bar to filter countries by name.

Handles loading indicators and empty search results.



Technical Choices

State Management: flutter_bloc


Functional Programming: dartz

HTTP Requests: http

Error Handling: Custom failure classes (core/error)


License

This project is licensed under the MIT License

Contact

For any inquiries, please reach out via eyob.tesfaye@a2sv.org




