import Foundation

extension Date {
    /// فورماتر واحد بدل ما ننشئ واحد جديد لكل كرت
    private static let journalFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }()

    /// تاريخ الجورنال زي ما يطلع بالكرت، مثل 02/09/2024
    var journalFormatted: String {
        Date.journalFormatter.string(from: self)
    }
}
