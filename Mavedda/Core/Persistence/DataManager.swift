//
//  DataManager.swift
//  Finance
//
//  Created by Halil İbrahim Direktör on 2.04.2025.
//

import Foundation
import Combine

@MainActor
class DataManager: ObservableObject {
    @Published var transactions: [Transaction] = []
    @Published var cumulativeIncome: Double = 0.0
    @Published var cumulativeExpense: Double = 0.0
    @Published var netBalance: Double = 0.0
    @Published var enduranceDaysString: String = ""
    @Published var errorMessage: String? = nil

    private let userDefaults = UserDefaults.standard
    private var cancellables = Set<AnyCancellable>()
    private let calendar = Calendar.current

    private let commonDescriptions: [String] = [
        "Market Alışverişi", "Fatura Ödemesi", "Maaş", "Kira", "Restoran",
        "Benzin", "Eğlence", "Diğer", "Ulaşım", "Gıda", "Sağlık", "Eğitim"
    ]

    init() {
        loadData()
        setupObservers()
    }

    private func setupObservers() {
        $transactions
            .dropFirst()
            .sink { [weak self] _ in self?.recalculateAndSave() }
            .store(in: &cancellables)
    }

    func addTransaction(type: TransactionType, amount: Double, description: String, date: Date, company: String? = nil, companyLogo: String? = nil) {
        guard amount > 0 else { return }
        let newTransaction = Transaction(type: type, amount: amount, description: description, date: date, company: company, companyLogo: companyLogo)
        transactions.append(newTransaction)
        transactions.sort { $0.date > $1.date }
    }

    func deleteTransaction(at offsets: IndexSet) {
        transactions.remove(atOffsets: offsets)
    }

    func getSuggestions(for text: String) -> [String] {
        guard !text.isEmpty else { return [] }
        return commonDescriptions.filter { $0.localizedCaseInsensitiveContains(text) }
    }

    private func recalculateAndSave() {
        calculateSummary()
        saveData()
    }

    private func calculateSummary() {
        cumulativeIncome = transactions.filter { $0.type == .income }.reduce(0) { $0 + $1.amount }
        cumulativeExpense = transactions.filter { $0.type == .expense }.reduce(0) { $0 + $1.amount }
        netBalance = cumulativeIncome - cumulativeExpense
        calculateEnduranceDays()
    }

    public func calculateEnduranceDays() {
        guard !transactions.isEmpty else {
            enduranceDaysString = "Veri Yok"
            errorMessage = "İşlem bulunamadı."
            return
        }

        let now = Date()
        let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: now))!
        let daysInMonth = calendar.range(of: .day, in: .month, for: startOfMonth)!.count

        let totalMonthlyIncome = transactions
            .filter { $0.type == .income && calendar.isDate($0.date, equalTo: startOfMonth, toGranularity: .month) }
            .reduce(0.0) { $0 + $1.amount }

        let totalMonthlyExpense = transactions
            .filter { $0.type == .expense && calendar.isDate($0.date, equalTo: startOfMonth, toGranularity: .month) }
            .reduce(0.0) { $0 + $1.amount }

        guard totalMonthlyExpense > 0 else {
            enduranceDaysString = "Gideriniz Yok"
            errorMessage = "Gideriniz Yok"
            return
        }

        let dailyExpense = totalMonthlyExpense / Double(daysInMonth)
        let remainingAmount = totalMonthlyIncome - totalMonthlyExpense
        let remainingDays = remainingAmount / dailyExpense // Küsuratlı değer

        let formattedRemainingDays = String(format: "%.2f", remainingDays) // 2 ondalık basamak

        if remainingDays > 0 {
            if remainingDays < 30 {
                enduranceDaysString = "\(formattedRemainingDays) gün"
            } else {
                enduranceDaysString = "\(formattedRemainingDays) gün\n~" + formatDaysToYearsMonthsDays(days: Int(remainingDays))
            }
        } else {
            enduranceDaysString = "\(formattedRemainingDays) gün\n~" + formatDaysToYearsMonthsDays(days: Int(abs(remainingDays)))
        }
        errorMessage = nil
    }

    private func formatDaysToYearsMonthsDays(days: Int) -> String {
        let years = days / 365
        let remainingDaysAfterYears = days % 365
        let months = remainingDaysAfterYears / 30
        let remainingDays = remainingDaysAfterYears % 30

        var formattedString = ""
        if years > 0 {
            formattedString += "\(years) yıl "
        }
        if months > 0 {
            formattedString += "\(months) ay "
        }
        if remainingDays > 0 {
            formattedString += "\(remainingDays) gün"
        }

        return formattedString.isEmpty ? "0 gün" : formattedString.trimmingCharacters(in: .whitespaces)
    }

    func calculateThisMonthExpenses() -> Double {
        let now = Date()
        let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: now))!
        let endOfMonth = calendar.date(byAdding: DateComponents(month: 1, day: -1), to: startOfMonth)!

        return transactions
            .filter { $0.type == .expense && $0.date >= startOfMonth && $0.date <= endOfMonth }
            .reduce(0.0) { total, transaction in total + transaction.amount }
    }

    // MARK: - Previous Month Calculations

    // Önceki aya ait başlangıç ve bitiş tarihlerini hesaplar
    private func getPreviousMonthDates() -> (start: Date, end: Date) {
        let now = Date()
        let components = DateComponents(month: -1)
        guard let previousMonth = calendar.date(byAdding: components, to: now),
              let startOfPreviousMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: previousMonth)) else {
            return (Date.distantPast, Date.distantPast) // Hata durumunda
        }
        let endOfPreviousMonth = calendar.date(byAdding: DateComponents(month: 1, day: -1), to: startOfPreviousMonth)!
        return (start: startOfPreviousMonth, end: endOfPreviousMonth)
    }

    // Önceki aya ait geliri hesaplar
    func calculatePreviousMonthIncome() -> Double {
        let (start, end) = getPreviousMonthDates()
        return transactions
            .filter { $0.type == .income && $0.date >= start && $0.date <= end }
            .reduce(0.0) { $0 + $1.amount }
    }

    // Önceki aya ait gideri hesaplar
    func calculatePreviousMonthExpense() -> Double {
        let (start, end) = getPreviousMonthDates()
        return transactions
            .filter { $0.type == .expense && $0.date >= start && $0.date <= end }
            .reduce(0.0) { $0 + $1.amount }
    }

    // Yüzde değişimi hesaplar
    func calculatePercentageChange(current: Double, previous: Double) -> Double? {
        guard previous != 0 else {
            if current == 0 {
                return 0 // Her ikisi de sıfırsa, değişim yok
            } else {
                return nil // Belirsiz veya tanımsız değişim
            }
        }
        return ((current - previous) / previous) * 100
    }

    private func saveData() {
        do {
            let encodedData = try JSONEncoder().encode(transactions)
            userDefaults.set(encodedData, forKey: Constants.UserDefaultsKeys.transactions)
            print("Transactions saved successfully.")
        } catch {
            print("Error saving transactions: \(error)")
        }
    }

    private func loadData() {
        guard let data = userDefaults.data(forKey: Constants.UserDefaultsKeys.transactions),
              let decodedTransactions = try? JSONDecoder().decode([Transaction].self, from: data) else {
            print("No saved transaction data found or decoding error.")
            resetData()
            return
        }
        transactions = decodedTransactions
        calculateSummary()
        print("Transactions loaded successfully. Count: \(transactions.count)")
    }

    private func resetData() {
        transactions = []
        cumulativeIncome = 0.0
        cumulativeExpense = 0.0
        netBalance = 0.0
        enduranceDaysString = ""
    }
}
