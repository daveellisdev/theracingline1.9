//
//  StoreManager.swift
//  theracingline
//
//  Created by Dave on 03/03/2023.
//

import Foundation
import StoreKit
import SwiftUI
import TPInAppReceipt

class StoreManager: NSObject, ObservableObject, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    
    static var shared = StoreManager()

    @ObservedObject var dc = DataController.shared
    @ObservedObject var nc = NotificationController.shared
    @Published var subscribed = false

    //FETCH PRODUCTS
    var request: SKProductsRequest!
    
    @Published var myProducts = [SKProduct]()
    
    func getProducts(productIDs: [String]) {
//        print("Start requesting IAP products...")
        let request = SKProductsRequest(productIdentifiers: Set(productIDs))
        request.delegate = self
        request.start()
    }
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
//        print("Did receive list of IAPs")
        
        if !response.products.isEmpty {
//            print("\(response.products.count) IAP Found")
            for fetchedProduct in response.products {
//                print("IAP Found")
//                print(fetchedProduct.localizedTitle)
                DispatchQueue.main.async {
                    self.myProducts.append(fetchedProduct)
                }
            }
        }
//        print("\(response.invalidProductIdentifiers.count) invalid IAP Found")
        for invalidIdentifier in response.invalidProductIdentifiers {
            print("Invalid identifiers found: \(invalidIdentifier)")
        }
    }
    
    func request(_ request: SKRequest, didFailWithError error: Error) {
        print("Request did fail: \(error)")
    }
    
    //HANDLE TRANSACTIONS
    @Published var transactionState: SKPaymentTransactionState?
    
    func purchaseProduct(product: SKProduct) {
        if SKPaymentQueue.canMakePayments() {
            let payment = SKPayment(product: product)
            SKPaymentQueue.default().add(payment)
        } else {
            print("User can't make payment.")
        }
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchasing:
                transactionState = .purchasing
            case .purchased:
                UserDefaults.standard.setValue(true, forKey: transaction.payment.productIdentifier)
                queue.finishTransaction(transaction)
                transactionState = .purchased
                self.subscribed = true
                NotificationController().initiateNotifications()
            case .restored:
                UserDefaults.standard.setValue(true, forKey: transaction.payment.productIdentifier)
                queue.finishTransaction(transaction)
                transactionState = .restored
                self.subscribed = true
                NotificationController().initiateNotifications()
            case .failed, .deferred:
                print("Payment Queue Error: \(String(describing: transaction.error))")
                queue.finishTransaction(transaction)
                transactionState = .failed
            default:
                queue.finishTransaction(transaction)
            }
        }
    }
    
    func updateUserAccess(productIdentifier: String) {
        switch productIdentifier {
        case "dev.daveellis.theracingline.bronze":
            self.subscribed = false
        case "dev.daveellis.theracingline.silver":
            self.subscribed = false
        case "dev.daveellis.theracingline.gold":
            self.nc.requestPermission()
            self.subscribed = true
        case "dev.daveellis.theracingline.annual":
            self.subscribed = true
        case "dev.daveellis.theracingline.coffee":
            print("Coffee purchased")
        default:
            self.subscribed = false
        }
    }
    
    func restoreSubscriptionStatus() {
        InAppReceipt.refresh { (error) in
            if let err = error {
                self.subscribed = false
                print(err)
            } else {
            // do your stuff with the receipt data here
                if let receipt = try? InAppReceipt.localReceipt(){
                    if receipt.hasActiveAutoRenewableSubscription(ofProductIdentifier: "dev.daveellis.theracingline.annual", forDate: Date()) {
                        // user has subscription of the product, which is still active at the specified date
                        self.subscribed = true
                        print("============= Annual Subscription Found =============")
                        
                    } else if receipt.hasActiveAutoRenewableSubscription(ofProductIdentifier: "dev.daveellis.theracingline.gold", forDate: Date()) {
                        // user has subscription of the product, which is still active at the specified date
                        self.subscribed = true
                        print("============= Monthly Subscription Found =============")
                        
                    } else if receipt.hasActiveAutoRenewableSubscription(ofProductIdentifier: "dev.daveellis.theracingline.silver", forDate: Date()) {
                        // user has subscription of the product, which is still active at the specified date
                        self.subscribed = false
                        
                    } else if receipt.hasActiveAutoRenewableSubscription(ofProductIdentifier: "dev.daveellis.theracingline.bronze", forDate: Date()) {
                        // user has subscription of the product, which is still active at the specified date
                        self.subscribed = false
                        
                    } else {
                        self.subscribed = false
                        print("============= No Subscription Found =============")
                    }
                }
            }
        }
    }
    
    func getProductByName(productName: String) -> SKProduct {
        let subscription = self.myProducts.filter { $0.productIdentifier.contains(productName) }.first
        if subscription != nil {
            return subscription!
        } else {
            return self.myProducts[0]
        }
    }
}

extension SKProduct {
    var localizedPrice: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = priceLocale
        return formatter.string(from: price)!
    }
}