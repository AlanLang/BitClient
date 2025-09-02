# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

BitClient is an iOS client application for qBittorrent written in SwiftUI. It allows users to manage their qBittorrent server remotely from iOS devices.

## Build Commands

- **Build the project**: Use Xcode to build the project, or run `./build.sh` to create an IPA file for distribution
- **The build script** (`build.sh`) copies the built app from Xcode's DerivedData and packages it into an IPA file

## Code Architecture

### Core Structure
- **MVVM Pattern**: The app follows Model-View-ViewModel architecture
  - Models: Data structures in `Model/` directory (BitService, Maindata, PreferenceData)
  - Views: SwiftUI views in `View/` directory organized by feature
  - ViewModels: Business logic in `ViewModel/` directory

### Key Components

#### State Management
- `AppState.swift`: Global app state using `@ObservableObject`, manages login status and user credentials
- `BitClientAppViewModel.swift`: Main view model that handles torrent data polling with a 1-second timer

#### Networking Layer
- `NetworkManager.swift`: Core networking using Alamofire, handles GET/POST requests and file uploads
- `NetworkApi.swift`: qBittorrent Web API wrapper with methods for login, data fetching, and torrent management
- `BitService.swift`: Service layer that coordinates between UI and network layer

#### View Hierarchy
- Main tabs: Home (torrent list), Service (server settings), About
- Navigation bars are separate components for each tab
- Specialized tip views for empty states and offline conditions

#### Data Models
- `Maindata.swift`: Auto-generated from JSON schema, represents qBittorrent's main data response
- Models include server state, torrent information, and categories

### Dependencies
- **Alamofire**: HTTP networking
- **SPIndicator**: Toast notifications
- **LoadingButton**: UI component for loading states
- **SVGKit**: SVG rendering support

### Localization
- Multi-language support in `Resources/Localization/`
- Supported languages: English, Russian, Simplified Chinese, Traditional Chinese
- String constants defined in `Constants.swift`

### Key Patterns
- Uses UserDefaults for persistent storage of server credentials
- Timer-based polling for real-time torrent updates
- Result-based error handling throughout the networking layer
- Environment objects for state sharing between views