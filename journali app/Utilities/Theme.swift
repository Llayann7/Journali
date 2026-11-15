import SwiftUI

/// ألوان التصميم (Assets → 01 Colors) — القيم نفسها محفوظة كـ Color Sets في Assets.xcassets
enum Theme {
    /// Text / Accent — #AF99FD: عناوين الجورنال وعنوان الـ Empty State
    static let accent = Color(.accentText)
    /// Primary / Accent — #7F81FF: زر الحفظ والأكشنات
    static let primaryAccent = Color(.primaryAccent)
    /// Text / Primary — #FFFFFF: العناوين الرئيسية ومحتوى الجورنال
    static let primaryText = Color(.primaryText)
    /// Text / Secondary — #A39A9A: التواريخ
    static let secondaryText = Color(.secondaryText)
    /// Surface / Card — #1C1C1E: كروت الجورنال
    static let card = Color(.cardSurface)
    /// Background / Primary — #000000
    static let background = Color(.backgroundPrimary)
    /// Semantic / Destructive — #FD453C: الحذف
    static let destructive = Color(.destructive)
}
