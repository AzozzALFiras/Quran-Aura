# 🕌 Quran Aura - قرآن أورا

<div align="center">

![iOS](https://img.shields.io/badge/iOS-15.6+-000000?style=for-the-badge&logo=apple&logoColor=white)
![Swift](https://img.shields.io/badge/Swift-5.0-FA7343?style=for-the-badge&logo=swift&logoColor=white)
![SwiftUI](https://img.shields.io/badge/SwiftUI-blue?style=for-the-badge&logo=swift&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)
![Status](https://img.shields.io/badge/Status-Under%20Development-yellow?style=for-the-badge)

**A beautiful and modern iOS application for listening to the Holy Quran with the voices of the most famous reciters**

[Features](#-features) • [Screenshots](#-screenshots) • [Installation](#-installation) • [Usage](#-usage) • [Architecture](#-architecture) • [API](#-api) • [Contributing](#-contributing) • [License](#-license)

</div>

---

## 📖 About

**Quran Aura** (قرآن أورا) is a free, open-source iOS application that provides a seamless experience for listening to the Holy Quran. Built with SwiftUI and modern iOS development practices, the app offers a beautiful interface with support for multiple reciters, favorites management, and an elegant audio player.

> **⚠️ Note:** This application is currently **under active development**. Features and functionality are being continuously improved and expanded.

---

## ✨ Features

### 🎧 Audio Playback
- **High-Quality Audio Streaming**: Listen to Quran recitations in high quality
- **Multiple Reciters**: Choose from a wide selection of world-renowned Quran reciters
- **Full Audio Player**: Beautiful full-screen player with playback controls
- **Mini Player**: Persistent mini player for background listening
- **Playback Controls**: Play, pause, seek, and control volume
- **Progress Tracking**: Visual progress bar with time indicators

### 📚 Quran Content
- **All 114 Surahs**: Complete Quran with all chapters
- **Surah Information**: Detailed information for each Surah including verse count
- **Surah Numbers**: Formatted Surah numbers (001-114)
- **Arabic Text**: Full Arabic text display

### 🤲 Duas (Supplications)
- **Categorized Duas**: Browse duas organized by categories
- **Dua Details**: View complete dua text with explanations
- **Search Duas**: Search through duas by title or text
- **Audio Support**: Listen to dua recitations (where available)

### 🔍 Search & Discovery
- **Smart Search**: Search for Surahs, reciters, and duas
- **Recent Plays**: Quick access to recently played Surahs
- **Favorites**: Save your favorite Surahs and reciters
- **Featured Reciters**: Discover popular reciters

### 🎨 User Interface
- **Modern Design**: Beautiful, clean interface built with SwiftUI
- **Dark Mode**: Full dark mode support
- **Islamic Aesthetics**: Gradient backgrounds with Islamic design elements
- **Smooth Animations**: Fluid transitions and animations
- **RTL Support**: Right-to-left layout for Arabic text
- **Responsive**: Optimized for iPhone and iPad

### ⚙️ Settings & Customization
- **Theme Selection**: Choose from multiple color themes
- **Appearance Settings**: Toggle dark mode
- **Playback Quality**: Adjust audio quality settings
- **Auto-play**: Enable/disable auto-play next Surah
- **Notifications**: Manage notification preferences

### 📱 Social Integration
- **Share**: Share Surahs and app with friends
- **Social Media Links**: Connect on X (Twitter), Instagram, TikTok, Snapchat, and GitHub
- **About Section**: Learn more about the app and its features

---

## 🖼️ Screenshots

<p align="center">
<img src="https://raw.githubusercontent.com/AzozzALFiras/Quran-Aura/refs/heads/main/screenshots/1.png" width="250" height="520" />
<img src="https://raw.githubusercontent.com/AzozzALFiras/Quran-Aura/refs/heads/main/screenshots/2.png" width="250" height="520" />
<img src="https://raw.githubusercontent.com/AzozzALFiras/Quran-Aura/refs/heads/main/screenshots/3.png" width="250" height="520" />
<img src="https://raw.githubusercontent.com/AzozzALFiras/Quran-Aura/refs/heads/main/screenshots/4.png" width="250" height="520" />
<img src="https://raw.githubusercontent.com/AzozzALFiras/Quran-Aura/refs/heads/main/screenshots/5.png" width="250" height="520" />
<img src="https://raw.githubusercontent.com/AzozzALFiras/Quran-Aura/refs/heads/main/screenshots/6.png" width="250" height="520" />
<img src="https://raw.githubusercontent.com/AzozzALFiras/Quran-Aura/refs/heads/main/screenshots/7.png" width="250" height="520" />
<img src="https://raw.githubusercontent.com/AzozzALFiras/Quran-Aura/refs/heads/main/screenshots/8.png" width="250" height="520" />
<img src="https://raw.githubusercontent.com/AzozzALFiras/Quran-Aura/refs/heads/main/screenshots/9.png" width="250" height="520" />
</p>

---

## 🛠️ Installation

### Prerequisites

- **macOS**: macOS 13.0 (Ventura) or later
- **Xcode**: Xcode 14.0 or later
- **iOS Device/Simulator**: iOS 15.6 or later
- **Apple Developer Account**: Required for device testing (free account works)

### Setup Instructions

1. **Clone the Repository**
   ```bash
   git clone https://github.com/azozzalfiras/quran-aura.git
   cd quran-aura
   ```

2. **Open in Xcode**
   ```bash
   open "Quran Aura.xcodeproj"
   ```

3. **Configure Signing**
   - Select the project in Xcode
   - Go to "Signing & Capabilities"
   - Select your development team
   - Xcode will automatically manage provisioning profiles

4. **Build and Run**
   - Select your target device or simulator
   - Press `Cmd + R` or click the Run button
   - Wait for the build to complete

### Dependencies

This project uses **no external dependencies** - it's built entirely with native iOS frameworks:
- SwiftUI
- AVFoundation
- Combine
- Foundation

---

## 📱 Usage

### First Launch

1. **Splash Screen**: The app opens with a beautiful animated splash screen
2. **Data Loading**: Reciters and Surahs are automatically loaded from the API
3. **Home Screen**: Browse featured reciters and recent Surahs

### Listening to Quran

1. **Select a Reciter**: Browse reciters from the home screen or reciters tab
2. **Choose a Surah**: Select any of the 114 Surahs
3. **Play**: Tap the play button to start listening
4. **Control Playback**: Use the mini player or full player for controls

### Managing Favorites

- **Add to Favorites**: Tap the heart icon on any Surah or reciter
- **View Favorites**: Access your favorites from the Search tab
- **Remove from Favorites**: Tap the filled heart icon to remove

### Searching

- **Search Bar**: Use the search tab to find Surahs, reciters, or duas
- **Filter Results**: Results are automatically filtered as you type
- **Quick Access**: Tap any result to view details or start playing

### Reading Duas

1. **Navigate to Duas**: Select the Duas tab from the home screen
2. **Browse Categories**: Explore duas organized by category
3. **View Details**: Tap any dua to read the full text and explanation
4. **Search**: Use the search bar to find specific duas

---

## 🏗️ Architecture

### Project Structure

```
Quran Aura/
├── App/
│   ├── QuranAuraApp.swift          # App entry point
│   ├── ContentView.swift            # Main content view with tab navigation
│   └── SplashScreenView.swift       # Animated splash screen
│
├── Models/
│   ├── Reciter.swift                # Reciter data model
│   ├── Surah.swift                  # Surah data model
│   ├── Dua.swift                    # Dua data model
│   ├── DuaCategory.swift            # Dua category model
│   ├── RecentPlay.swift             # Recent play history model
│   ├── AppData.swift                # App state management
│   └── AppSettings.swift            # User settings model
│
├── Services/
│   ├── NetworkService.swift         # API networking layer
│   ├── AudioPlayer.swift            # Audio playback management
│   └── DataPersistence.swift        # Local data storage
│
├── Views/
│   ├── Home/
│   │   ├── HomeView.swift           # Home screen
│   │   ├── ReciterCard.swift        # Reciter card component
│   │   ├── RecentPlayRow.swift      # Recent play row
│   │   └── QuickActionCard.swift    # Quick action buttons
│   │
│   ├── Search/
│   │   └── SearchView.swift         # Search and favorites
│   │
│   ├── Reciters/
│   │   ├── RecitersListView.swift   # List of all reciters
│   │   ├── ReciterDetailView.swift  # Reciter detail page
│   │   └── ReciterRow.swift         # Reciter list item
│   │
│   ├── Surahs/
│   │   ├── SurahsListView.swift     # List of all Surahs
│   │   └── SurahRow.swift           # Surah list item
│   │
│   ├── Duas/
│   │   ├── DuasView.swift           # Duas main view
│   │   ├── DuaCategoryView.swift    # Category detail view
│   │   ├── DuaDetailView.swift      # Individual dua detail
│   │   └── DuaRow.swift             # Dua list item
│   │
│   ├── Player/
│   │   ├── FullPlayerView.swift     # Full-screen audio player
│   │   └── MiniPlayerView.swift     # Minimized player bar
│   │
│   ├── Settings/
│   │   ├── SettingsView.swift       # Settings screen
│   │   ├── AboutView.swift          # About app screen
│   │   ├── SocialMediaView.swift    # Social media links
│   │   └── SocialMediaButton.swift  # Social button component
│   │
│   └── Common/
│       ├── LoadingView.swift        # Loading indicator
│       ├── ErrorView.swift          # Error display
│       ├── RemoteImage.swift        # Async image loader
│       └── ProgressBar.swift        # Custom progress bar
│
├── Utilities/
│   ├── AppConfig.swift              # App configuration & constants
│   ├── Extensions.swift             # Swift extensions
│   └── ShareSheet.swift             # Share functionality
│
└── Assets.xcassets/                 # Images and colors
```

### Design Patterns

- **MVVM Architecture**: Model-View-ViewModel pattern with SwiftUI
- **ObservableObject**: State management using Combine framework
- **Dependency Injection**: Views receive dependencies through initializers
- **Repository Pattern**: NetworkService handles all API calls
- **Singleton Pattern**: Shared instances for NetworkService and AppConfig

### Key Components

#### AudioPlayer
- Manages AVPlayer instance
- Handles audio playback state
- Provides time tracking and seeking
- Publishes playback status updates

#### AppData
- Manages user favorites (Surahs and reciters)
- Tracks recent play history
- Persists settings to UserDefaults
- Observable state for UI updates

#### NetworkService
- Fetches reciters from API
- Loads Surah data
- Retrieves duas and categories
- Handles network errors gracefully

---

## 🌐 API

The app uses the following APIs:

### Base URL
```
https://quran-aura.fahmly.com/api/v1/
```

### Endpoints

#### 1. Get Reciters List
```http
GET /list.php
```

**Response:**
```json
{
  "status": 200,
  "success": true,
  "message": "Success",
  "info": "List of reciters",
  "data": [
    {
      "name": "عبد الباسط عبد الصمد",
      "href": "https://server.mp3quran.net/basit/",
      "image": "https://example.com/image.jpg"
    }
  ]
}
```

#### 2. Get Surahs List
```http
GET /souar.php
```

**Response:**
```json
{
  "status": 200,
  "success": true,
  "message": "Success",
  "info": "List of Surahs",
  "data": {
    "1": "الفاتحة",
    "2": "البقرة",
    "114": "الناس"
  }
}
```

#### 3. Get Duas
```http
GET /duas.php
```

**Response:**
```json
{
  "status": 200,
  "success": true,
  "message": "Success",
  "timestamp": "2024-01-01T00:00:00Z",
  "data": {
    "totalCategories": 10,
    "totalPrayers": 100,
    "categories": [
      {
        "id": "morning",
        "name": "أذكار الصباح",
        "name_en": "Morning Remembrance",
        "count": 15,
        "prayers": [...]
      }
    ]
  }
}
```

### Audio Streaming

Audio files are streamed from reciter-specific URLs:
```
{reciter.href}/{surah_number}.mp3
```

Example:
```
https://server.mp3quran.net/basit/001.mp3
```

---

## 🌍 Localization

### Current Languages

- **Arabic (العربية)**: Primary language, full RTL support
- **English**: Partial support for technical terms

### Adding New Languages

1. Create a new `.strings` file in Xcode
2. Add translations for all keys in `AppConfig.Strings`
3. Update `Localizable.strings` with new language
4. Test RTL/LTR layout as needed

---

## 🎨 Theming

### Color Schemes

The app supports multiple color themes:

1. **Purple Theme** (Default)
   - Primary: `rgb(0.5, 0.2, 0.8)`
   - Secondary: `rgb(0.2, 0.4, 0.9)`
   - Accent: `rgb(0.9, 0.3, 0.5)`

2. **Blue Theme**
3. **Green Theme**
4. **Orange Theme**

### Customizing Themes

Edit `AppConfig.swift` to modify colors:

```swift
let primaryColor = Color(red: 0.5, green: 0.2, blue: 0.8)
let secondaryColor = Color(red: 0.2, green: 0.4, blue: 0.9)
let accentColor = Color(red: 0.9, green: 0.3, blue: 0.5)
```

---

## 🧪 Testing

### Running Tests

```bash
# Run all tests
xcodebuild test -scheme "Quran Aura" -destination 'platform=iOS Simulator,name=iPhone 15'

# Run specific test
xcodebuild test -scheme "Quran Aura" -only-testing:QuranAuraTests/NetworkServiceTests
```

### Test Coverage

> **Note**: Unit tests are planned for future development.

---

## 🚀 Deployment

### TestFlight Distribution

1. **Archive the App**
   - Product → Archive in Xcode
   - Wait for archive to complete

2. **Upload to App Store Connect**
   - Open Organizer (Window → Organizer)
   - Select your archive
   - Click "Distribute App"
   - Choose "App Store Connect"
   - Follow the upload wizard

3. **Configure TestFlight**
   - Log in to App Store Connect
   - Select your app
   - Go to TestFlight tab
   - Add internal/external testers
   - Submit for beta review

### App Store Release

1. Complete TestFlight testing
2. Prepare App Store listing (screenshots, description, keywords)
3. Submit for App Store review
4. Wait for approval (typically 1-3 days)
5. Release to App Store

---

## 👨‍💻 Development

### Requirements

- Swift 5.0+
- iOS 15.6+
- Xcode 14.0+
- macOS 13.0+

### Building from Source

```bash
# Clone the repository
git clone https://github.com/azozzalfiras/quran-aura.git

# Navigate to project directory
cd quran-aura

# Open in Xcode
open "Quran Aura.xcodeproj"

# Build and run (Cmd + R)
```

### Code Style

- Follow Swift API Design Guidelines
- Use SwiftLint for code formatting (optional)
- Write descriptive commit messages
- Comment complex logic
- Use meaningful variable names

### Git Workflow

```bash
# Create a feature branch
git checkout -b feature/your-feature-name

# Make your changes
git add .
git commit -m "Add: your feature description"

# Push to your fork
git push origin feature/your-feature-name

# Create a Pull Request on GitHub
```

---

## 🤝 Contributing

We welcome contributions from the community! Here's how you can help:

### Ways to Contribute

1. **Report Bugs**: Open an issue describing the bug
2. **Suggest Features**: Share your ideas for new features
3. **Submit Pull Requests**: Fix bugs or implement features
4. **Improve Documentation**: Help improve this README or code comments
5. **Translate**: Add support for new languages
6. **Design**: Contribute UI/UX improvements

### Contribution Guidelines

1. **Fork the Repository**
   ```bash
   git clone https://github.com/azozzalfiras/quran-aura.git
   ```

2. **Create a Branch**
   ```bash
   git checkout -b feature/amazing-feature
   ```

3. **Make Your Changes**
   - Write clean, documented code
   - Follow existing code style
   - Test your changes thoroughly

4. **Commit Your Changes**
   ```bash
   git commit -m "Add: amazing feature"
   ```

5. **Push to Your Fork**
   ```bash
   git push origin feature/amazing-feature
   ```

6. **Open a Pull Request**
   - Describe your changes clearly
   - Reference any related issues
   - Wait for review and feedback

### Code of Conduct

- Be respectful and inclusive
- Provide constructive feedback
- Focus on the code, not the person
- Help create a welcoming environment

---

## 📄 License

This project is licensed under the **MIT License** - see the [LICENSE](LICENSE) file for details.

```
MIT License

Copyright (c) 2025 Quran Aura

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

## 📞 Contact & Support

### Developer

- **Email**: dev@3zozz.com
- **Website**: https://quran-aura.fahmly.com

### Social Media

- **X (Twitter)**: [@QuranAura](https://twitter.com/dev_3zozz)
- **Instagram**: [@QuranAura](https://instagram.com/dev_3zozz)
- **TikTok**: [@QuranAura](https://tiktok.com/@dev_3zozz)
- **Snapchat**: [@QuranAura](https://snapchat.com/add/n.uf)
- **GitHub**: [github.com/QuranAura](https://github.com/azozzalfiras)

### Support

- **Issues**: [GitHub Issues](https://github.com/azozzalfiras/quran-aura/issues)
- **Discussions**: [GitHub Discussions](https://github.com/azozzalfiras/quran-aura/discussions)
- **Email**: dev@3zozz.com

---

## 🙏 Acknowledgments

- **Quran Audio**: Thanks to [mp3quran.net](https://mp3quran.net) for providing Quran audio files
- **Reciters**: Gratitude to all the Quran reciters whose beautiful recitations are featured
- **API Provider**: Thanks to the Quran Aura API team
- **Community**: Thanks to all contributors and users
- **Apple**: For providing excellent development tools and frameworks

---

## 📊 Project Status

### Current Version: 1.0.0 (Under Development)

### Roadmap

#### Version 1.0 (Current)
- [x] Basic audio playback
- [x] Reciter selection
- [x] Surah browsing
- [x] Favorites management
- [x] Search functionality
- [x] Duas integration
- [x] Settings screen
- [ ] Complete testing
- [ ] App Store submission

#### Version 1.1 (Planned)
- [ ] Offline mode (download Surahs)
- [ ] Playback speed control
- [ ] Sleep timer
- [ ] Repeat modes (single, all)
- [ ] Bookmarks
- [ ] Listening statistics

#### Version 1.2 (Future)
- [ ] Quran text display with audio sync
- [ ] Translations (multiple languages)
- [ ] Tafsir (interpretation)
- [ ] Prayer times
- [ ] Qibla direction
- [ ] Widget support

#### Version 2.0 (Vision)
- [ ] Apple Watch app
- [ ] CarPlay support
- [ ] Siri shortcuts
- [ ] Live Activities
- [ ] Social features (share progress)
- [ ] Community features

---

## 📈 Statistics

- **Total Surahs**: 114
- **Total Reciters**: 100+ (and growing)
- **Supported iOS Versions**: iOS 15.6+
- **Languages**: Arabic (primary), English (partial)
- **App Size**: ~15 MB (without cached audio)

---

## ⚠️ Disclaimer

This app is provided for educational and religious purposes. The Quran audio files are sourced from publicly available resources. If you are the copyright holder of any content and wish to have it removed, please contact us.

---

## 🌟 Star History

If you find this project useful, please consider giving it a star ⭐️ on GitHub!

---

<div align="center">

**Made with ❤️ for the Muslim Community**

**بارك الله فيكم**

[⬆ Back to Top](#-quran-aura---قرآن-أورا)

</div>
