# Missing-Child-Finder App

## Overview

The Missing Child Finder App is a Flutter-based mobile application designed to help users actively contribute to the search for missing children. The app utilizes camera technology and image recognition to scan the user's surroundings for missing children. When a match is found, users can use the "SEND" button to report the discovery, and the app will send location coordinates to the nearest police station.

## Features

- **Camera Integration:** Open the camera within the Flutter app to scan surroundings.
- **Image Recognition:** Used image recognition powered by tensorflow lite to identify missing children.
- **"SEND" Button:** Activate a button when a missing child is found to report the discovery.
- **Location Tracking:** Leverage Flutter's geolocation packages to track the user's location and send coordinates to the nearest police station.
- **Email Integration:** Use Flutter plugins to send automated emails with location information to the police station and app owner.

## Getting Started

### Prerequisites

Before you begin, ensure you have the following prerequisites installed:

- Flutter SDK: [Install Flutter](https://flutter.dev/docs/get-started/install)
- Dart SDK: [Install Dart](https://dart.dev/get-dart)

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/your_username/missing-child-finder.git
   cd missing-child-finder

2. Getting the required packages
   ```bash
   flutter pub get

### Running the App

To run the Missing Child Finder App on your emulator or connected device, use the following command:

   ```bash
   flutter run
   
