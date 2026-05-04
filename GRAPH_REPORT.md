# Graph Report - /Users/luowei/projects/libs/LWThemeManager  (2026-05-04)

## Corpus Check
- Corpus is ~11,646 words - fits in a single context window. You may not need a graph.

## Summary
- 91 nodes · 99 edges · 8 communities detected
- Extraction: 100% EXTRACTED · 0% INFERRED · 0% AMBIGUOUS
- Token cost: 0 input · 0 output

## Community Hubs (Navigation)
- [[_COMMUNITY_Community 0|Community 0]]
- [[_COMMUNITY_Community 1|Community 1]]
- [[_COMMUNITY_Community 2|Community 2]]
- [[_COMMUNITY_Community 3|Community 3]]
- [[_COMMUNITY_Community 4|Community 4]]
- [[_COMMUNITY_Community 5|Community 5]]
- [[_COMMUNITY_Community 7|Community 7]]
- [[_COMMUNITY_Community 9|Community 9]]

## God Nodes (most connected - your core abstractions)
1. `LWThemeManager` - 27 edges
2. `LWThemeManagerObservable` - 16 edges
3. `UIColor` - 7 edges
4. `LWAppDelegate` - 7 edges
5. `Tests` - 4 edges
6. `LWViewController` - 3 edges
7. `CGColor` - 3 edges
8. `LWThemeManager` - 3 edges
9. `ThemeManagerKey` - 2 edges
10. `View` - 2 edges

## Surprising Connections (you probably didn't know these)
- None detected - all connections are within the same source files.

## Communities (16 total, 1 thin omitted)

### Community 0 - "Community 0"
Cohesion: 0.12
Nodes (11): LWThemeManager, -bundlePathNamedofBundle, -copyANewThemeWithName, -currentName, -pathInBundleWithFileName, -removeThemeWithName, -setThemeValueforKey, -sharedInstance (+3 more)

### Community 2 - "Community 2"
Cohesion: 0.22
Nodes (4): CGColor, UIColor, -theme_colorWithRGBAString, -theme_rgbaStringFromUIColor

### Community 3 - "Community 3"
Cohesion: 0.25
Nodes (5): ExampleEnvironmentView, ExampleView, LWThemeManager, LWThemeManagerObservable, View

### Community 4 - "Community 4"
Cohesion: 0.25
Nodes (7): LWAppDelegate, -applicationDidBecomeActive, -applicationDidEnterBackground, -applicationdidFinishLaunchingWithOptions, -applicationWillEnterForeground, -applicationWillResignActive, -applicationWillTerminate

### Community 5 - "Community 5"
Cohesion: 0.33
Nodes (4): EnvironmentValues, ThemeManagerKey, View, EnvironmentKey

### Community 7 - "Community 7"
Cohesion: 0.4
Nodes (4): Tests, -setUp, -tearDown, -testExample

### Community 9 - "Community 9"
Cohesion: 0.5
Nodes (3): LWViewController, -didReceiveMemoryWarning, -viewDidLoad

## Knowledge Gaps
- **24 isolated node(s):** `-sharedInstance`, `-pathInBundleWithFileName`, `-bundlePathNamedofBundle`, `-currentName`, `-theme` (+19 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **1 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `LWThemeManager` connect `Community 0` to `Community 8`, `Community 10`, `Community 6`?**
  _High betweenness centrality (0.085) - this node is a cross-community bridge._
- **Why does `LWThemeManagerObservable` connect `Community 1` to `Community 5`?**
  _High betweenness centrality (0.042) - this node is a cross-community bridge._
- **What connects `-sharedInstance`, `-pathInBundleWithFileName`, `-bundlePathNamedofBundle` to the rest of the system?**
  _24 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `Community 0` be split into smaller, more focused modules?**
  _Cohesion score 0.12 - nodes in this community are weakly interconnected._