//
//  InAppPurchase.swift
//  theracingline
//
//  Created by Dave on 31/03/2023.
//

import Foundation
import TPInAppReceipt

extension InAppPurchase: Hashable {
    
    public static func == (lhs: InAppPurchase, rhs: InAppPurchase) -> Bool {
        return lhs == rhs
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(productIdentifier)
    }
    
    
}
