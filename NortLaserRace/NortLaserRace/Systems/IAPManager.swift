//
//  IAPManager.swift
//  NortLaserRace
//
//  Created by Alumne on 20/5/21.
//

import Foundation
import StoreKit
enum Skin: String {
    case tentacle = "com.blackrefactory.NortLaserRace.Avatar_B1_Tentacle"
    case metroid = "com.blackrefactory.NortLaserRace.Avatar_B1_Metroid"
    case suspicious = "com.blackrefactory.NortLaserRace.Avatar_B1_Suspicious"
}

public class IAPManager: NSObject, SKPaymentTransactionObserver {
    let userDefaults: UserDefaults = UserDefaults.standard
    public var catalogDictionary: [String: Bool] =  [
        Skin.tentacle.rawValue : false,
        Skin.metroid.rawValue: false,
        Skin.suspicious.rawValue: false
    ]
    public override init() {
        super.init()
        SKPaymentQueue.default().add(self)
        let localSkins = userDefaults.dictionary(forKey: SaveManager.getSkinsCollectionKey())
        if localSkins == nil { return }
        for (key, value) in localSkins! {
            if catalogDictionary[key] != nil {
                if (value as? Bool)!{
                    catalogDictionary[key]! = true
                }
            }
        }
    }
    public func avatarUnlocked(skinID: String) -> Bool {
        if catalogDictionary[skinID] != nil {
            return catalogDictionary[skinID]!
        }
        return false
    }
    public func buyNonConsumable(product: String) {
        let payment = SKMutablePayment()
        guard self.catalogDictionary[product] != nil else { return }
        payment.productIdentifier = product
        SKPaymentQueue.default().add(payment)
    }
    public func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        transactions.forEach { transaction in
            if transaction.transactionState == .purchased {
                print("Purchased succed")
                print(transaction.payment.productIdentifier)
                catalogDictionary.forEach({ (key, value) in
                    if key == transaction.payment.productIdentifier {
                        catalogDictionary[key] = true
                        print("\(key) is unlocked")
                    }
                })
                userDefaults.setValue(catalogDictionary, forKey: SaveManager.getSkinsCollectionKey())
            }
        }
    }
}
