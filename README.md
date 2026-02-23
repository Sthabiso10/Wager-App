## 🎯 Overview

Wager App is a modern, full-featured Flutter application designed to help users create, manage, and track wagers and bets. Built with clean architecture principles and powered by Firebase, the application provides seamless authentication, real-time data synchronization, and an intuitive user interface across multiple platforms.

## ✨ Features

### Core Functionality
- **User Authentication**: Secure sign-up and login via Firebase Authentication
- **Wager Management**: Create, edit, and delete wagers with ease
- **Real-time Synchronization**: Cloud-based data sync with Firestore
- **Multi-platform Support**: Works on Android, iOS, Web, Windows, macOS, and Linux

### User Experience
- **Smooth Animations**: Delightful UI animations using Lottie and simple_animations
- **Responsive Design**: Adaptive layouts for all screen sizes
- **Image Support**: Upload and pick images from device or camera
- **Notifications**: Time-zone aware notifications with customizable alerts
- **Gesture Controls**: Smooth swipe actions with flutter_slidable

### Technical Features
- **Modern Architecture**: Built with the Stacked pattern for separation of concerns
- **Dependency Injection**: Get_it for efficient service management
- **Custom Fonts**: Google Fonts integration for beautiful typography
- **Bottom Navigation**: Smooth navigation with Google Nav Bar

## 🛠️ Tech Stack

### Frontend
- **Framework**: Flutter (Dart 3.0+)
- **UI Components**:
  - Flutter Slidable: Swipeable list items
  - Google Nav Bar: Bottom navigation
  - Flutter Speed Dial: Floating action menu
  - Lottie: Animated graphics
  - Cupertino Icons: Native iOS-style icons
  - Google Fonts: Custom typography

### Backend & Database
- **Authentication**: Firebase Authentication
- **Database**: Cloud Firestore
- **Core**: Firebase Core
- **Environment**: Flutter Dotenv for configuration management

### Utilities
- **State Management**: Stacked architecture
- **Service Locator**: Get_it
- **Internationalization**: Intl (i18n support)
- **UUID Generation**: UUID package for unique identifiers
- **Random Strings**: Random string generation for IDs
- **Image Handling**: Image_picker for gallery and camera access
- **Permissions**: Permission_handler for OS-level permissions
- **Date/Time**: Timezone support for scheduled notifications

## 🌍 Platform Support

| Platform | Status |
|----------|--------|
| Android  | ✅ Supported |
| iOS      | ✅ Supported |
| Web      | ✅ Supported |
| Windows  | ✅ Supported |
| macOS    | ✅ Supported |
| Linux    | ✅ Supported |

## 📦 Prerequisites

- **Flutter**: v3.0.0 or higher
- **Dart**: v3.0.0 or higher
- **Firebase Account**: For backend services
- **Git**: For version control

## 🚀 Installation

### 1. Clone the Repository
```bash
git clone https://github.com/Sthabiso10/Wager-App.git
cd Wager-App
