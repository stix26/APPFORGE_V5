import SwiftUI

struct GradientButton: View {
    let title: String
    let icon: String?
    let gradient: LinearGradient
    let action: () -> Void
    
    var isLoading: Bool = false
    var size: ButtonSize = .medium
    
    enum ButtonSize {
        case small, medium, large
        
        var padding: EdgeInsets {
            switch self {
            case .small: return EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
            case .medium: return EdgeInsets(top: 12, leading: 24, bottom: 12, trailing: 24)
            case .large: return EdgeInsets(top: 16, leading: 32, bottom: 16, trailing: 32)
            }
        }
        
        var fontSize: CGFloat {
            switch self {
            case .small: return 14
            case .medium: return 16
            case .large: return 18
            }
        }
    }
    
    init(
        title: String,
        icon: String? = nil,
        gradient: LinearGradient = AppForgeColors.gradientPrimary(),
        size: ButtonSize = .medium,
        isLoading: Bool = false,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.icon = icon
        self.gradient = gradient
        self.size = size
        self.isLoading = isLoading
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(0.8)
                } else if let icon = icon {
                    Image(systemName: icon)
                        .font(.system(size: size.fontSize - 2, weight: .medium))
                }
                
                Text(title)
                    .font(.system(size: size.fontSize, weight: .semibold))
            }
            .foregroundColor(.white)
            .padding(size.padding)
            .background(gradient)
            .cornerRadius(12)
            .shadow(color: AppForgeColors.primary.opacity(0.3), radius: 8, x: 0, y: 4)
        }
        .scaleEffect(isLoading ? 0.95 : 1.0)
        .animation(.easeInOut(duration: 0.2), value: isLoading)
        .disabled(isLoading)
    }
}

struct IconButton: View {
    let icon: String
    let action: () -> Void
    var backgroundColor: Color = AppForgeColors.gray100
    var iconColor: Color = AppForgeColors.gray600
    var size: CGFloat = 44
    
    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .font(.system(size: size * 0.4, weight: .medium))
                .foregroundColor(iconColor)
                .frame(width: size, height: size)
                .background(backgroundColor)
                .cornerRadius(12)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct TemplateButton: View {
    let title: String
    let icon: String
    let gradient: LinearGradient
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .font(.system(size: 16, weight: .medium))
                    .frame(width: 20)
                
                Text(title)
                    .font(.system(size: 15, weight: .medium))
                    .multilineTextAlignment(.leading)
                
                Spacer()
            }
            .foregroundColor(AppForgeColors.gray700)
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(AppForgeColors.gray50)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.clear, lineWidth: 0)
            )
        }
        .buttonStyle(PlainButtonStyle())
        .onTapGesture {
            action()
        }
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(gradient)
                .opacity(0)
        )
        .animation(.easeInOut(duration: 0.2), value: false)
    }
}

#Preview {
    VStack(spacing: 20) {
        GradientButton(
            title: "Generate App",
            icon: "rocket",
            gradient: AppForgeColors.gradientPrimary()
        ) {
            print("Generate tapped")
        }
        
        GradientButton(
            title: "Loading...",
            icon: "arrow.clockwise",
            isLoading: true
        ) {
            print("Loading")
        }
        
        IconButton(icon: "moon") {
            print("Theme toggle")
        }
        
        TemplateButton(
            title: "Todo App",
            icon: "checkmark.square",
            gradient: AppForgeColors.gradientPrimary()
        ) {
            print("Todo template")
        }
    }
    .padding()
} 