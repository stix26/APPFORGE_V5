import SwiftUI

struct LoadingOverlay: View {
    @ObservedObject var viewModel: AppForgeViewModel
    
    var body: some View {
        if viewModel.isLoading {
            ZStack {
                Color.black.opacity(0.5)
                    .ignoresSafeArea()
                
                VStack(spacing: 24) {
                    // Loading spinner
                    ZStack {
                        Circle()
                            .stroke(AppForgeColors.gray200, lineWidth: 4)
                            .frame(width: 64, height: 64)
                        
                        Circle()
                            .trim(from: 0, to: 0.25)
                            .stroke(AppForgeColors.gradientPrimary(), lineWidth: 4)
                            .frame(width: 64, height: 64)
                            .rotationEffect(.degrees(-90))
                            .animation(.linear(duration: 1).repeatForever(autoreverses: false), value: viewModel.isLoading)
                    }
                    
                    VStack(spacing: 16) {
                        Text("Opening External Site")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.primary)
                        
                        Text(viewModel.loadingMessage)
                            .font(.system(size: 14))
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                        
                        // Progress bar
                        VStack(spacing: 8) {
                            ZStack(alignment: .leading) {
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(AppForgeColors.gray200)
                                    .frame(height: 8)
                                
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(AppForgeColors.gradientPrimary())
                                    .frame(width: max(0, CGFloat(viewModel.loadingProgress) * 280), height: 8)
                                    .animation(.easeInOut(duration: 0.3), value: viewModel.loadingProgress)
                            }
                            .frame(width: 280)
                            
                            Text("\(Int(viewModel.loadingProgress * 100))%")
                                .font(.system(size: 12, weight: .medium))
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .padding(32)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.ultraThinMaterial)
                        .shadow(radius: 20)
                )
                .frame(maxWidth: 320)
            }
            .transition(.opacity.combined(with: .scale(scale: 0.9)))
        }
    }
}

struct PulsingLoadingView: View {
    @State private var isPulsing = false
    let color: Color
    let size: CGFloat
    
    init(color: Color = AppForgeColors.primary, size: CGFloat = 60) {
        self.color = color
        self.size = size
    }
    
    var body: some View {
        ZStack {
            Circle()
                .fill(color.opacity(0.3))
                .frame(width: size, height: size)
                .scaleEffect(isPulsing ? 1.3 : 1.0)
                .opacity(isPulsing ? 0.3 : 0.8)
            
            Circle()
                .fill(color)
                .frame(width: size * 0.6, height: size * 0.6)
                .scaleEffect(isPulsing ? 1.1 : 1.0)
        }
        .animation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true), value: isPulsing)
        .onAppear {
            isPulsing = true
        }
    }
}

struct SpinningLoadingView: View {
    @State private var rotation: Double = 0
    let color: Color
    let size: CGFloat
    
    init(color: Color = AppForgeColors.primary, size: CGFloat = 40) {
        self.color = color
        self.size = size
    }
    
    var body: some View {
        Image(systemName: "arrow.2.circlepath")
            .font(.system(size: size * 0.6, weight: .medium))
            .foregroundColor(color)
            .rotationEffect(.degrees(rotation))
            .animation(.linear(duration: 1).repeatForever(autoreverses: false), value: rotation)
            .onAppear {
                rotation = 360
            }
    }
}

#Preview {
    ZStack {
        Rectangle()
            .fill(.gray.opacity(0.1))
            .ignoresSafeArea()
        
        VStack(spacing: 40) {
            PulsingLoadingView()
            
            SpinningLoadingView()
            
            Button("Show Loading") {
                // Preview action
            }
        }
        
        // Simulate loading overlay
        LoadingOverlay(viewModel: {
            let vm = AppForgeViewModel()
            vm.isLoading = true
            vm.loadingProgress = 0.6
            vm.loadingMessage = "Redirecting you to the destination..."
            return vm
        }())
    }
} 