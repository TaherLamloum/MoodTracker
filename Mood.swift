//
//  Mood.swift
//  MoodTracker
//
//  Created by taher lamloum on 11/01/2026.
//

import Foundation

enum Mood: String, CaseIterable, Codable {
    case happy = "🙂 Happy"
    case neutral = "😐 Neutral"
    case sad = "😞 Sad"
}

struct MoodEntry: Identifiable, Codable {
    var id: UUID
    let mood: Mood
    let date: Date

    init(mood: Mood, date: Date = Date(), id: UUID = UUID()) {
        self.mood = mood
        self.date = date
        self.id = id
    }
}
