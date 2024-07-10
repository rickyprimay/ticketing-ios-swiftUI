//
//  CustomTF.swift
//  loginUi
//
//  Created by Ricky Primayuda Putra on 09/07/24.
//

import SwiftUI

struct CustomTF: View {
    var sfIcon: String
    var iconTintt: Color = .gray
    var hint: String
    var isPassword: Bool = false
    @Binding var value: String
    @State private var showPassword: Bool = false

    var body: some View {
        HStack(alignment: .top, spacing: 8, content: {
            Image(systemName: sfIcon)
                .foregroundStyle(iconTintt)
                .frame(width: 30)
            
            VStack(alignment: .leading, spacing: 8, content: {
                if isPassword && !showPassword {
                    SecureField(hint, text: $value)
                } else {
                    TextField(hint, text: $value)
                }
                
                Divider()
            })
            .overlay(alignment: .trailing) {
                if isPassword{
                    Button(action: {
                        withAnimation {
                            showPassword.toggle()
                        }
                    }) {
                        Image(systemName: showPassword ? "eye.slash" : "eye")
                            .foregroundStyle(.gray)
                            .padding(10)
                            .contentShape(Rectangle())
                    }
                }
            }
        })
    }
}
