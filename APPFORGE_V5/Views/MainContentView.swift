import SwiftUI

struct MainContentView: View {
    @ObservedObject var viewModel: AppForgeViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            HeaderView(viewModel: viewModel)
            
            // Main Content
            VStack(spacing: 0) {
                // Tab Navigation
                TabNavigationView(viewModel: viewModel)
                
                // Content Area
                ScrollView {
                    VStack(spacing: 32) {
                        // Welcome Section
                        WelcomeSection(viewModel: viewModel)
                        
                        // Quick Start Cards
                        QuickStartCards(viewModel: viewModel)
                        
                        // Demo Form
                        DemoFormSection(viewModel: viewModel)
                    }
                    .padding(.horizontal, 32)
                    .padding(.vertical, 32)
                }
                
                // Action Buttons
                ActionButtonsSection(viewModel: viewModel)
            }
            .background(.background)
            .cornerRadius(20)
            .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 2)
        }
    }
}

struct HeaderView: View {
    @ObservedObject var viewModel: AppForgeViewModel
    
    var body: some View {
        HStack {
            // Logo and title
            HStack(spacing: 16) {
                // Logo
                RoundedRectangle(cornerRadius: 12)
                    .fill(AppForgeColors.gradientPrimary())
                    .frame(width: 40, height: 40)
                    .overlay(
                        Image(systemName: "hammer")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.white)
                    )
                    .onTapGesture {
                        viewModel.showNotification("Welcome to AppForge!", type: .info)
                    }
                
                // Title with rainbow effect
                Text("AppForge")
                    .font(.system(size: 24, weight: .bold))
                    .background(AppForgeColors.rainbowGradient())
                    .mask(
                        Text("AppForge")
                            .font(.system(size: 24, weight: .bold))
                    )
                    .onTapGesture {
                        viewModel.showNotification("Click any element to explore features!", type: .info)
                    }
                
                // Pro badge
                Text("Pro")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 4)
                    .background(AppForgeColors.gradientPrimary())
                    .cornerRadius(12)
                    .onTapGesture {
                        viewModel.showNotification("Pro features unlocked!", type: .success)
                    }
            }
            
            Spacer()
            
            // Navigation and controls
            HStack(spacing: 24) {
                // Navigation items
                HStack(spacing: 20) {
                    NavigationItem(title: "Templates") {
                        viewModel.showNotification("Templates feature coming soon!", type: .info)
                    }
                    NavigationItem(title: "Examples") {
                        viewModel.showNotification("Examples feature coming soon!", type: .info)
                    }
                    NavigationItem(title: "Documentation") {
                        viewModel.showNotification("Documentation feature coming soon!", type: .info)
                    }
                    NavigationItem(title: "Support") {
                        viewModel.showNotification("Support feature coming soon!", type: .info)
                    }
                }
                
                // Theme toggle
                IconButton(
                    icon: viewModel.isDarkMode ? "sun.max" : "moon",
                    action: {
                        viewModel.toggleDarkMode()
                        viewModel.showNotification("Theme toggled!", type: .info)
                    },
                    backgroundColor: AppForgeColors.gray100,
                    iconColor: AppForgeColors.gray600
                )
                
                // Profile button
                GradientButton(
                    title: "Profile",
                    icon: "person",
                    size: .small
                ) {
                    viewModel.showNotification("Profile feature coming soon!", type: .info)
                }
            }
        }
        .padding(.horizontal, 32)
        .padding(.vertical, 16)
        .background(.background)
        .overlay(
            Rectangle()
                .fill(AppForgeColors.gradientPrimary())
                .frame(height: 2),
            alignment: .bottom
        )
    }
}

struct NavigationItem: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.secondary)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct TabNavigationView: View {
    @ObservedObject var viewModel: AppForgeViewModel
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(AppForgeViewModel.AppTab.allCases, id: \.self) { tab in
                Button(action: {
                    viewModel.selectTab(tab)
                }) {
                    HStack(spacing: 8) {
                        Image(systemName: tab.icon)
                            .font(.system(size: 14, weight: .medium))
                        
                        Text(tab.rawValue)
                            .font(.system(size: 14, weight: .medium))
                    }
                    .foregroundColor(viewModel.selectedTab == tab ? AppForgeColors.primary : .secondary)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 16)
                    .background(
                        viewModel.selectedTab == tab ?
                        AppForgeColors.primary.opacity(0.1) : Color.clear
                    )
                    .overlay(
                        Rectangle()
                            .fill(viewModel.selectedTab == tab ? AppForgeColors.primary : Color.clear)
                            .frame(height: 2),
                        alignment: .bottom
                    )
                }
                .buttonStyle(PlainButtonStyle())
            }
            
            Spacer()
        }
        .background(.background)
        .overlay(
            Rectangle()
                .fill(AppForgeColors.gray200)
                .frame(height: 1),
            alignment: .bottom
        )
    }
}

struct WelcomeSection: View {
    @ObservedObject var viewModel: AppForgeViewModel
    
    var body: some View {
        VStack(spacing: 24) {
            // Main icon
            ZStack {
                Circle()
                    .fill(AppForgeColors.gradientPrimary())
                    .frame(width: 96, height: 96)
                
                Image(systemName: "rocket")
                    .font(.system(size: 48, weight: .semibold))
                    .foregroundColor(.white)
            }
            .onTapGesture {
                viewModel.showNotification("Ready for launch! 🚀", type: .success)
            }
            
            VStack(spacing: 16) {
                Text("Welcome to AppForge")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.center)
                
                Text("The most advanced application generator for modern web development")
                    .font(.system(size: 18))
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .lineLimit(3)
            }
        }
    }
}

struct QuickStartCards: View {
    @ObservedObject var viewModel: AppForgeViewModel
    
    var body: some View {
        HStack(spacing: 24) {
            QuickStartCard(
                title: "Getting Started",
                description: "Quick tutorial to begin",
                icon: "play.fill",
                color: .blue
            ) {
                viewModel.showNotification("Tutorial starting soon!", type: .info)
            }
            
            QuickStartCard(
                title: "Features",
                description: "Powerful capabilities",
                icon: "star.fill",
                color: .green
            ) {
                viewModel.showNotification("Exploring features...", type: .info)
            }
            
            QuickStartCard(
                title: "Community",
                description: "Connect with others",
                icon: "person.3.fill",
                color: .orange
            ) {
                viewModel.showNotification("Joining community...", type: .info)
            }
        }
    }
}

struct QuickStartCard: View {
    let title: String
    let description: String
    let icon: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 16) {
                ZStack {
                    Circle()
                        .fill(color)
                        .frame(width: 48, height: 48)
                    
                    Image(systemName: icon)
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.white)
                }
                
                VStack(spacing: 8) {
                    Text(title)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.primary)
                    
                    Text(description)
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
            }
            .padding(24)
            .frame(maxWidth: .infinity)
            .background(color.opacity(0.05))
            .cornerRadius(16)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(color.opacity(0.2), lineWidth: 1)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct DemoFormSection: View {
    @ObservedObject var viewModel: AppForgeViewModel
    
    var body: some View {
        VStack(spacing: 24) {
            Text("Quick Demo Form")
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(.primary)
            
            VStack(spacing: 16) {
                HStack(spacing: 16) {
                    TextField("App Name", text: $viewModel.demoAppName)
                        .textFieldStyle(CustomTextFieldStyle())
                    
                    Menu {
                        Button("Web App") {
                            viewModel.demoCategory = "web"
                        }
                        Button("Mobile App") {
                            viewModel.demoCategory = "mobile"
                        }
                        Button("Desktop App") {
                            viewModel.demoCategory = "desktop"
                        }
                    } label: {
                        HStack {
                            Text(viewModel.demoCategory.isEmpty ? "Select Category" : viewModel.demoCategory.capitalized)
                                .foregroundColor(viewModel.demoCategory.isEmpty ? .secondary : .primary)
                            Spacer()
                            Image(systemName: "chevron.down")
                                .foregroundColor(.secondary)
                        }
                        .padding(16)
                        .background(.secondary.opacity(0.1))
                        .cornerRadius(12)
                    }
                }
                
                HStack(spacing: 16) {
                    GradientButton(
                        title: "Validate & Continue",
                        icon: "checkmark",
                        gradient: LinearGradient(
                            gradient: Gradient(colors: [.green, .green.opacity(0.8)]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    ) {
                        viewModel.validateAndContinue()
                    }
                    
                    Button("Clear Form") {
                        viewModel.clearForm()
                    }
                    .foregroundColor(.secondary)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 12)
                    .background(AppForgeColors.gray200)
                    .cornerRadius(12)
                }
            }
            .padding(24)
            .background(AppForgeColors.gray50)
            .cornerRadius(16)
        }
    }
}

struct ActionButtonsSection: View {
    @ObservedObject var viewModel: AppForgeViewModel
    
    var body: some View {
        HStack {
            HStack(spacing: 16) {
                Button("Save Configuration") {
                    viewModel.showNotification("Configuration saved!", type: .success)
                }
                .foregroundColor(.secondary)
                .padding(.horizontal, 24)
                .padding(.vertical, 12)
                .background(AppForgeColors.gray200)
                .cornerRadius(12)
                
                Button("Load Configuration") {
                    viewModel.showNotification("Configuration loaded!", type: .info)
                }
                .foregroundColor(.secondary)
                .padding(.horizontal, 24)
                .padding(.vertical, 12)
                .background(AppForgeColors.gray200)
                .cornerRadius(12)
            }
            
            Spacer()
            
            HStack(spacing: 16) {
                GradientButton(
                    title: "Preview App",
                    icon: "eye",
                    gradient: AppForgeColors.gradientAccent()
                ) {
                    viewModel.showNotification("Launching preview...", type: .info)
                }
                
                GradientButton(
                    title: "Generate App",
                    icon: "rocket",
                    size: .large
                ) {
                    viewModel.generateApp()
                }
            }
        }
        .padding(.horizontal, 32)
        .padding(.vertical, 24)
        .background(AppForgeColors.gray50)
        .overlay(
            Rectangle()
                .fill(AppForgeColors.gray200)
                .frame(height: 1),
            alignment: .top
        )
    }
}

struct CustomTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(16)
            .background(.secondary.opacity(0.1))
            .cornerRadius(12)
    }
}

#Preview {
    MainContentView(viewModel: AppForgeViewModel())
} 