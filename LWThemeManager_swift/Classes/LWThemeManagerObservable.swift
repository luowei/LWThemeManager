//
//  LWThemeManagerObservable.swift
//  LWThemeManager
//
//  SwiftUI support for theme manager
//  Copyright (c) 2015 luowei. All rights reserved.
//

import SwiftUI
import Combine

/// SwiftUI-compatible theme manager that publishes changes
@available(iOS 13.0, *)
public class LWThemeManagerObservable: ObservableObject {

    // MARK: - Singleton
    public static let shared = LWThemeManagerObservable()

    // MARK: - Published Properties
    @Published public private(set) var currentTheme: [String: Any] = [:]
    @Published public private(set) var currentName: String = "default"

    // MARK: - Private Properties
    private let themeManager = LWThemeManager.shared
    private var cancellables = Set<AnyCancellable>()

    private init() {
        refreshTheme()
    }

    // MARK: - Public Methods

    /// Refresh theme from underlying manager
    public func refreshTheme() {
        currentTheme = themeManager.theme
        currentName = themeManager.currentName
    }

    /// Update theme and notify observers
    /// - Parameter name: Theme name
    public func updateTheme(withName name: String) {
        themeManager.updateTheme(withName: name)
        refreshTheme()
    }

    /// Set theme value and notify observers
    /// - Parameters:
    ///   - value: The value to set
    ///   - key: The key
    public func setThemeValue(_ value: Any, forKey key: String) {
        themeManager.setThemeValue(value, forKey: key)
        refreshTheme()
    }

    /// Get float value from theme
    public func floatValue(forKey key: String) -> Float {
        return themeManager.floatValue(forKey: key)
    }

    /// Get string value from theme
    public func stringValue(forKey key: String) -> String? {
        return themeManager.stringValue(forKey: key)
    }

    /// Get Color value from theme (SwiftUI Color)
    public func color(forKey key: String) -> Color? {
        guard let uiColor = themeManager.colorValue(forKey: key) else {
            return nil
        }
        return Color(uiColor)
    }

    /// Get UIColor value from theme
    public func uiColor(forKey key: String) -> UIColor? {
        return themeManager.colorValue(forKey: key)
    }

    /// Set float value
    public func setFloatValue(_ value: Float, forKey key: String) {
        themeManager.setFloatValue(value, forKey: key)
        refreshTheme()
    }

    /// Set color value (SwiftUI Color)
    public func setColor(_ color: Color, forKey key: String) {
        let uiColor = UIColor(color)
        themeManager.setColorValue(uiColor, forKey: key)
        refreshTheme()
    }

    /// Set UIColor value
    public func setUIColor(_ color: UIColor, forKey key: String) {
        themeManager.setColorValue(color, forKey: key)
        refreshTheme()
    }

    /// Copy a new theme from current theme
    @discardableResult
    public func copyNewTheme(withName name: String) -> Bool {
        let success = themeManager.copyNewTheme(withName: name)
        if success {
            refreshTheme()
        }
        return success
    }

    /// Remove theme by name
    public func removeTheme(withName name: String?) {
        themeManager.removeTheme(withName: name)
        refreshTheme()
    }

    /// Recover default theme settings
    public func recoverDefaultTheme() {
        themeManager.recoverDefaultTheme()
        refreshTheme()
    }
}

// MARK: - SwiftUI Environment Support
@available(iOS 13.0, *)
public extension EnvironmentValues {
    var themeManager: LWThemeManagerObservable {
        get { self[ThemeManagerKey.self] }
        set { self[ThemeManagerKey.self] = newValue }
    }
}

@available(iOS 13.0, *)
private struct ThemeManagerKey: EnvironmentKey {
    static let defaultValue = LWThemeManagerObservable.shared
}

// MARK: - SwiftUI View Extension
@available(iOS 13.0, *)
public extension View {
    /// Inject theme manager into environment
    func themeManager(_ manager: LWThemeManagerObservable = .shared) -> some View {
        self.environment(\.themeManager, manager)
    }
}
