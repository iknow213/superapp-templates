import SwiftUI

struct LogoAnimation: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.black)
                .frame(width: 46, height: 46)
            Image(systemName: "atom")
                .font(.system(size: 22, weight: .medium))
                .foregroundColor(.white)
        }
    }
}
