//
//  LWThemeManager+Examples.swift
//  LWThemeManager
//
//  Example usage of LWThemeManager in Swift
//

#if DEBUG
import UIKit
import SwiftUI

// MARK: - UIKit Usage Examples
public extension LWThemeManager {

    /// Example: Basic UIKit usage
    static func exampleBasicUsage() {
        let manager = LWThemeManager.shared

        // Get values from theme
        let fontSize = manager.floatValue(forKey: "fontSize")
        let backgroundColor = manager.colorValue(forKey: "backgroundColor")

        // Set values to theme
        manager.setFloatValue(14.0, forKey: "fontSize")
        manager.setColorValue(.blue, forKey: "backgroundColor")

        // Update theme
        manager.updateTheme(withName: "dark")
    }

    /// Example: Theme management
    static func exampleThemeManagement() {
        let manager = LWThemeManager.shared

        // Copy current theme to create a new one
        manager.copyNewTheme(withName: "myCustomTheme")

        // Switch to the new theme
        manager.updateTheme(withName: "myCustomTheme")

        // Modify the new theme
        manager.setColorValue(.red, forKey: "accentColor")

        // Remove a theme
        manager.removeTheme(withName: "oldTheme")

        // Recover default theme
        manager.recoverDefaultTheme()
    }
}

// MARK: - SwiftUI Usage Examples
@available(iOS 13.0, *)
public extension LWThemeManagerObservable {

    /// Example: SwiftUI view with theme
    struct ExampleView: View {
        @ObservedObject var themeManager = LWThemeManagerObservable.shared

        var body: some View {
            VStack(spacing: 20) {
                Text("Current Theme: \(themeManager.currentName)")
                    .foregroundColor(themeManager.color(forKey: "textColor") ?? .primary)

                Button("Switch to Dark Theme") {
                    themeManager.updateTheme(withName: "dark")
                }

                Button("Switch to Light Theme") {
                    themeManager.updateTheme(withName: "light")
                }

                ColorPicker("Background Color",
                           selection: Binding(
                               get: {
                                   Color(themeManager.uiColor(forKey: "backgroundColor") ?? .white)
                               },
                               set: { color in
                                   themeManager.setColor(color, forKey: "backgroundColor")
                               }
                           ))
            }
            .padding()
        }
    }

    /// Example: Using Environment
    struct ExampleEnvironmentView: View {
        @Environment(\.themeManager) var themeManager

        var body: some View {
            Text("Themed Text")
                .foregroundColor(themeManager.color(forKey: "textColor") ?? .primary)
        }
    }

    /// Example: Theme manager operations
    static func exampleOperations() {
        let manager = LWThemeManagerObservable.shared

        // Create a new theme
        manager.copyNewTheme(withName: "custom")

        // Switch to it
        manager.updateTheme(withName: "custom")

        // Modify theme values
        manager.setColor(.blue, forKey: "primaryColor")
        manager.setFloatValue(16.0, forKey: "fontSize")

        // The UI will automatically update because of @Published properties
    }
}

#endif
