//
//  LWThemeManager.swift
//  LWThemeManager
//
//  Swift version of theme manager
//  Copyright (c) 2015 luowei. All rights reserved.
//

import UIKit

// MARK: - Constants
public let KeyTheme = "Key_Theme"

// MARK: - Theme Value Helpers
public extension LWThemeManager {

    /// Get float value from theme by key
    func floatValue(forKey key: String) -> Float {
        return (theme[key] as? NSNumber)?.floatValue ?? 0.0
    }

    /// Get string value from theme by key
    func stringValue(forKey key: String) -> String? {
        return theme[key] as? String
    }

    /// Get UIColor value from theme by key
    func colorValue(forKey key: String) -> UIColor? {
        guard let rgbaString = theme[key] as? String else { return nil }
        return UIColor.theme_color(withRGBAString: rgbaString)
    }

    /// Get CGColor value from theme by key
    func cgColorValue(forKey key: String) -> CGColor? {
        return colorValue(forKey: key)?.cgColor
    }

    /// Set float value to theme
    func setFloatValue(_ value: Float, forKey key: String) {
        setThemeValue(NSNumber(value: value), forKey: key)
    }

    /// Set color value to theme
    func setColorValue(_ color: UIColor, forKey key: String) {
        if let rgbaString = color.theme_rgbaString() {
            setThemeValue(rgbaString, forKey: key)
        }
    }

    /// Set CGColor value to theme
    func setCGColorValue(_ color: CGColor, forKey key: String) {
        if let rgbaString = UIColor(cgColor: color).theme_rgbaString() {
            setThemeValue(rgbaString, forKey: key)
        }
    }
}

// MARK: - LWThemeManager
public class LWThemeManager {

    // MARK: - Singleton
    public static let shared = LWThemeManager()

    // MARK: - Properties
    private var _theme: [String: Any]?
    private var _currentName: String?

    private static let themesDirectory = "themes"

    private init() {}

    // MARK: - Public Methods

    /// Get path in bundle with file name
    /// - Parameter fileName: The file name
    /// - Returns: Full path in bundle
    public static func pathInBundle(withFileName fileName: String) -> String {
        return bundlePath(named: fileName, ofBundle: "KeyboardTheme.bundle")
    }

    /// Get current theme name
    public var currentName: String {
        return _currentName ?? "default"
    }

    /// Get current theme dictionary
    public var theme: [String: Any] {
        if let currentName = _currentName, let theme = _theme {
            return theme
        }
        updateTheme(withName: _currentName ?? "default")
        return _theme ?? [:]
    }

    /// Set theme value for key and save to file
    /// - Parameters:
    ///   - value: The value to set
    ///   - key: The key
    public func setThemeValue(_ value: Any, forKey key: String) {
        var currentTheme = theme
        currentTheme[key] = value
        _theme = currentTheme

        // Write theme data to document directory
        let plistName = "\(_currentName ?? "default")Theme.plist"
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let themePlistPath = "\(documentsPath)/\(Self.themesDirectory)/\(_currentName ?? "default")/\(plistName)"

        let dict = currentTheme as NSDictionary
        dict.write(toFile: themePlistPath, atomically: true)
    }

    /// Update specific theme file's key-value
    /// - Parameters:
    ///   - name: Theme name (nil to use current theme)
    ///   - value: The value to set
    ///   - key: The key
    public func updateTheme(withName name: String?, value: Any, forKey key: String) {
        let themeName = name ?? _currentName ?? "default"
        let plistName = "\(themeName)Theme.plist"

        // Check if file exists
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let themePlistPath = "\(documentsPath)/\(Self.themesDirectory)/\(themeName)/\(plistName)"

        guard FileManager.default.fileExists(atPath: themePlistPath) else {
            return
        }

        // Load, update and save
        if var theme = NSDictionary(contentsOfFile: themePlistPath) as? [String: Any] {
            theme[key] = value
            let dict = theme as NSDictionary
            dict.write(toFile: themePlistPath, atomically: true)
        }
    }

    /// Remove theme by name
    /// - Parameter themeName: The theme name to remove
    public func removeTheme(withName themeName: String?) {
        guard let themeName = themeName else { return }

        let plistName = "\(themeName)Theme.plist"
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let themePlistPath = "\(documentsPath)/\(Self.themesDirectory)/\(themeName)/\(plistName)"

        guard FileManager.default.fileExists(atPath: themePlistPath) else {
            return
        }

        // Delete
        try? FileManager.default.removeItem(atPath: themePlistPath)
    }

    /// Copy a new theme from current theme
    /// - Parameter name: New theme name
    /// - Returns: Success or failure
    @discardableResult
    public func copyNewTheme(withName name: String) -> Bool {
        // Check if current plist exists, use default if not
        let plistName = "\(_currentName ?? "default")Theme.plist"
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        var currentPlistPath = "\(documentsPath)/\(Self.themesDirectory)/\(_currentName ?? "default")/\(plistName)"

        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: currentPlistPath) {
            currentPlistPath = Self.pathInBundle(withFileName: plistName)
        }

        // Create name subdirectory
        let nameDirPath = "\(documentsPath)/\(Self.themesDirectory)/\(name)"
        if !fileManager.fileExists(atPath: nameDirPath) {
            try? fileManager.createDirectory(atPath: nameDirPath, withIntermediateDirectories: true)
        }

        // Copy
        let nameFilePath = "\(nameDirPath)/\(name)Theme.plist"
        do {
            try fileManager.copyItem(atPath: currentPlistPath, toPath: nameFilePath)
            return true
        } catch {
            return false
        }
    }

    /// Recover default theme settings
    public func recoverDefaultTheme() {
        let plistName = "\(_currentName ?? "default")Theme.plist"
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let nameDirPath = "\(documentsPath)/\(Self.themesDirectory)/\(_currentName ?? "default")"
        let docPlistPath = "\(nameDirPath)/\(plistName)"
        let bundlePlistPath = Self.pathInBundle(withFileName: plistName)

        let fileManager = FileManager.default

        // Remove existing if exists
        if fileManager.fileExists(atPath: docPlistPath) {
            try? fileManager.removeItem(atPath: docPlistPath)
        }

        // Copy from bundle
        do {
            try fileManager.copyItem(atPath: bundlePlistPath, toPath: docPlistPath)
            _theme = NSDictionary(contentsOfFile: docPlistPath) as? [String: Any]
        } catch {
            _theme = NSDictionary(contentsOfFile: bundlePlistPath) as? [String: Any]
        }
    }

    /// Update theme with name
    /// - Parameter name: Theme name
    public func updateTheme(withName name: String) {
        // If theme setting hasn't changed and theme dictionary is not empty
        if name == _currentName && _theme != nil {
            return
        }

        // Build paths
        let themeName = name.isEmpty ? "default" : name
        let plistName = "\(themeName)Theme.plist"
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let nameDirPath = "\(documentsPath)/\(Self.themesDirectory)/\(themeName)"
        let docPlistPath = "\(nameDirPath)/\(plistName)"
        let bundlePlistPath = Self.pathInBundle(withFileName: plistName)
        let defaultPlistPath = Self.pathInBundle(withFileName: "defaultTheme.plist")

        let fileManager = FileManager.default

        // Check if exists in documents
        if !fileManager.fileExists(atPath: docPlistPath) {
            // Create subdirectory
            if !fileManager.fileExists(atPath: nameDirPath) {
                try? fileManager.createDirectory(atPath: nameDirPath, withIntermediateDirectories: true)
            }

            // Copy bundle file to documents
            if fileManager.fileExists(atPath: docPlistPath) {
                _theme = NSDictionary(contentsOfFile: docPlistPath) as? [String: Any]
            } else {
                // Check if bundle plist exists
                if fileManager.fileExists(atPath: bundlePlistPath) {
                    do {
                        try fileManager.copyItem(atPath: bundlePlistPath, toPath: docPlistPath)
                        _theme = NSDictionary(contentsOfFile: docPlistPath) as? [String: Any]
                    } catch {
                        _theme = NSDictionary(contentsOfFile: bundlePlistPath) as? [String: Any]
                    }
                } else {
                    _theme = NSDictionary(contentsOfFile: defaultPlistPath) as? [String: Any]
                }
            }
        } else {
            _theme = NSDictionary(contentsOfFile: docPlistPath) as? [String: Any]
        }

        assert(_theme != nil, "Error: Theme configuration cannot be empty")

        _currentName = themeName
    }

    // MARK: - Private Methods

    private static func bundlePath(named name: String, ofBundle bundleName: String) -> String {
        let resourcePath = Bundle.main.resourcePath ?? ""
        let bundlePath = (resourcePath as NSString).appendingPathComponent(bundleName)
        let filePath = (bundlePath as NSString).appendingPathComponent(name)
        return filePath
    }
}
