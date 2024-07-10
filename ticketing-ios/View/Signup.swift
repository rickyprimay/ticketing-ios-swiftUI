//
//  Signup.swift
//  loginUi
//
//  Created by Ricky Primayuda Putra on 09/07/24.
//

import SwiftUI

struct SignUp: View {
    @Binding var showSignup: Bool

    @State private var emailID: String = ""
    @State private var name: String = ""
    @State private var password: String = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 15, content: {
            Button(action: {
                showSignup = false
            }, label: {
                Image(systemName: "arrow.left")
                    .font(.title2)
                    .foregroundStyle(.gray)
            })
            
            Spacer(minLength: 0)
            
            Text("SignUp")
                .font(.largeTitle)
                .fontWeight(.heavy)
            
            Text("Please sign up to continue")
                .font(.callout)
                .fontWeight(.semibold)
                .foregroundStyle(.gray)
                .padding(.top, -5)
            
            VStack(spacing: 25){
                CustomTF(sfIcon: "person", hint: "Name", value: $name)
                CustomTF(sfIcon: "at", hint: "Email ID", value: $emailID)
                CustomTF(sfIcon: "lock", hint: "Password",isPassword: true, value: $password) .padding(.top, 5)
                
                //Login Button
                GradientButton(title: "Continue", icon: "arrow.right"){
                    
                }
                .hSpacing(.trailing)
                .disableWithOpacity(emailID.isEmpty || password.isEmpty || name.isEmpty)
            }
            .padding(.top, 20)
            
            Spacer(minLength: 0)
            
            HStack(spacing: 6){
                Text("Allready Have an account?")
                    .foregroundStyle(.gray)
                Button("Login"){
                    showSignup = false
                }
                .fontWeight(.bold)
                .tint(.appYellow)
            }
            .font(.callout)
            .hSpacing()
        })
        .padding(.vertical, 15)
        .padding(.horizontal, 25)
        .toolbar(.hidden, for: .navigationBar)
    }
}


#Preview {
    ContentView()
}
