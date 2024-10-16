# Project Structure Documentation

## Overview

This Flutter project is organized to separate concerns and facilitate easy maintenance and scalability. The main sections include custom widgets, models, providers, services, and Firebase integration.

## Directory Structure

```
lib/
├── customWidgets/
│   ├── navbar/
│   │   ├── Factory/
│   │   │   └── navbar_factory.dart
│   │   ├── Implementations/
│   │   │   ├── guestNavbar.dart
│   │   │   └── studentNavbar.dart
│   │   └── Interface/
│   │       ├── CustomNavigationDrawer.dart
│   │       └── navigationdrawer_constants.dart
│   └── checkBox.dart
├── models/
│   └── User.dart
├── providers/
│   └── firebaseProvider.dart
│── services/
│   ├── UserDataService.dart
│   └── firebase_options.dart
└── main.dart
```

## Key Components

### Custom Widgets (`customWidgets/`)

#### Navigation Bar (`navbar/`)

- **Factory**: Implements the navigation drawer factory pattern.
  - `navbar_factory.dart`: Creates appropriate navigation drawers based on user roles.

- **Implementations**: Contains specific navigation drawer implementations.
  - `guestNavbar.dart`: Navigation drawer for guest users.
  - `studentNavbar.dart`: Navigation drawer for student users.

- **Interface**: Defines the contract for navigation drawers.
  - `CustomNavigationDrawer.dart`: An abstract class(interface) for navigation drawers.
  - `navigationdrawer_constants.dart`: Constants used in navigation drawers.

#### Other Widgets
- `checkBox.dart`: A custom checkbox widget implementation.

### Models (`models/`)
- `User.dart`: Defines the data structure for user information, including properties such as role, institution, and profile picture URL.

### Providers (`providers/`)
- `firebaseProvider.dart`: Manages Firebase-related operations and state management across the app, especially for Firebase authentication and data retrieval.

### Services (`services/`)
- `UserDataService.dart`: Handles user data operations and business logic, such as fetching user data and managing updates.
- `firebase_options.dart`: Contains Firebase configuration options for initialization.

### Main Application File
- `main.dart`: The main entry point of the application, where the app is initialized and the Firebase configuration is applied.

## Firebase Integration

The project uses Firebase as its backend service, providing features such as user authentication and data storage. Firebase configuration and initialization settings are stored in `firebase_options.dart`, while Firebase-specific logic and state management are handled by `firebaseProvider.dart`.
