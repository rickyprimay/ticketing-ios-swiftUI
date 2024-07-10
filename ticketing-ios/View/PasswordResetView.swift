//  PasswordResetView.swift
//  loginUi
//
//  Created by Ricky Primayuda Putra on 09/07/24.
//

import SwiftUI

struct PasswordResetView: View {
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Button(action: {
                dismiss()
            }, label: {
                Image(systemName: "xmark")
                    .font(.title2)
                    .foregroundStyle(.gray)
            })
            .padding(.top, 10)

            Text("Forgot Password")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .padding(.top, 5)

            Text("Please enter your new password and confirm it.")
                .font(.callout)
                .fontWeight(.semibold)
                .foregroundStyle(.gray)
                .padding(.top, -5)

            VStack(spacing: 25) {
                CustomTF(sfIcon: "lock", hint: "Password", value: $password)
                CustomTF(sfIcon: "lock", hint: "Confirm Password", value: $confirmPassword)
                    .padding(.top, 5)

                // Send Link Button
                GradientButton(title: "Send Link", icon: "arrow.right") {
                    // Action to send the reset link
                }
                .hSpacing(.trailing)
                .disableWithOpacity(password.isEmpty || confirmPassword.isEmpty)
            }
            .padding(.top, 20)

            Spacer(minLength: 0)
        }
        .padding(.vertical, 15)
        .padding(.horizontal, 25)
        .interactiveDismissDisabled()
    }
}

#Preview {
    ContentView()
}
