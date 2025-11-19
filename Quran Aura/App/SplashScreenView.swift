import SwiftUI

struct EnhancedSplashScreenView: View {
    @State private var isActive = false
    @State private var logoOpacity = 0.0
    @State private var textOpacity = 0.0
    @State private var copyrightOpacity = 0.0
    
    // Get current year automatically
    private var currentYear: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter.string(from: Date())
    }
    
    var body: some View {
        if isActive {
            ContentView()
        } else {
            ZStack {
                // Background with Islamic gradient
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 0.2, green: 0.1, blue: 0.4),
                        Color(red: 0.1, green: 0.2, blue: 0.5)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                // Decorative elements
                Circle()
                    .fill(Color.white.opacity(0.1))
                    .frame(width: 300, height: 300)
                    .offset(x: -100, y: -200)
                
                Circle()
                    .fill(Color.white.opacity(0.05))
                    .frame(width: 200, height: 200)
                    .offset(x: 150, y: 250)
                
                VStack(spacing: 30) {
                    Spacer()
                    
                    // Logo section
                    VStack(spacing: 25) {
                        ZStack {
                            Circle()
                                .fill(Color.white.opacity(0.15))
                                .frame(width: 150, height: 150)
                            
                            // Use app icon from Assets
                            if UIImage(named: "logo-app") != nil {
                                Image("logo-app")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 80, height: 80)
                                    .clipShape(RoundedRectangle(cornerRadius: 16))
                            } else {
                                // fallback if icon not found
                                Image(systemName: "book.closed.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 60, height: 60)
                                    .foregroundColor(.white)
                            }
                            
                            Circle()
                                .stroke(Color.white.opacity(0.25), lineWidth: 3)
                                .frame(width: 150, height: 150)
                        }
                        .opacity(logoOpacity)
                        
                        // App name and text
                        VStack(spacing: 12) {
                            Text("Quran Aura")
                                .font(.system(size: 34, weight: .heavy, design: .rounded))
                                .foregroundColor(.white)
                                .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 2)
                            
                            // Islamic text
                            VStack(spacing: 8) {
                                Text("أَسْتَغْفِرُ اللَّهَ الْعَظِيمَ")
                                    .font(.callout)
                                    .foregroundColor(.white.opacity(0.8))
                                
                                Text("الَّذِي لَا إِلَهَ إِلَّا هُوَ")
                                    .font(.callout)
                                    .foregroundColor(.white.opacity(0.8))
                                
                                Text("الْحَيُّ الْقَيُّومُ ، وَأَتُوبُ إِلَيْهِ")
                                    .font(.callout)
                                    .foregroundColor(.white.opacity(0.8))
                            }
                            .multilineTextAlignment(.center)
                            .padding(.top, 5)
                        }
                        .opacity(textOpacity)
                    }
                    
                    Spacer()
                    
                    // Copyright section
                    VStack(spacing: 15) {
                        Divider()
                            .background(Color.white.opacity(0.3))
                            .frame(width: 220)
                        
                        VStack(spacing: 8) {
                            // Automatic year
                            Text("© \(currentYear) Quran Aura App")
                                .font(.caption)
                                .fontWeight(.medium)
                                .foregroundColor(.white.opacity(0.85))
                            
                            Text("جميع الحقوق محفوظة")
                                .font(.caption2)
                                .foregroundColor(.white.opacity(0.75))
                            
                            Text("Developed with ❤️ for Azozz ALFiras")
                                .font(.caption2)
                                .foregroundColor(.white.opacity(0.65))
                                .padding(.top, 4)
                            
                            Text("بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ")
                                .font(.caption2)
                                .foregroundColor(.white.opacity(0.6))
                                .padding(.top, 2)
                        }
                    }
                    .opacity(copyrightOpacity)
                    .padding(.bottom, 50)
                }
                .padding(.horizontal, 30)
            }
            .onAppear {
                // Animate logo first
                withAnimation(.easeIn(duration: 1.2)) {
                    logoOpacity = 1.0
                }
                
                // Then animate text
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                    withAnimation(.easeIn(duration: 1.0)) {
                        textOpacity = 1.0
                    }
                }
                
                // Then animate copyright
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                    withAnimation(.easeIn(duration: 1.0)) {
                        copyrightOpacity = 1.0
                    }
                }
                
                // Navigate to main app
                DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                    withAnimation(.easeOut(duration: 0.6)) {
                        isActive = true
                    }
                }
            }
        }
    }
}
