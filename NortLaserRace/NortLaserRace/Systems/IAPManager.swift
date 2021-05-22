//
//  IAPManager.swift
//  NortLaserRace
//
//  Created by Alumne on 20/5/21.
//

import Foundation
import StoreKit
/*
public class IAPManager: NSObject, SKPaymentTransactionObserver {
    let cosumableProductID = "com.blackrefactory.NortLaserRace.Avatar01"
    let nonCosumableProductID = "com.blackrefactory.NortLaserRace.Avatar02"
    init() {
        SKPaymentQueue.default().add(self)
    }
    public func buyConsumable() {
        let payment = SKMutablePayment()
        payment.productIdentifier = cosumableProductID
        
        SKPaymentQueue.default().add(payment)
    }
    public func buyNonConsumable() {
        
    }
    public func paymentQueue(_ queue: SKPaymentQueue,updatedTransactions transactions: [SKPaymentTransaction]) {
        transactions.forEach { transaction in
            if transaction.transactionState != .purchased {
                print("Purchased failed")
            } else {
                print("Purchased succed")
            }
            
        }
    }
}
*/
