import SwiftUI

struct SignInView: View {
    @EnvironmentObject var authVM: AuthViewModel
    var body: some View {
        VStack(spacing: 24) {
            Text("自己紹介ジェネレーターへようこそ").font(.title)
            Button("Apple でサインイン") { Task { await authVM.signIn() } }
                .buttonStyle(.borderedProminent)
        }.padding()
    }
}
