import SwiftUI

struct OTPView: View {
    @Binding var otpText: String
    @Environment(\.dismiss) private var dismiss
    var verifyOtp: () -> Void // Closure to handle OTP verification

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Button(action: {
                dismiss()
            }, label: {
                Image(systemName: "xmark")
                    .font(.title2)
                    .foregroundColor(.gray)
            })
            .padding(.top, 10)
            
            Text("Enter OTP")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .padding(.top, 5)
            
            Text("A 6 digit code has been sent to your Email.")
                .font(.callout)
                .fontWeight(.semibold)
                .foregroundColor(.gray)
                .padding(.top, -5)
            
            VStack(spacing: 25) {
                OTPVerificationView(otpText: $otpText)
                
                Button(action: {
                    verifyOtp() // Call the OTP verification function
                }, label: {
                    Text("Continue")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(otpText.isEmpty ? Color.gray.opacity(0.5) : Color.appYellow)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                })
                .disabled(otpText.isEmpty)
                .padding(.top, 20)
            }
            
            Spacer()
        }
        .padding(.vertical, 15)
        .padding(.horizontal, 25)
        .interactiveDismissDisabled(true)
    }
}
