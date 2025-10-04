#
# Be sure to run `pod lib lint LWThemeManager_swift.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'LWThemeManager_swift'
  s.version          = '1.0.0'
  s.summary          = 'Swift版本的万能输入法主题管理组件'

  s.description      = <<-DESC
LWThemeManager_swift 是 LWThemeManager 的 Swift 版本实现。
提供了现代化的 Swift API 用于主题管理，支持 SwiftUI 的响应式编程。
包含 LWThemeManager、LWThemeExtension 和 LWThemeManagerObservable。
                       DESC

  s.homepage         = 'https://github.com/luowei/LWThemeManager'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'luowei' => 'luowei@wodedata.com' }
  s.source           = { :git => 'https://github.com/luowei/LWThemeManager.git', :tag => "swift-#{s.version}" }

  s.ios.deployment_target = '11.0'
  s.swift_version = '5.0'

  s.source_files = 'LWThemeManager_swift/Classes/**/*.swift'

  s.resources = [
      'LWThemeManager/Assets/KeyboardTheme.bundle'
  ]

  s.frameworks = 'UIKit'
end
