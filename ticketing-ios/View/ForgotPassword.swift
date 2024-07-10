//
//  ForgotPassword.swift
//  loginUi
//
//  Created by Ricky Primayuda Putra on 09/07/24.
//

import SwiftUI

struct ForgotPassword: View {
    @Binding var showResetView: Bool

    @State private var emailID: String = ""
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        VStack(alignment: .leading, spacing: 15, content: {
            Button(action: {
                dismiss()
            }, label: {
                Image(systemName: "arrow.left")
                    .font(.title2)
                    .foregroundStyle(.gray)
            })
            
            .padding(.top, 10)
            
            Text("Forgot Password")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .padding(.top, 5)
            
            Text("Please enter your Email ID so that we can send the reset link.")
                .font(.callout)
                .fontWeight(.semibold)
                .foregroundStyle(.gray)
                .padding(.top, -5)
            
            VStack(spacing: 25){
                CustomTF(sfIcon: "at", hint: "Email ID", value: $emailID)
                
                //Login Button
                GradientButton(title: "Send Link", icon: "arrow.right"){
                    Task {
                        dismiss()
                        try? await Task.sleep(for: .seconds(0))
                        showResetView = true
                    }
                }
                .hSpacing(.trailing)
                .disableWithOpacity(emailID.isEmpty)
            }
            .padding(.top, 20)
            
            Spacer(minLength: 0)
            
        })
        .padding(.vertical, 15)
        .padding(.horizontal, 25)
        .interactiveDismissDisabled()
    }
}


#Preview {
    ContentView()
}
