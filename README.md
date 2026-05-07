# Sleep-Circle

> A comprehensive Flutter sleep tracking application that monitors your sleep quality through noise detection, smart alarms, calendar history, and Firebase-synced insights.

---

## Overview

Sleep-Circle helps users understand and improve their sleep patterns. The app uses the device microphone to detect ambient noise levels during sleep, sets smart alarms, tracks sleep history on a visual calendar, and syncs all data to Firebase so your insights are always available across devices. Google Sign-In and Firebase Auth keep your data secure and personal.

## Features

- **Noise Monitoring** — Uses `noise_meter` to track ambient sound levels while you sleep, detecting disturbances
- **Smart Alarms** — Set and manage alarms with the `alarm` package for gentle wake-up scheduling
- **Sleep Calendar** — Visual `table_calendar` view showing historical sleep records and patterns
- **Progress Indicators** — Circular and linear progress indicators to display sleep quality scores
- **Onboarding Flow** — Smooth `flutter_onboarding_slider` introduction for new users
- **Firebase Backend** — Cloud Firestore for data storage, Firebase Auth for secure login, Firebase Storage for media
- **Google Sign-In** — One-tap authentication with your Google account
- **Hive Local Cache** — Offline-capable local storage for seamless experience without network
- **Adaptive UI** — Responsive layouts with `flutter_screenutil` and `flutter_slidable` list interactions
- **Cross-Platform** — Android, iOS, Web, Windows, macOS, and Linux support

## Tech Stack

| Layer | Technology |
|---|---|
| Framework | Flutter (Dart) |
| Authentication | Firebase Auth + Google Sign-In |
| Database | Cloud Firestore |
| Storage | Firebase Storage |
| Local Cache | Hive |
| Noise Detection | noise_meter |
| Alarms | alarm package |
| Calendar | table_calendar |
| UI Utilities | flutter_screenutil, flutter_slidable, percent_indicator, simple_ripple_animation |
| Onboarding | flutter_onboarding_slider |

## Project Structure

```
Sleep-Circle/
├── android/                  # Android platform files
├── ios/                      # iOS platform files
├── web/                      # Web platform files
├── windows/                  # Windows platform files
├── macos/                    # macOS platform files
├── linux/                    # Linux platform files
├── assets/                   # Images, animations, sounds
├── lib/                      # Main Dart source code
│   ├── main.dart
│   ├── bindings/             # Dependency injection
│   ├── controllers/          # Sleep, alarm, calendar controllers
│   ├── models/               # Sleep session & user data models
│   ├── views/
│   │   ├── onboarding/       # Onboarding screens
│   │   ├── home/             # Dashboard & sleep quality view
│   │   ├── alarm/            # Alarm setup & management
│   │   ├── calendar/         # Sleep history calendar
│   │   └── settings/         # User preferences
│   └── services/             # Firebase, noise meter, alarm services
├── test/                     # Unit & widget tests
├── firebase.json             # Firebase project config
├── pubspec.yaml              # Flutter dependencies
└── README.md
```

## Getting Started

### Prerequisites

- Flutter SDK `>=3.3.0 <4.0.0`
- A Firebase project with **Authentication**, **Firestore**, and **Storage** enabled
- Google Sign-In configured in your Firebase project
- Microphone permission granted on device (for noise detection)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/SalooMughal/Sleep-Circle.git
   cd Sleep-Circle
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure Firebase**
   - Go to [console.firebase.google.com](https://console.firebase.google.com) and create a project
   - Enable **Email/Password** and **Google** as sign-in providers
   - Download `google-services.json` → place in `android/app/`
   - Download `GoogleService-Info.plist` → place in `ios/Runner/`

4. **Run the app**
   ```bash
   flutter run
   ```

### Required Permissions

Add the following to your `AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.RECORD_AUDIO"/>
<uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED"/>
<uses-permission android:name="android.permission.WAKE_LOCK"/>
```

## Usage

1. **Sign in** with your Google account
2. Complete the **onboarding** to set your sleep goals
3. Tap **Start Sleep Tracking** before going to bed — the app will monitor noise levels overnight
4. Set a **smart alarm** to wake you during your lightest sleep phase
5. Review your **sleep quality score** and history in the calendar view the next morning

## Building for Production

```bash
# Android
flutter build apk --release

# iOS
flutter build ios --release

# Web
flutter build web
```

## Contributing

Pull requests are welcome. Please open an issue first to discuss what you'd like to change.

## License

This project is licensed under the MIT License.
