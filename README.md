# Tempoo

A SwiftUI-based iOS application for tracking goals and habits with beautiful circular progress visualizations.

## Overview

Tempoo helps you track your goals with an intuitive visual interface featuring circular progress rings. Each ring represents a goal with a specific target count and deadline, allowing you to monitor both your progress and time remaining at a glance.

## Features

- **Visual Progress Tracking**: Dual-ring visualization showing both completion progress (inner ring) and time elapsed (outer ring)
- **Goal Management**: Create, edit, and manage multiple goals with customizable targets and timelines
- **Activity Logging**: Record completions with timestamps and optional notes
- **Progress Analytics**: 
  - Timeline charts showing your pace over time
  - Pace index indicating whether you're ahead or behind schedule
  - Detailed completion history with date/time stamps
- **Modern UI**: Built with SwiftUI featuring a clean, intuitive interface with custom color themes

## Architecture

The project follows a modular architecture with separation of concerns:

- **Tempoo** (Main App): Application entry point and coordination
- **TempooCore**: Core domain models and business logic
- **TempooResources**: Assets and localizations
- **TempooUI**: Reusable UI components and styling
- **Feature Modules**:
  - **Home**: Main navigation and ring list
  - **Ring**: Ring detail view and management
  - **Sheet**: Modal presentation layer

### Key Components

- **Ring**: Represents a goal with target count, dates, and completion logs
- **RingLog**: Individual completion records with timestamps
- **RingGraph**: Custom circular progress visualization component
- **TimelineChart**: Visual representation of progress over time
- **Repository Pattern**: Data persistence and management

## Technical Stack

- **Language**: Swift
- **UI Framework**: SwiftUI
- **Architecture**: MVVM (Model-View-ViewModel)
- **Logging**: SwiftyBeaver for structured logging
- **Supported Platforms**: iOS

## Project Structure

```
Tempoo/
├── App/
│   ├── LoopLifeApp.swift      # App entry point
│   ├── AppView.swift           # Root view
│   └── AppViewModel.swift      # Root view model
├── Features/
│   ├── Home/                   # Home screen module
│   ├── Ring/                   # Ring detail module
│   └── Sheet/                  # Modal presentations
├── TempooCore/                 # Core business logic
│   ├── Models/
│   │   ├── Ring.swift
│   │   └── RingLog.swift
│   └── Repositories/
├── TempooUI/                   # Reusable UI components
│   ├── Components/
│   │   ├── RingGraph.swift
│   │   └── TimelineChart.swift
│   └── Styling/
└── TempooResources/           # Assets and localizations
```

## Key Concepts

### Ring Progress System

Each ring tracks two key metrics:

1. **Progress Ratio** (Inner Ring): Completed count / Target count
   - Visualized in gradient colors (mint green to blue)
   - Indicates how much of your goal is complete

2. **Time Ratio** (Outer Ring): Days elapsed / Total days
   - Visualized in gradient colors (red to magenta)
   - Indicates how much time has passed

### Pace Index

The pace index is a calculated metric that shows whether you're on track:
- `Pace Index = (Progress Ratio / Time Ratio) × 100`
- **> 100%**: Ahead of schedule
- **= 100%**: On track
- **< 100%**: Behind schedule

## Usage

### Creating a Ring

1. Tap the add button to create a new ring
2. Enter a name for your goal
3. Set your target count (how many times you want to complete it)
4. Choose start and end dates
5. Save to begin tracking

### Logging Progress

1. Open a ring to view its details
2. Tap the ring graph or add log button
3. Record the completion with an optional note
4. The ring automatically updates to reflect your progress

### Viewing Analytics

- **Ring Detail View**: Shows comprehensive statistics including:
  - Current progress and time remaining
  - Start and end dates
  - Timeline chart with pace visualization
  - Complete log history with dates and times
  - Pace index to track performance

## Development

### Requirements

- Xcode 15.0 or later
- iOS 17.0 or later
- Swift 5.9 or later

### Dependencies

- **SwiftyBeaver**: Logging framework
- Custom internal frameworks (TempooCore, TempooUI, etc.)

### Debug Logging

The app uses SwiftyBeaver for structured logging with different levels:
- 📝 Verbose: Detailed debug information (debug builds only)
- 🐛 Debug: General debugging messages (debug builds only)
- ℹ️ Info: Informational messages
- ⚠️ Warning: Warning messages
- ❌ Error: Error messages

## License

Copyright © 2026 Freedom Martin, s.r.o. All rights reserved.

## Author

Martin Svoboda
