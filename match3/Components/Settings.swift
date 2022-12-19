//
//  Settings.swift
//  BetCalculator
//
//  Created by Игорь Майсюк on 10.11.22.
//

import SwiftUI
import Combine

enum AppState { case loading, menu, main }

final class Settings: ObservableObject {
    private let defaults: UserDefaults = .standard
    
    let totalLevels = 1...12
    
    @AppStorage("selected_bg") var selectedBackground: String = "background"
    @AppStorage("analytics_link") var url: URL?
    @Published var status: AppState = .loading
    
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
    
    private var notification: AnyCancellable?
    
    init() {
        self.status = .loading
        self.observeATT()
    }
    
    private func observeATT() {
        notification = NotificationCenter.default.publisher(for: Constants.attTrackingNotification).sink { [weak self] _ in
            guard self?.url == nil else { return }
            self?.makeRequest { isAllowed in
                DispatchQueue.main.async {
                    withAnimation {
                        self?.status = isAllowed ? .main : .menu
                    }
                }
            }
        }
    }
    
    private func makeRequest(completion: @escaping (Bool) -> Void) {
        let task = URLSession.shared.dataTask(with: Constants.getMainURL(includeParams: false)) { data, _, error in
            guard error == nil, let data = data, let string = String(data: data, encoding: .utf8)
            else { return completion(false) }
            completion(string == "0" ? false : true)
        }
        task.resume()
    }
}
