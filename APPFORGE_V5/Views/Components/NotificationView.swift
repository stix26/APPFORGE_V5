import SwiftUI

struct NotificationView: View {
    let notification: AppForgeViewModel.NotificationItem
    let onDismiss: () -> Void
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: notification.type.icon)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.white)
            
            Text(notification.message)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.white)
                .multilineTextAlignment(.leading)
                .lineLimit(3)
            
            Spacer()
            
            Button(action: onDismiss) {
                Image(systemName: "xmark")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(.white.opacity(0.8))
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(notification.type.color)
        .cornerRadius(12)
        .shadow(color: notification.type.color.opacity(0.3), radius: 8, x: 0, y: 4)
    }
}

struct NotificationContainer: View {
    @ObservedObject var viewModel: AppForgeViewModel
    
    var body: some View {
        VStack(spacing: 8) {
            ForEach(viewModel.notifications) { notification in
                NotificationView(notification: notification) {
                    viewModel.removeNotification(notification)
                }
                .transition(.asymmetric(
                    insertion: .move(edge: .trailing).combined(with: .opacity),
                    removal: .move(edge: .trailing).combined(with: .opacity)
                ))
            }
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
        .padding(.horizontal, 16)
        .padding(.top, 8)
    }
}

#Preview {
    let viewModel = AppForgeViewModel()
    
    VStack {
        Button("Show Success") {
            viewModel.showNotification("Form validated successfully!", type: .success)
        }
        
        Button("Show Error") {
            viewModel.showNotification("Please enter an app name!", type: .error)
        }
        
        Button("Show Warning") {
            viewModel.showNotification("Please select a category!", type: .warning)
        }
        
        Button("Show Info") {
            viewModel.showNotification("Welcome to AppForge! Click any element to explore.", type: .info)
        }
        
        Spacer()
        
        NotificationContainer(viewModel: viewModel)
    }
    .padding()
} 