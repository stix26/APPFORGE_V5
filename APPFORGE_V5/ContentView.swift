import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = AppForgeViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Background
                (viewModel.isDarkMode ? AppForgeColors.backgroundDark : AppForgeColors.backgroundLight)
                    .ignoresSafeArea()
                
                // Main Content
                if geometry.size.width > 1000 {
                    // Desktop/iPad layout
                    HStack(spacing: 32) {
                        // Sidebar
                        SidebarView(viewModel: viewModel)
                            .frame(width: 320)
                        
                        // Main content
                        MainContentView(viewModel: viewModel)
                            .frame(maxWidth: .infinity)
                    }
                    .padding(32)
                } else {
                    // Mobile layout
                    TabView {
                        // Main tab
                        VStack(spacing: 0) {
                            MainContentView(viewModel: viewModel)
                        }
                        .tabItem {
                            Image(systemName: "house")
                            Text("Home")
                        }
                        
                        // Templates tab
                        NavigationView {
                            SidebarView(viewModel: viewModel)
                                .navigationTitle("Templates")
                                #if os(iOS)
                                .navigationBarTitleDisplayMode(.large)
                                #endif
                        }
                        .tabItem {
                            Image(systemName: "square.grid.2x2")
                            Text("Templates")
                        }
                        
                        // Settings tab
                        SettingsView(viewModel: viewModel)
                            .tabItem {
                                Image(systemName: "gear")
                                Text("Settings")
                            }
                    }
                    .accentColor(AppForgeColors.primary)
                }
                
                // Notifications overlay
                VStack {
                    NotificationContainer(viewModel: viewModel)
                    Spacer()
                }
                .ignoresSafeArea(.keyboard)
                
                // Loading overlay
                LoadingOverlay(viewModel: viewModel)
            }
        }
        .preferredColorScheme(viewModel.isDarkMode ? .dark : .light)
        .onAppear {
            // Show welcome notification
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                viewModel.showNotification("Welcome to AppForge! Click any element to explore features.", type: .info)
            }
            
            // Update stats periodically
            startStatsTimer()
        }
    }
    
    private func startStatsTimer() {
        Timer.scheduledTimer(withTimeInterval: 30, repeats: true) { _ in
            withAnimation(.easeInOut) {
                viewModel.appsGeneratedToday += Int.random(in: 1...5)
                if Int.random(in: 1...10) > 7 {
                    viewModel.growthPercentage += Int.random(in: 1...3)
                }
            }
        }
    }
}

struct SettingsView: View {
    @ObservedObject var viewModel: AppForgeViewModel
    
    var body: some View {
        NavigationView {
            List {
                Section("Appearance") {
                    HStack {
                        Image(systemName: viewModel.isDarkMode ? "moon.fill" : "sun.max.fill")
                            .foregroundColor(AppForgeColors.primary)
                            .frame(width: 24)
                        
                        Text("Dark Mode")
                        
                        Spacer()
                        
                        Toggle("", isOn: $viewModel.isDarkMode)
                            .onChange(of: viewModel.isDarkMode) {
                                viewModel.showNotification("Theme updated!", type: .success)
                            }
                    }
                }
                
                Section("Statistics") {
                    HStack {
                        Image(systemName: "chart.bar.fill")
                            .foregroundColor(.green)
                            .frame(width: 24)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Apps Generated Today")
                                .font(.headline)
                            Text("\(viewModel.appsGeneratedToday)")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(AppForgeColors.primary)
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .trailing, spacing: 4) {
                            Text("Growth")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Text("+\(viewModel.growthPercentage)%")
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundColor(.green)
                        }
                    }
                }
                
                Section("About") {
                    HStack {
                        Image(systemName: "info.circle.fill")
                            .foregroundColor(.blue)
                            .frame(width: 24)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("AppForge")
                                .font(.headline)
                            Text("Advanced App Generator v5.0")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                    .onTapGesture {
                        viewModel.showNotification("AppForge - Built with ❤️ for developers", type: .info)
                    }
                }
                
                Section("Actions") {
                    Button(action: {
                        viewModel.showNotification("Test notification sent!", type: .success)
                    }) {
                        HStack {
                            Image(systemName: "bell.fill")
                                .foregroundColor(.orange)
                                .frame(width: 24)
                            Text("Test Notifications")
                                .foregroundColor(.primary)
                        }
                    }
                    
                    Button(action: {
                        viewModel.clearForm()
                        viewModel.showNotification("All data cleared!", type: .warning)
                    }) {
                        HStack {
                            Image(systemName: "trash.fill")
                                .foregroundColor(.red)
                                .frame(width: 24)
                            Text("Clear All Data")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            .navigationTitle("Settings")
            #if os(iOS)
            .navigationBarTitleDisplayMode(.large)
            #endif
        }
    }
}

// Footer component for larger screens
struct FooterView: View {
    @ObservedObject var viewModel: AppForgeViewModel
    
    var body: some View {
        VStack(spacing: 32) {
            HStack(alignment: .top, spacing: 40) {
                // Company info
                VStack(alignment: .leading, spacing: 16) {
                    HStack(spacing: 12) {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(AppForgeColors.gradientPrimary())
                            .frame(width: 32, height: 32)
                            .overlay(
                                Image(systemName: "hammer")
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(.white)
                            )
                        
                        Text("AppForge")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.primary)
                    }
                    
                    Text("The most advanced application generator for modern web development. Create stunning applications in minutes, not hours.")
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    HStack(spacing: 16) {
                        SocialButton(icon: "twitter", action: {
                            viewModel.showNotification("Opening Twitter...", type: .info)
                        })
                        SocialButton(icon: "github", action: {
                            viewModel.showNotification("Opening GitHub...", type: .info)
                        })
                        SocialButton(icon: "discord", action: {
                            viewModel.showNotification("Opening Discord...", type: .info)
                        })
                        SocialButton(icon: "linkedin", action: {
                            viewModel.showNotification("Opening LinkedIn...", type: .info)
                        })
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                // Resources
                FooterSection(
                    title: "Resources",
                    items: ["Documentation", "Tutorials", "Examples", "API Reference"]
                ) { item in
                    viewModel.showNotification("\(item) feature coming soon!", type: .info)
                }
                
                // Support
                FooterSection(
                    title: "Support",
                    items: ["Help Center", "Community", "Contact Us", "Bug Reports"]
                ) { item in
                    viewModel.showNotification("\(item) feature coming soon!", type: .info)
                }
            }
            
            // Copyright
            Text("© 2024 AppForge. All rights reserved. Built with ❤️ for developers.")
                .font(.system(size: 14))
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .onTapGesture {
                    viewModel.showNotification("Thank you for using AppForge! 💙", type: .success)
                }
        }
        .padding(40)
        .background(.background)
        .overlay(
            Rectangle()
                .fill(AppForgeColors.gray200)
                .frame(height: 1),
            alignment: .top
        )
    }
}

struct FooterSection: View {
    let title: String
    let items: [String]
    let onItemTap: (String) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(title)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.primary)
            
            VStack(alignment: .leading, spacing: 8) {
                ForEach(items, id: \.self) { item in
                    Button(item) {
                        onItemTap(item)
                    }
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct SocialButton: View {
    let icon: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: socialIconMapping[icon] ?? "link")
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(AppForgeColors.gray400)
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    private let socialIconMapping: [String: String] = [
        "twitter": "message",
        "github": "chevron.left.forwardslash.chevron.right",
        "discord": "bubble.left.and.bubble.right",
        "linkedin": "person.crop.circle"
    ]
}

#Preview {
    ContentView()
} 