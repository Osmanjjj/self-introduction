import SwiftUI

struct SignInView: View {
    @EnvironmentObject var authVM: AuthViewModel
    @State private var email = ""
    @State private var password = ""
    @State private var isNewUser = false
    @State private var errorMsg: String?

    var body: some View {
        VStack(spacing: 24) {
            Text("自己紹介ジェネレーターへようこそ")
                .font(.title2)
                .multilineTextAlignment(.center)

            TextField("メールアドレス", text: $email)
                .textContentType(.emailAddress)
                .keyboardType(.emailAddress)
                .textFieldStyle(.roundedBorder)
                .autocapitalization(.none)

            SecureField("パスワード (6文字以上)", text: $password)
                .textFieldStyle(.roundedBorder)

            if let msg = errorMsg {
                Text(msg).foregroundColor(.red).font(.footnote)
            }

            Button(isNewUser ? "登録してログイン" : "ログイン") {
                Task {
                    errorMsg = nil
                    do {
                        if isNewUser {
                            try await authVM.signUp(email: email, password: password)
                        } else {
                            try await authVM.signIn(email: email, password: password)
                        }
                    } catch {
                        errorMsg = error.localizedDescription
                    }
                }
            }
            .buttonStyle(.borderedProminent)
            .disabled(email.isEmpty || password.count < 6)

            Toggle("新規登録", isOn: $isNewUser)
                .toggleStyle(.switch)
        }
        .padding()
    }
}
