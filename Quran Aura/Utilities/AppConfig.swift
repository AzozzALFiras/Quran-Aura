// AppConfig.swift
import SwiftUI

class AppConfig {
    static let shared = AppConfig()
    
    // MARK: - Colors (Updated for consistent background like Search screen)
    let primaryColor = Color(red: 0.5, green: 0.2, blue: 0.8) // Purple
    let secondaryColor = Color(red: 0.2, green: 0.4, blue: 0.9) // Blue
    let accentColor = Color(red: 0.9, green: 0.3, blue: 0.5) // Pink
    
    // Unified background colors (like Search screen)
    let backgroundColor = Color(.systemBackground)
    let cardBackground = Color(.secondarySystemBackground)
    let cardBackgroundDua = Color(red: 0.95, green: 0.95, blue: 0.97) // Light gray background like surahs list
    let textPrimary = Color.primary
    let textSecondary = Color.secondary
    
    // Updated gradients to use solid background like Search screen
    var primaryGradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [
                Color(.systemBackground),
                Color(.systemBackground)
            ]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
    
    var playerGradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [
                Color(.systemBackground),
                Color(.systemBackground)
            ]),
            startPoint: .top,
            endPoint: .bottom
        )
    }
    
    // MARK: - Text Strings (Arabic)
    struct Strings {
        // Common
        let close = "إغلاق"
        let share = "مشاركة"
        let cancel = "إلغاء"
        let ok = "حسناً"
        let error = "خطأ"
        let loading = "جاري التحميل..."
        let done = "تم"
        
        // Navigation
        let search = "بحث"
        let reciters = "القراء"
        let surahs = "سور القرآن"
        let settings = "الإعدادات"
        let home = "الرئيسية"
        let duas = "الأدعية"
        let activities = "الأنشطة"
        
        // Home
        let quran = "القرآن الكريم"
        let goodMorning = "صباح الخير"
        let goodEvening = "مساء الخير"
        let continueListening = "استمر في الاستماع"
        let lastSurah = "آخر سورة"
        let favoriteSurahs = "السور المفضلة"
        let recentRecitations = "التلاوات الأخيرة"
        let favoriteReciters = "القراء المفضلون"
        let featuredReciters = "القراء المميزون"
        let recentSurahs = "السور الأخيرة"
        let viewAll = "عرض الكل"
        let recentlyListened = "المستمع إليه حديثاً"
        
        // Player
        let nowPlaying = "الآن يُشغل"
        let play = "تشغيل"
        let pause = "إيقاف مؤقت"
        let stop = "إيقاف"
        let addToFavorites = "إضافة إلى المفضلة"
        let removeFromFavorites = "إزالة من المفضلة"
        
        // Search
        let searchPlaceholder = "ابحث عن سورة أو قارئ..."
        let searchSurahs = "السور"
        let searchReciters = "القراء"
        let noResults = "لا توجد نتائج"
        let favoriteSurahsSection = "السور المفضلة"
        let favoriteRecitersSection = "القراء المفضلون"
        
        // Settings
        let appearance = "المظهر"
        let darkMode = "الوضع الليلي"
        let appTheme = "لون التطبيق"
        let socialMedia = "وسائل التواصل الاجتماعي"
        let followUs = "تابعنا على"
        let aboutApp = "حول التطبيق"
        let shareApp = "مشاركة التطبيق"
        let developer = "المطور"
        let version = "الإصدار"
        let email = "البريد الإلكتروني"
        let website = "الموقع"
        
        // Duas
        let duass = "الأدعية والأذكار"
        let duasDescription = "مجموعة مختارة من الأدعية والأذكار اليومية"
        let categories = "الفئات"
        let dua = "دعاء"
        let duaText = "النص"
        let details = "التفاصيل"
        let shareDua = "مشاركة الدعاء"
        let searchResults = "نتيجة بحث"
        let searchDuas = "ابحث في الأدعية"
        let cancelSearch = "إلغاء البحث"
        
        // Errors
        let playbackError = "خطأ في التشغيل"
        let loadError = "فشل في التحميل"
    }
    
    let strings = Strings()
    
    // MARK: - Social Media
    struct SocialMedia {
        let xTwitter = "https://x.com/dev_3zozz"
        let instagram = "https://instagram.com/dev_3zozz"
        let tiktok = "https://tiktok.com/@dev_3zozz"
        let snapchat = "https://snapchat.com/add/n.uf"
        let github = "https://github.com/azozzalfiras"
    }
    
    let socialMedia = SocialMedia()
    
    // MARK: - App Info
    let appName = "Quran Aura"
    let developerEmail = "dev@quranaura.com"
    let website = "quranaura.com"
    let appVersion = "1.0.0"
    
    // MARK: - Themes
    struct Theme {
        let name: String
        let primaryColor: Color
        let secondaryColor: Color
    }
    
    let themes: [Theme] = [
        Theme(name: "أرجواني", primaryColor: .purple, secondaryColor: .blue),
        Theme(name: "أزرق", primaryColor: .blue, secondaryColor: .cyan),
        Theme(name: "أخضر", primaryColor: .green, secondaryColor: .mint),
        Theme(name: "برتقالي", primaryColor: .orange, secondaryColor: .yellow)
    ]
    
    private init() {}
}

// MARK: - Extension for convenient access
extension Color {
    static let appPrimary = AppConfig.shared.primaryColor
    static let appSecondary = AppConfig.shared.secondaryColor
    static let appAccent = AppConfig.shared.accentColor
    static let appBackground = AppConfig.shared.backgroundColor
    static let appCardBackground = AppConfig.shared.cardBackground
}
