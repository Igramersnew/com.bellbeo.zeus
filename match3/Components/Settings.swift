//
//  Settings.swift
//  BetCalculator
//
//  Created by Игорь Майсюк on 10.11.22.
//

import SwiftUI
import RevenueCat

final class Settings: ObservableObject {
    private let defaults: UserDefaults = .standard
    private var products: [StoreProduct] = []
    
    let totalLevels = 1...12
    
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
    
    @AppStorage("selected_bg") var selectedBackground: String = "bg"
    
    var isLoadingFinished: Bool = false
    
    func fetchPurchases() {
        Purchases.shared.getProducts(PurchasedProduct.allCases.map { $0.id }) { [weak self] products in
            self?.products = products
        }
    }
    
    func purchase(_ product: PurchasedProduct, completion: @escaping (Bool) -> Void) {
        guard let product = products.first(where: { $0.productIdentifier == product.id}) else { return completion(false) }
        Purchases.shared.purchase(product: product) { _, _, error, isSuccess in
            completion(error == nil && isSuccess)
        }
    }
    
    func restore(completion: @escaping (Bool) -> Void) {
        Purchases.shared.restorePurchases { purchase, info in
            if let productsIds = purchase?.allPurchasedProductIdentifiers {
                self.unlockedBackgrounds = productsIds
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
}

enum PurchasedProduct: String, CaseIterable {
    case card
    case space
    case red
    case black
    
    var title: String {
        rawValue.capitalized + " Background"
    }
    
    var id: String {
        "com.fortunes.\(rawValue)"
    }
}
