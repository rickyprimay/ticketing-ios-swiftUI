//
//  Login.swift
//  loginUi
//
//  Created by Ricky Primayuda Putra on 09/07/24.
//

import SwiftUI

extension Color {
    static let appYellow = Color(red: 1.0, green: 0.8, blue: 0.0)
}

struct Login: View {
    @Binding var showSignup: Bool

    @State private var emailID: String = ""
    @State private var password: String = ""
    @State private var showForgotPasswordView: Bool = false
    @State private var showResetView: Bool = false
    @State private var askOTP: Bool = false
    @State private var otpText: String = ""
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Spacer()

            Text("Login")
                .font(.largeTitle)
                .fontWeight(.heavy)

            Text("Please sign in to continue")
                .font(.callout)
                .fontWeight(.semibold)
                .foregroundColor(.gray)
                .padding(.top, -5)

            VStack(spacing: 25){
                            CustomTF(sfIcon: "at", hint: "Email ID", value: $emailID)
                            CustomTF(sfIcon: "lock", hint: "Password",isPassword: true, value: $password) .padding(.top, 5)
                            
                            Button("Forgot Password?"){
                                showForgotPasswordView.toggle()
                            }
                            .font(.callout)
                            .fontWeight(.heavy)
                            .tint(.appYellow)
                            .hSpacing(.trailing)
                            
                            //Login Button
                            GradientButton(title: "Login", icon: "arrow.right"){
                                login()
                            }
                            .hSpacing(.trailing)
                            .disableWithOpacity(emailID.isEmpty || password.isEmpty)
                        }
                        .padding(.top, 20)
                        
                        Spacer(minLength: 0)

            HStack(spacing: 6) {
                Text("Don't Have an account?")
                    .foregroundColor(.gray)

                Button("Sign Up") {
                    showSignup.toggle()
                }
                .fontWeight(.bold)
                .foregroundColor(.appYellow)
            }
            .font(.callout)
            .padding(.bottom)
        }
        .padding(.vertical, 15)
        .padding(.horizontal, 25)
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
        .sheet(isPresented: $askOTP, content: {
            OTPView(otpText: $otpText, verifyOtp: {
                // Handle OTP verification
                verifyOTP()
            })
        })
    }

    func login() {
        guard let url = URL(string: "https://b8fc-182-253-109-104.ngrok-free.app/api/auth/login") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: String] = ["email": emailID, "password": password]

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        } catch {
            print("Failed to encode JSON")
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Network error: \(String(describing: error))")
                DispatchQueue.main.async {
                    alertMessage = "Network error: \(String(describing: error?.localizedDescription))"
                    showAlert = true
                }
                return
            }

            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                print("HTTP Status Code: \(httpResponse.statusCode)")
                DispatchQueue.main.async {
                    alertMessage = "HTTP Status Code: \(httpResponse.statusCode)"
                    showAlert = true
                }
                return
            }

            do {
                let responseJSON = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                print("Response: \(responseJSON)")
                if let responseDict = responseJSON as? [String: Any],
                   let success = responseDict["success"] as? Bool, success {
                    // Handle successful login and OTP prompt
                    DispatchQueue.main.async {
                        askOTP = true
                    }
                } else {
                    DispatchQueue.main.async {
                        alertMessage = "Invalid login credentials"
                        showAlert = true
                    }
                }
            } catch {
                print("Failed to decode JSON: \(error)")
                DispatchQueue.main.async {
                    alertMessage = "Failed to decode JSON: \(error.localizedDescription)"
                    showAlert = true
                }
            }
        }.resume()
    }

    func verifyOTP() {
        // Implement OTP verification logic here
        guard let url = URL(string: "https://b8fc-182-253-109-104.ngrok-free.app/api/auth/verify-otp") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: String] = ["email": emailID, "otp": otpText]

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        } catch {
            print("Failed to encode JSON")
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Network error: \(String(describing: error))")
                DispatchQueue.main.async {
                    alertMessage = "Network error: \(String(describing: error?.localizedDescription))"
                    showAlert = true
                }
                return
            }

            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                print("HTTP Status Code: \(httpResponse.statusCode)")
                DispatchQueue.main.async {
                    alertMessage = "HTTP Status Code: \(httpResponse.statusCode)"
                    showAlert = true
                }
                return
            }

            do {
                let responseJSON = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                print("OTP Verification Response: \(responseJSON)")
            } catch {
                print("Failed to decode JSON: \(error)")
                DispatchQueue.main.async {
                    alertMessage = "Failed to decode JSON: \(error.localizedDescription)"
                    showAlert = true
                }
            }
        }.resume()
    }
}


#Preview {
    ContentView()
}
