import SwiftUI
import Combine

class MoodViewModel: ObservableObject {
    @Published var selectedMood: Mood = .neutral
    @Published var savedMood: Mood?
    @Published var moodHistory: [MoodEntry] = []

    private let savedKey = "savedMood"
    private let historyKey = "moodHistory"

    init() {
        loadMood()
        loadHistory()
    }

    func saveMood() {
        savedMood = selectedMood
        UserDefaults.standard.set(selectedMood.rawValue, forKey: savedKey)

        let entry = MoodEntry(mood: selectedMood, date: Date())
        moodHistory.append(entry)
        saveHistory()
    }

    private func loadMood() {
        if let raw = UserDefaults.standard.string(forKey: savedKey),
           let mood = Mood(rawValue: raw) {
            savedMood = mood
        }
    }

    private func loadHistory() {
        if let data = UserDefaults.standard.data(forKey: historyKey) {
            if let decoded = try? JSONDecoder().decode([MoodEntry].self, from: data) {
                moodHistory = decoded
            }
        }
    }

    private func saveHistory() {
        if let data = try? JSONEncoder().encode(moodHistory) {
            UserDefaults.standard.set(data, forKey: historyKey)
        }
    }
    
    func clearHistory() {
        moodHistory.removeAll()
        UserDefaults.standard.removeObject(forKey: historyKey)
    }
}
