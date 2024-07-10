//
//  ContentView.swift
//  loginUi
//
//  Created by Ricky Primayuda Putra on 09/07/24.
//

import SwiftUI

struct ContentView: View {
    @State private var showSignup: Bool = false
    var body: some View {
        NavigationStack {
            Login(showSignup: $showSignup)
                .navigationDestination(isPresented: $showSignup) {
                    SignUp(showSignup: $showSignup)
                }
        }
        .overlay{
            if #available(iOS 17, *){
                CircleVIew()
                    .animation(.smooth(duration: 0.45, extraBounce: 0), value: showSignup)
            } else {
                CircleVIew()
                    .animation(.easeInOut(duration: 0.3), value: showSignup)
            }
        }
    }
    
    @ViewBuilder
    func CircleVIew() -> some View {
        Circle()
            .fill(.linearGradient(colors: [.appYellow, .orange, .red], startPoint: .top, endPoint: .bottom))
            .frame(width: 200, height: 200)
            .offset(x: showSignup ? 90 : -90 , y: -90)
            .blur(radius: 15)
            .hSpacing(showSignup ? .trailing : .leading)
            .vSpacing(.top)
    }
}

#Preview {
    ContentView()
}
