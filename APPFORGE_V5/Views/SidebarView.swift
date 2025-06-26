import SwiftUI

struct SidebarView: View {
    @ObservedObject var viewModel: AppForgeViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // Header
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Quick Start")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.primary)
                    }
                    
                    // Popular Templates
                    TemplateCategory(
                        title: "Popular Templates",
                        templates: [
                            TemplateItem(title: "Todo App", icon: "checkmark.square", gradient: AppForgeColors.gradientPrimary()),
                            TemplateItem(title: "Chat App", icon: "bubble.left.and.bubble.right", gradient: AppForgeColors.gradientPrimary()),
                            TemplateItem(title: "E-commerce", icon: "cart", gradient: AppForgeColors.gradientPrimary()),
                            TemplateItem(title: "Blog Platform", icon: "doc.text", gradient: AppForgeColors.gradientPrimary())
                        ],
                        onTemplateTap: { template in
                            viewModel.showNotification("Selected \(template.title) template", type: .info)
                        }
                    )
                    
                    // Business Apps
                    TemplateCategory(
                        title: "Business Apps",
                        templates: [
                            TemplateItem(title: "CRM System", icon: "person.3", gradient: AppForgeColors.gradientAccent()),
                            TemplateItem(title: "Inventory Manager", icon: "shippingbox", gradient: AppForgeColors.gradientAccent()),
                            TemplateItem(title: "Analytics Dashboard", icon: "chart.bar", gradient: AppForgeColors.gradientAccent())
                        ],
                        onTemplateTap: { template in
                            viewModel.showNotification("Selected \(template.title) template", type: .info)
                        }
                    )
                    
                    // Creative Apps
                    TemplateCategory(
                        title: "Creative Apps",
                        templates: [
                            TemplateItem(title: "Portfolio Site", icon: "paintpalette", gradient: AppForgeColors.gradientSuccess()),
                            TemplateItem(title: "Photo Gallery", icon: "photo.on.rectangle.angled", gradient: AppForgeColors.gradientSuccess()),
                            TemplateItem(title: "Music Player", icon: "music.note", gradient: AppForgeColors.gradientSuccess())
                        ],
                        onTemplateTap: { template in
                            viewModel.showNotification("Selected \(template.title) template", type: .info)
                        }
                    )
                }
                .padding(.horizontal, 20)
                .padding(.top, 16)
            }
            
            // Statistics Card
            VStack(spacing: 12) {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Apps Generated Today")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.white)
                        
                        Text("\(viewModel.appsGeneratedToday)")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(.white)
                        
                        Text("+\(viewModel.growthPercentage)% from yesterday")
                            .font(.system(size: 12))
                            .foregroundColor(.white.opacity(0.9))
                    }
                    
                    Spacer()
                    
                    Image(systemName: "chart.line.uptrend.xyaxis")
                        .font(.system(size: 24, weight: .medium))
                        .foregroundColor(.white.opacity(0.8))
                }
            }
            .padding(20)
            .background(AppForgeColors.gradientPrimary())
            .cornerRadius(16)
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
            .onTapGesture {
                viewModel.showNotification("Analytics feature coming soon!", type: .info)
            }
        }
        .background(.background)
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 2)
    }
}

struct TemplateCategory: View {
    let title: String
    let templates: [TemplateItem]
    let onTemplateTap: (TemplateItem) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.secondary)
            
            VStack(spacing: 8) {
                ForEach(templates) { template in
                    TemplateButton(
                        title: template.title,
                        icon: template.icon,
                        gradient: template.gradient
                    ) {
                        onTemplateTap(template)
                    }
                }
            }
        }
    }
}

struct TemplateItem: Identifiable {
    let id = UUID()
    let title: String
    let icon: String
    let gradient: LinearGradient
}

#Preview {
    NavigationView {
        HStack(spacing: 0) {
            SidebarView(viewModel: AppForgeViewModel())
                .frame(width: 280)
            
            Color.gray.opacity(0.1)
                .frame(maxWidth: .infinity)
        }
    }
} 