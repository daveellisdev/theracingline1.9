//
//  StoreManager.swift
//  theracingline
//
//  Created by Dave on 01/04/2023.
//

import Foundation
import StoreKit
import SwiftUI
import TPInAppReceipt
import SwiftDate


class StoreManager: NSObject, ObservableObject, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    
    @ObservedObject var dc = DataController.shared
    @ObservedObject var nc = NotificationController.shared
    @Published var monthlySub = false
    @Published var annualSub = false
    @Published var message = "message"
    @Published var message2 = "message2"
    @Published var message3 = "message3"
    @Published var iaps: [String] = []
    @Published var bunduleId = "bundleId"
    
    var subscribed: Bool {
        if monthlySub || annualSub {
            return true
        } else {
            return false
        }
    }
    
    func loadSavedSub() {
        self.monthlySub = dc.applicationSavedSettings.monthlySub
        self.annualSub = dc.applicationSavedSettings.annualSub
    }

    //FETCH PRODUCTS
    var request: SKProductsRequest!
    
    @Published var myProducts = [SKProduct]()
    
    func getProducts(productIDs: [String]) {
//        print("Start requesting IAP products...")
        self.message2 = "Start requesting IAP products..."
        let request = SKProductsRequest(productIdentifiers: Set(productIDs))
        request.delegate = self
        request.start()
    }
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
//        print("Did receive list of IAPs")
        DispatchQueue.main.async {
            self.message2 = "Did receive list of IAPs"
        }
        
        if !response.products.isEmpty {
            print("\(response.products.count) IAP Found")
            DispatchQueue.main.async {
                self.message3 = "\(response.products.count) IAP Found"
            }
            for fetchedProduct in response.products {
//                print("IAP Found")
//                print(fetchedProduct.localizedTitle)
                DispatchQueue.main.async {
                    self.iaps.append(fetchedProduct.localizedTitle)
                }
                DispatchQueue.main.async {
                    self.myProducts.append(fetchedProduct)
                }
            }
        }
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
                updateUserAccess(productIdentifier: transaction.payment.productIdentifier)
                
                /// DO STUFF AFTER PAYMENT
                
            case .restored:
                UserDefaults.standard.setValue(true, forKey: transaction.payment.productIdentifier)
                queue.finishTransaction(transaction)
                transactionState = .restored
                updateUserAccess(productIdentifier: transaction.payment.productIdentifier)
                
                /// DO STUFF AFTER RESTORE
                ///
            case .failed, .deferred:
                print("Payment Queue Error: \(String(describing: transaction.error))")
                queue.finishTransaction(transaction)
                transactionState = .failed
            default:
                queue.finishTransaction(transaction)
            }
        }
    }
    
    func restoreProducts() {
        print("Restoring products ...")
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
    func updateUserAccess(productIdentifier: String){
        switch productIdentifier {
        case "dev.daveellis.theracingline.bronze":
            /// DO NOTHING. BRONZE IS DEPRECATED
            self.annualSub = false
            self.monthlySub = false
            dc.applicationSavedSettings.monthlySub = false
            dc.applicationSavedSettings.annualSub = false
            dc.saveSavedSettings()
        case "dev.daveellis.theracingline.silver":
            /// DO NOTHING. SILVER IS DEPRECATED
            self.annualSub = false
            self.monthlySub = false
            dc.applicationSavedSettings.monthlySub = false
            dc.applicationSavedSettings.annualSub = false
            dc.saveSavedSettings()
        case "dev.daveellis.theracingline.gold":
            /// UPDATE USER ACCESS - MONTHLY SUB
            self.annualSub = false
            self.monthlySub = true
            self.nc.requestPermission()
            dc.applicationSavedSettings.monthlySub = true
            dc.applicationSavedSettings.annualSub = false
            dc.saveSavedSettings()
        case "dev.daveellis.theracingline.annual":
            /// UPDATE USER ACCESS - ANNUAL SUB
            self.annualSub = true
            self.monthlySub = false
            self.nc.requestPermission()
            dc.applicationSavedSettings.monthlySub = false
            dc.applicationSavedSettings.annualSub = true
            dc.saveSavedSettings()
        case "dev.daveellis.theracingline.coffee":
                print("Coffee purchased")
        default:
            /// DO NOTHING. NO SUB
            self.annualSub = false
            self.monthlySub = false
            dc.applicationSavedSettings.monthlySub = false
            dc.applicationSavedSettings.annualSub = false
            dc.saveSavedSettings()
        }
    }
    
    func restoreSubscriptionStatus() {
        InAppReceipt.refresh { (error) in
            if let err = error {
                print(err)
            } else {
                print("InAppReceipt Refresh with no error")
            // do your stuff with the receipt data here
                if let receipt = try? InAppReceipt.localReceipt(){
                    if receipt.hasActiveAutoRenewableSubscription(ofProductIdentifier: "dev.daveellis.theracingline.annual", forDate: Date()) {
                        // user has subscription of the product, which is still active at the specified date
                        /// UPDATE USER ACCESS - ANNUAL SUB
                        self.message = "Annual found"
                        self.annualSub = true
                        self.monthlySub = false
                        self.dc.applicationSavedSettings.monthlySub = false
                        self.dc.applicationSavedSettings.annualSub = true
                        self.dc.saveSavedSettings()
                        
                    } else if receipt.hasActiveAutoRenewableSubscription(ofProductIdentifier: "dev.daveellis.theracingline.gold", forDate: Date()) {
                        // user has subscription of the product, which is still active at the specified date
                        /// UPDATE USER ACCESS - MONTHLY SUB
                        self.message = "Monthly found"
                        self.monthlySub = true
                        self.annualSub = false
                        self.dc.applicationSavedSettings.monthlySub = true
                        self.dc.applicationSavedSettings.annualSub = false
                        self.dc.saveSavedSettings()
                        
                    } else if receipt.hasActiveAutoRenewableSubscription(ofProductIdentifier: "dev.daveellis.theracingline.silver", forDate: Date()) {
                        // user has subscription of the product, which is still active at the specified date
                        /// DO NOTHING. SILVER IS DEPRECATED
                        self.message = "Silver found"
                        self.annualSub = false
                        self.monthlySub = false
                        self.dc.applicationSavedSettings.monthlySub = false
                        self.dc.applicationSavedSettings.annualSub = false
                        self.dc.saveSavedSettings()
                        
                    } else if receipt.hasActiveAutoRenewableSubscription(ofProductIdentifier: "dev.daveellis.theracingline.bronze", forDate: Date()) {
                        // user has subscription of the product, which is still active at the specified date
                        /// DO NOTHING. BRONZE IS DEPRECATED
                        self.message = "Bronze found"
                        self.annualSub = false
                        self.monthlySub = false
                        self.dc.applicationSavedSettings.monthlySub = false
                        self.dc.applicationSavedSettings.annualSub = false
                        self.dc.saveSavedSettings()
                        
                    } else {
                        /// DO NOTHING. NO SUB
                        print("No sub")
                        self.message = "No Sub found"
                        self.annualSub = false
                        self.monthlySub = false
                        self.dc.applicationSavedSettings.monthlySub = false
                        self.dc.applicationSavedSettings.annualSub = false
                        self.dc.saveSavedSettings()
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

