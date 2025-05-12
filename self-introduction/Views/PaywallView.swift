import SwiftUI

struct PaywallView: View {
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        VStack(spacing: 24) {
            Text("Pro で生成無制限！").font(.title2)
            Button("¥480 / 月で購読する") {
                // TODO: StoreKit2 購読処理
            }
            .buttonStyle(.borderedProminent)
            Button("閉じる", role: .cancel) { dismiss() }
        }
        .padding()
    }
}
