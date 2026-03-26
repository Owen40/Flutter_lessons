# **Welcome to Flutter Git Lessons**

This repository guides onw with simple applications to introduction to flutter. From a simple application to navigation applications and how to Edit your launcher Icons.

#### **How do You change your launcher Icons.**


Add package:
flutter pub add flutter_launcher_icons

Configure pubspec.yaml:
flutter_launcher_icons:
  android: true
  ios: true
  image_path: "assets/icon.png"

Then run:
flutter pub run flutter_launcher_icons:main
