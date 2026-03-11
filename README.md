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

<img width="308" height="621" alt="Screenshot 2026-03-11 at 00 50 09" src="https://github.com/user-attachments/assets/80a1af54-e14d-4f32-8345-0f86f15067a0" />

<img width="308" height="621" alt="Screenshot 2026-03-11 at 00 54 54" src="https://github.com/user-attachments/assets/19302610-b819-4701-b5b5-81fafbf64fa4" />

<img width="308" height="621" alt="Screenshot 2026-03-11 at 00 54 50" src="https://github.com/user-attachments/assets/f5b25450-3766-4eb1-8621-fe246abc2e0d" />

 <img width="308" height="621" alt="Screenshot 2026-03-11 at 00 54 45" src="https://github.com/user-attachments/assets/7d657904-4bf8-468e-a379-5b4037d27a06" />

 <img width="308" height="621" alt="Screenshot 2026-03-11 at 01 19 16" src="https://github.com/user-attachments/assets/585007c2-1211-4915-a384-ded25121533f" />

 <img width="308" height="621" alt="Screenshot 2026-03-11 at 01 24 58" src="https://github.com/user-attachments/assets/2a0abdac-dbb9-4842-8f01-f94aa9178d6a" />

## Tech Stack
- **Framework**: Flutter / Dart
- **State Management**: Riverpod (`riverpod_annotation`, `riverpod_generator`)
- **Local Database**: Isar (NoSQL)
- **Routing**: GoRouter
- **Notifications**: `flutter_local_notifications`

## 📦 Download APK

[Download Latest APK](https://github.com/iXSavage/carcare/releases/tag/v1.0.0)

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
