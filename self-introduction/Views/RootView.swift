import SwiftUI

struct RootView: View {
    @EnvironmentObject var authVM: AuthViewModel

    var body: some View {
        Group {
            if authVM.isSignedIn { MainTabView() }
            else { SignInView() }
        }
        .task { if !authVM.isSignedIn { await authVM.signIn() } }
    }
}
