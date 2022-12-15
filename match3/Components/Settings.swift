//
//  Settings.swift
//  BetCalculator
//
//  Created by Игорь Майсюк on 10.11.22.
//

import SwiftUI

final class Settings: ObservableObject {
    private let defaults: UserDefaults = .standard
    
    let totalLevels = 1...12
    
    @AppStorage("selected_bg") var selectedBackground: String = "background"
    
    var unlockedLevels: Set<Int> {
        get {
            guard let data = defaults.data(forKey: "levels") else { return [1] }
            let result = try? JSONDecoder().decode(Set<Int>.self, from: data)
            return result ?? [1]
        }
        set {
            guard let data = try? JSONEncoder().encode(newValue) else { return }
            defaults.set(data, forKey: "levels")
        }
    }
    
    var unlockedBackgrounds: Set<String> {
        get {
            guard let data = defaults.data(forKey: "unlocked_bg") else { return [] }
            let result = try? JSONDecoder().decode(Set<String>.self, from: data)
            return result ?? []
        }
        set {
            guard let data = try? JSONEncoder().encode(newValue) else { return }
            defaults.set(data, forKey: "unlocked_bg")
        }
    }
    
    func unlockLevel(_ level: Int) {
        self.unlockedLevels.insert(level)
    }
}
