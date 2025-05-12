import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            ScenarioListView().tabItem { Label("シナリオ", systemImage: "list.bullet") }
            HistoryView().tabItem { Label("履歴", systemImage: "clock") }
            SettingsView().tabItem { Label("設定", systemImage: "gear") }
        }
    }
}
