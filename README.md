# Mesh

Mesh is a real-time video meeting platform built with Flutter, WebRTC, and Go. It allows users to create meeting rooms, join existing rooms, and communicate through peer-to-peer audio and video calls.

## Features

- Create meeting rooms
- Join meetings using a room code
- Real-time audio and video communication
- Cross-platform support
- WebRTC peer-to-peer connections
- Modern Flutter UI

## Supported Platforms

- Android
- iOS
- Windows
- macOS
- Linux

## Requirements

Before running the application, make sure you have:

- Flutter SDK installed
- A configured `env.json` file
- A running Mesh backend/signaling server

## Environment Configuration

Create an `env.json` file in the project root:

```json
{
  "API_URL": "http://localhost:8080"
}
```

Adjust the values according to your backend configuration.

## Running the Application

### Development

```bash
flutter pub get

flutter run --dart-define-from-file=env.json
```

### Android

```bash
flutter run -d android --dart-define-from-file=env.json
```

### iOS

```bash
flutter run -d ios --dart-define-from-file=env.json
```

### Windows

```bash
flutter run -d windows --dart-define-from-file=env.json
```

### macOS

```bash
flutter run -d macos --dart-define-from-file=env.json
```

### Linux

```bash
flutter run -d linux --dart-define-from-file=env.json
```

## Building Releases

### Android APK

```bash
flutter build apk --release --dart-define-from-file=env.json
```

### Windows

```bash
flutter build windows --release --dart-define-from-file=env.json
```

### macOS

```bash
flutter build macos --release --dart-define-from-file=env.json
```

### Linux

```bash
flutter build linux --release --dart-define-from-file=env.json
```


## Build

### Android APK

```bash
flutter build apk --release --dart-define-from-file=env.json
```

Output:

```text
build/app/outputs/flutter-apk/app-release.apk
```

---

### Android App Bundle

```bash
flutter build appbundle --release --dart-define-from-file=env.json
```

Output:

```text
build/app/outputs/bundle/release/app-release.aab
```

---

### Windows

```bash
flutter build windows --release --dart-define-from-file=env.json
```

Output:

```text
build/windows/x64/runner/Release/
```

Run:

```bash
Mesh.exe
```

---

### macOS

```bash
flutter build macos --release --dart-define-from-file=env.json
```

Output:

```text
build/macos/Build/Products/Release/
```

Run:

```bash
Mesh.app
```

---

### Linux

```bash
flutter build linux --release --dart-define-from-file=env.json
```

Output:

```text
build/linux/x64/release/bundle/
```

Run:

```bash
./mesh
```

---

### Verify Supported Platforms

```bash
flutter devices
```

### Enable Desktop Platforms

```bash
flutter config --enable-windows-desktop
flutter config --enable-macos-desktop
flutter config --enable-linux-desktop
```

### Check Flutter Configuration

```bash
flutter doctor
```

## License

This project is available for educational and personal use.