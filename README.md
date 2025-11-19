# Quran Aura 🌙

<div align="center">

![Version](https://img.shields.io/badge/version-1.0.0-blue.svg)
![Platform](https://img.shields.io/badge/platform-iOS-lightgrey.svg)
![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg)
![SwiftUI](https://img.shields.io/badge/SwiftUI-3.0-green.svg)
![License](https://img.shields.io/badge/license-MIT-green.svg)
![Status](https://img.shields.io/badge/status-Under%20Development-yellow.svg)

**A modern, elegant iOS application for listening to Quran recitations with Islamic Duas and prayers**

[Features](#features) • [Screenshots](#screenshots) • [Installation](#installation) • [Usage](#usage) • [API](#api) • [Contributing](#contributing) • [Developer](#developer)

</div>

---

## ⚠️ Development Status

**This application is currently under active development.** Features and functionality may change, and some features might not be fully stable. We appreciate your patience and welcome contributions!

---

## 📖 Overview

Quran Aura is a beautiful, user-friendly iOS application designed to provide Muslims with easy access to Quran recitations from various reciters worldwide. The app features a modern Arabic interface, audio streaming capabilities, Islamic Duas (supplications), and a rich user experience built with SwiftUI.

## ✨ Features

### 🎧 Quran Recitations
- **114 Surahs Available**: Complete Quran with all chapters
- **Multiple Reciters**: Choose from a wide selection of renowned Quran reciters
- **High-Quality Audio Streaming**: Stream MP3 audio directly from online sources
- **Audio Player Controls**:
  - Play/Pause functionality
  - Skip forward/backward (±15 seconds)
  - Seek to any position in the recitation
  - Real-time progress tracking
  - Duration display

### 🤲 Duas & Prayers
- **Islamic Supplications**: Curated collection of authentic Islamic Duas
- **Categorized Content**: Duas organized by categories for easy access
- **Arabic Text**: Full Arabic text with detailed explanations
- **Search Functionality**: Quickly find specific Duas
- **Share Duas**: Share supplications with friends and family

### 🎨 User Interface
- **Modern Arabic Interface**: Right-to-left (RTL) support with beautiful Arabic typography
- **Dark Mode Support**: Automatic dark/light theme switching
- **Custom Themes**: Multiple color themes to choose from:
  - Purple (Default)
  - Blue
  - Green
  - Orange
- **Responsive Design**: Optimized for all iOS device sizes
- **Smooth Animations**: Polished transitions and interactions

### 🔍 Search & Discovery
- **Advanced Search**: Search for Surahs and reciters instantly
- **Favorites System**: Mark your favorite Surahs and reciters
- **Recently Played**: Quick access to recently listened recitations
- **Reciter Profiles**: View detailed information about each reciter

### 📱 User Experience
- **Splash Screen**: Beautiful animated splash screen
- **Mini Player**: Persistent mini player at the bottom for easy control
- **Full Player View**: Immersive full-screen player experience
- **Loading States**: Elegant loading animations
- **Error Handling**: User-friendly error messages in Arabic
- **Offline Persistence**: Favorites and recent plays are saved locally

### 🌐 Social Integration
- **Share App**: Share the app with others
- **Social Media Links**: Connect with the developer on various platforms

---

## 🖼️ Screenshots

*Screenshots will be added as the app reaches stable release*

---

## 🛠️ Technical Stack

### Languages & Frameworks
- **Swift 5.0+**
- **SwiftUI 3.0+**
- **Combine Framework**: For reactive programming
- **AVFoundation**: For audio playback

### Architecture
- **MVVM Pattern**: Model-View-ViewModel architecture
- **ObservableObject**: State management using Combine
- **Singleton Services**: Centralized networking and data persistence
- **Codable Models**: Type-safe JSON parsing

### Key Components
- **AudioPlayer**: Custom AVPlayer wrapper for audio streaming
- **NetworkService**: Handles API requests for reciters, Surahs, and Duas
- **DataPersistence**: UserDefaults-based local storage for favorites and history
- **AppConfig**: Centralized configuration for theming and localization

---

## 📋 Requirements

- **iOS 15.0+**
- **Xcode 14.0+**
- **Swift 5.0+**
- **Active internet connection** for streaming audio

---

## 🚀 Installation

### Prerequisites

1. **macOS** with Xcode installed
2. **Apple Developer Account** (for running on physical devices)
3. **CocoaPods** (if dependencies are added in future)

### Steps

1. **Clone the repository**
   ```bash
   git clone https://github.com/azozzalfiras/quran-aura.git
   cd quran-aura
   ```

2. **Open the project**
   ```bash
   open "Quran Aura.xcodeproj"
   ```

3. **Select your target device**
   - Choose a simulator or connect your iOS device
   - Select the target device from the Xcode toolbar

4. **Build and Run**
   - Press `Cmd + R` or click the Run button
   - Wait for the build to complete
   - The app will launch on your selected device

### Configuration

The app uses a custom Info.plist (`Quran-Aura-Info.plist`) with:
- **App Transport Security**: Configured to allow HTTP connections for mp3quran.net
- **Scene Configuration**: Supports single-window apps

---

## 📖 Usage

### First Launch
1. The app opens with an animated splash screen
2. You'll land on the Home screen with featured reciters and Surahs

### Listening to Quran
1. **Browse Reciters**: Tap on "القراء" (Reciters) tab
2. **Select a Reciter**: Choose from the list of available reciters
3. **Choose a Surah**: Select any of the 114 Surahs
4. **Control Playback**: Use the player controls to play, pause, or seek

### Managing Favorites
- **Add to Favorites**: Tap the heart icon on any Surah or reciter
- **View Favorites**: Access favorites from the Home screen or Search tab
- **Remove from Favorites**: Tap the heart icon again to remove

### Exploring Duas
1. **Open Duas Tab**: Tap on "الأدعية" (Duas)
2. **Browse Categories**: Explore different Dua categories
3. **Read Duas**: Tap any Dua to read its full text and explanation
4. **Share**: Use the share button to send Duas to others

### Customization
1. **Open Settings**: Tap on "الإعدادات" (Settings)
2. **Change Theme**: Select your preferred color scheme
3. **Toggle Dark Mode**: Switch between light and dark appearances

---

## 🌐 API Integration

The app consumes the following APIs:

### Base URL
```
https://quran-aura.fahmly.com/api/v1/
```

### Endpoints

#### 1. Get Reciters List
```
GET /list.php
```
Returns a list of all available Quran reciters with their audio URLs.

**Response:**
```json
{
  "status": 200,
  "success": true,
  "message": "Success",
  "info": "Reciters list",
  "data": [
    {
      "name": "Reciter Name",
      "href": "https://...",
      "image": "https://..."
    }
  ]
}
```

#### 2. Get Surahs List
```
GET /souar.php
```
Returns all 114 Surahs with their names and numbers.

**Response:**
```json
{
  "status": 200,
  "success": true,
  "message": "Success",
  "info": "Surahs list",
  "data": {
    "Surah Name": "001",
    ...
  }
}
```

#### 3. Get Duas
```
GET /duas.php
```
Returns categorized Islamic Duas and supplications.

**Response:**
```json
{
  "status": 200,
  "success": true,
  "data": {
    "categories": [
      {
        "id": "1",
        "title": "Category Title",
        "duas": [...]
      }
    ]
  }
}
```

### Audio Streaming
Audio files are streamed from reciter-specific URLs:
```
{reciter_base_url}/{surah_number_padded}.mp3
```
Example: `https://example.com/001.mp3`

---

## 📁 Project Structure

```
Quran Aura/
├── App/
│   ├── QuranAuraApp.swift          # App entry point
│   ├── ContentView.swift           # Main content view
│   └── SplashScreenView.swift      # Splash screen
├── Models/
│   ├── Surah.swift                 # Surah data model
│   ├── Reciter.swift               # Reciter data model
│   ├── Dua.swift                   # Dua data model
│   ├── DuaCategory.swift           # Dua category model
│   ├── RecentPlay.swift            # Recent playback model
│   └── AppSettings.swift           # App settings model
├── Views/
│   ├── Home/                       # Home screen views
│   ├── Reciters/                   # Reciters list views
│   ├── Player/                     # Audio player views
│   ├── Search/                     # Search functionality views
│   ├── Duas/                       # Duas & prayers views
│   ├── Settings/                   # Settings & about views
│   └── Common/                     # Reusable UI components
├── Services/
│   ├── NetworkService.swift        # API networking layer
│   ├── AudioPlayer.swift           # Audio playback service
│   └── DataPersistence.swift       # Local data storage
├── Utilities/
│   ├── AppConfig.swift             # App configuration & theming
│   ├── Extensions.swift            # Swift extensions
│   └── ShareSheet.swift            # iOS share sheet
└── Assets.xcassets/                # Images and icons
```

---

## 🎨 Customization

### Adding New Themes

Edit `Quran Aura/Utilities/AppConfig.swift`:

```swift
let themes: [Theme] = [
    Theme(name: "Theme Name", primaryColor: .color1, secondaryColor: .color2),
    // Add your theme here
]
```

### Changing API Endpoints

Edit `Quran Aura/Services/NetworkService.swift`:

```swift
let url = URL(string: "https://your-api-endpoint.com/...")
```

### Modifying Localization

All Arabic strings are centralized in `AppConfig.swift` under the `Strings` struct:

```swift
struct Strings {
    let home = "الرئيسية"
    // Add or modify strings here
}
```

---

## 🤝 Contributing

Contributions are welcome! This project is under development, and we appreciate any help to improve it.

### How to Contribute

1. **Fork the repository**
2. **Create a feature branch**
   ```bash
   git checkout -b feature/amazing-feature
   ```
3. **Commit your changes**
   ```bash
   git commit -m 'Add some amazing feature'
   ```
4. **Push to the branch**
   ```bash
   git push origin feature/amazing-feature
   ```
5. **Open a Pull Request**

### Guidelines

- Follow Swift style guidelines
- Write clean, documented code
- Test your changes thoroughly
- Update README if you add new features
- Respect the Arabic RTL interface design

### Areas for Contribution

- [ ] Add unit tests
- [ ] Improve error handling
- [ ] Add download functionality for offline listening
- [ ] Implement bookmarking specific Ayahs
- [ ] Add translation options for Duas
- [ ] Optimize audio streaming and caching
- [ ] Add Quran text display alongside audio
- [ ] Implement recitation timing (Tajweed) features
- [ ] Add widgets for iOS home screen
- [ ] Localization for other languages

---

## 🐛 Known Issues

As the app is under development, here are some known issues:

- Audio streaming may fail if the source server is down
- Some reciters may have incomplete Surah collections
- Network errors need more robust handling
- No offline mode currently available
- Background audio playback needs optimization

**Please report new issues on GitHub Issues page.**

---

## 📄 License

This project is licensed under the **MIT License** - see the [LICENSE](LICENSE) file for details.

### MIT License Summary

```
MIT License

Copyright (c) 2024 Azozz Al Firas

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

---

## 👨‍💻 Developer

**Azozz Al Firas**

- 🌐 Website: [quranaura.com](https://quranaura.com)
- 📧 Email: dev@quranaura.com
- 🐙 GitHub: [@azozzalfiras](https://github.com/azozzalfiras)
- 𝕏 Twitter: [@dev_3zozz](https://x.com/dev_3zozz)
- 📸 Instagram: [@dev_3zozz](https://instagram.com/dev_3zozz)
- 🎵 TikTok: [@dev_3zozz](https://tiktok.com/@dev_3zozz)
- 👻 Snapchat: [@n.uf](https://snapchat.com/add/n.uf)

---

## 🙏 Acknowledgments

- **Quran Audio Sources**: Thanks to all the reciters and Quran audio providers
- **API Provider**: [fahmly.com](https://fahmly.com) for the Quran API
- **Islamic Content**: Various authentic Islamic sources for Duas
- **SwiftUI Community**: For inspiration and open-source contributions
- **Beta Testers**: Everyone who provided feedback during development

---

## 📱 App Information

- **Bundle ID**: `com.quranaura.app`
- **Version**: 1.0.0
- **Build**: Under Development
- **Minimum iOS**: 15.0
- **Supported Devices**: iPhone, iPad
- **Orientation**: Portrait
- **Language**: Arabic (RTL)

---

## 🔮 Future Roadmap

### Version 1.1
- [ ] Offline download capability
- [ ] Background audio playback
- [ ] iOS widgets
- [ ] Apple Watch support

### Version 1.2
- [ ] Quran text display with audio synchronization
- [ ] Translation in multiple languages
- [ ] Tafseer (Quran interpretation) integration
- [ ] Bookmarking system

### Version 2.0
- [ ] Social features (sharing progress, playlists)
- [ ] Advanced audio controls (speed, pitch)
- [ ] Playlist creation and management
- [ ] Cloud sync across devices
- [ ] macOS version

---

## 📞 Support

If you encounter any issues or have questions:

1. **Check the documentation** in this README
2. **Search existing issues** on GitHub
3. **Create a new issue** with detailed description
4. **Contact the developer** via email: dev@quranaura.com

---

## ⭐ Show Your Support

If you find this project useful, please consider:

- ⭐ Starring the repository
- 🐛 Reporting bugs and issues
- 💡 Suggesting new features
- 🤝 Contributing to the code
- 📢 Sharing with others

---

## 📊 Project Stats

![GitHub Stars](https://img.shields.io/github/stars/azozzalfiras/quran-aura?style=social)
![GitHub Forks](https://img.shields.io/github/forks/azozzalfiras/quran-aura?style=social)
![GitHub Issues](https://img.shields.io/github/issues/azozzalfiras/quran-aura)
![GitHub Pull Requests](https://img.shields.io/github/issues-pr/azozzalfiras/quran-aura)

---

<div align="center">

**Made with ❤️ for the Muslim community**

جَزَاكَ ٱللَّٰهُ خَيْرًا (May Allah reward you with goodness)

</div>
