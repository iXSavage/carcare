# CarCare 🚗
**Your smart car companion**

CarCare is a clean, modern Flutter app for tracking all your vehicle's essential data in one place. Log fill-ups, track service history, store insurance/registration documents, and never miss a renewal thanks to smart local notifications.

## Features
- **Fuel Tracking**: Log fill-ups with cost, litres/gallons, and odometer readings.
- **Receipt Capture**: Attach photos of your receipts directly to fuel & service logs.
- **Service History**: Maintain a complete log of your car's maintenance history and total ownership cost.
- **Document Vault**: Store your driver's license, insurance, and MOT/registration documents.
- **Smart Reminders**: Get notified *before* documents expire or when a service is overdue.
- **Multi-Car Support**: Manage multiple vehicles inside a single app.
- **Offline First**: Built with Isar for lightning-fast, privacy-first local storage.
- **Dynamic Localization**: Toggle between Metric/Imperial units and native currency symbols.

## Tech Stack
- **Framework**: Flutter / Dart
- **State Management**: Riverpod (`riverpod_annotation`, `riverpod_generator`)
- **Local Database**: Isar (NoSQL)
- **Routing**: GoRouter
- **Notifications**: `flutter_local_notifications`

## Getting Started

### Prerequisites
- Flutter SDK (v3.10+)
- Dart SDK

### Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/ixsavage/carcare.git
   cd carcare
   ```
2. Fetch dependencies and generate code (Riverpod/Isar):
   ```bash
   flutter pub get
   dart run build_runner build -d
   ```
3. Run the app:
   ```bash
   flutter run
   ```

## License
This project is open-source. Please see the `LICENSE` file for details.
