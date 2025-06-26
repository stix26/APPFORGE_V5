import SwiftUI

struct AppForgeColors {
    static let primary = Color(red: 0.365, green: 0.361, blue: 0.871) // #5D5CDE
    static let secondary = Color(red: 1.0, green: 0.42, blue: 0.42) // #FF6B6B
    static let accent = Color(red: 0.306, green: 0.804, blue: 0.769) // #4ECDC4
    static let warning = Color(red: 1.0, green: 0.851, blue: 0.239) // #FFD93D
    static let success = Color(red: 0.42, green: 0.812, blue: 0.498) // #6BCF7F
    
    static let backgroundLight = Color.white
    static let backgroundDark = Color(red: 0.094, green: 0.094, blue: 0.094) // #181818
    
    static let gray50 = Color(red: 0.98, green: 0.98, blue: 0.98)
    static let gray100 = Color(red: 0.957, green: 0.957, blue: 0.957)
    static let gray200 = Color(red: 0.898, green: 0.898, blue: 0.898)
    static let gray300 = Color(red: 0.831, green: 0.831, blue: 0.831)
    static let gray400 = Color(red: 0.631, green: 0.631, blue: 0.631)
    static let gray500 = Color(red: 0.478, green: 0.478, blue: 0.478)
    static let gray600 = Color(red: 0.376, green: 0.376, blue: 0.376)
    static let gray700 = Color(red: 0.275, green: 0.275, blue: 0.275)
    static let gray800 = Color(red: 0.153, green: 0.169, blue: 0.216)
    static let gray900 = Color(red: 0.067, green: 0.075, blue: 0.094)
    
    static func gradientPrimary() -> LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [primary, secondary]),
            startPoint: .leading,
            endPoint: .trailing
        )
    }
    
    static func gradientAccent() -> LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [accent, warning]),
            startPoint: .leading,
            endPoint: .trailing
        )
    }
    
    static func gradientSuccess() -> LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [secondary, success]),
            startPoint: .leading,
            endPoint: .trailing
        )
    }
    
    static func rainbowGradient() -> LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [
                Color.red,
                Color.orange,
                Color.yellow,
                Color.green,
                Color.cyan,
                Color.blue,
                Color.purple,
                Color.pink
            ]),
            startPoint: .leading,
            endPoint: .trailing
        )
    }
} 