# Simple Planner

A minimal daily planner app built with Flutter.

## Features

- Daily task management with time-based scheduling
- Calendar view for date navigation
- Recurring tasks support
- Local SQLite database (Drift)
- Multi-language support (English, Korean)
- Ad-supported with optional ad removal (In-App Purchase)

## Tech Stack

- Flutter 3.10+
- Drift (SQLite)
- Table Calendar
- Google Mobile Ads
- In-App Purchase

## Getting Started

### Prerequisites

- Flutter SDK 3.10 or higher
- Dart SDK 3.0 or higher

### Installation

```bash
# Clone the repository
git clone https://github.com/your-username/simple_planner.git

# Navigate to project directory
cd simple_planner

# Install dependencies
flutter pub get

# Generate database files
dart run build_runner build

# Run the app
flutter run
```

## Project Structure

```
lib/
├── main.dart           # App entry point
├── constants/          # App constants
├── database/           # Drift database
├── l10n/               # Localization files
├── screens/            # Screen widgets
├── services/           # Ad & Purchase services
├── state/              # State management
├── utils/              # Utility functions
└── widgets/            # Reusable widgets
```

## License

Copyright (c) 2025 Wearablock INC. All Rights Reserved.

This source code is provided for reference only. See [LICENSE](LICENSE) for details.
