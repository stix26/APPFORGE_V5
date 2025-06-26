import SwiftUI
import Combine

class AppForgeViewModel: ObservableObject {
    @Published var selectedTab: AppTab = .basic
    @Published var isDarkMode = false
    @Published var isLoading = false
    @Published var loadingProgress: Double = 0.0
    @Published var loadingMessage = "Loading..."
    @Published var notifications: [NotificationItem] = []
    @Published var appsGeneratedToday = 1247
    @Published var growthPercentage = 12
    
    // Demo form data
    @Published var demoAppName = ""
    @Published var demoCategory = ""
    
    enum AppTab: String, CaseIterable {
        case basic = "Basic Info"
        case design = "Design"
        case features = "Features"
        case advanced = "Advanced"
        case preview = "Preview"
        
        var icon: String {
            switch self {
            case .basic: return "info.circle"
            case .design: return "paintbrush"
            case .features: return "gearshape.2"
            case .advanced: return "slider.horizontal.3"
            case .preview: return "eye"
            }
        }
    }
    
    struct NotificationItem: Identifiable {
        let id = UUID()
        let message: String
        let type: NotificationType
        let timestamp = Date()
        
        enum NotificationType {
            case success, error, warning, info
            
            var color: Color {
                switch self {
                case .success: return AppForgeColors.success
                case .error: return Color.red
                case .warning: return AppForgeColors.warning
                case .info: return Color.blue
                }
            }
            
            var icon: String {
                switch self {
                case .success: return "checkmark.circle.fill"
                case .error: return "exclamationmark.circle.fill"
                case .warning: return "exclamationmark.triangle.fill"
                case .info: return "info.circle.fill"
                }
            }
        }
    }
    
    func showNotification(_ message: String, type: NotificationItem.NotificationType = .info) {
        let notification = NotificationItem(message: message, type: type)
        withAnimation(.easeInOut) {
            notifications.append(notification)
        }
        
        // Auto remove after 3 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            withAnimation(.easeInOut) {
                self.notifications.removeAll { $0.id == notification.id }
            }
        }
    }
    
    func removeNotification(_ notification: NotificationItem) {
        withAnimation(.easeInOut) {
            notifications.removeAll { $0.id == notification.id }
        }
    }
    
    func showLoading(message: String = "Loading...") {
        loadingMessage = message
        isLoading = true
        loadingProgress = 0.0
        
        // Simulate progress
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            DispatchQueue.main.async {
                self.loadingProgress += Double.random(in: 0.02...0.15)
                if self.loadingProgress >= 1.0 {
                    self.loadingProgress = 1.0
                    timer.invalidate()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.isLoading = false
                    }
                }
            }
        }
    }
    
    func validateAndContinue() {
        guard !demoAppName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            showNotification("Please enter an app name!", type: .error)
            return
        }
        
        guard !demoCategory.isEmpty else {
            showNotification("Please select a category!", type: .warning)
            return
        }
        
        showNotification("Form validated successfully!", type: .success)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.showLoading(message: "Creating your app...")
        }
    }
    
    func clearForm() {
        demoAppName = ""
        demoCategory = ""
        showNotification("Form cleared!", type: .info)
    }
    
    func generateApp() {
        showNotification("Starting app generation process...", type: .info)
        
        let steps = [
            "Creating repository...",
            "Setting up deployment...",
            "Finalizing build...",
            "App generated successfully!"
        ]
        
        for (index, step) in steps.enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index + 1) * 2) {
                self.showNotification(step, type: index == steps.count - 1 ? .success : .info)
            }
        }
    }
    
    func selectTab(_ tab: AppTab) {
        withAnimation(.easeInOut(duration: 0.3)) {
            selectedTab = tab
        }
    }
    
    func toggleDarkMode() {
        withAnimation(.easeInOut) {
            isDarkMode.toggle()
        }
    }
} 