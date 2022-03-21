//
//  Helper.swift
//  AstraDemo
//
//  Created by cuong on 3/18/22.
//

import AstraLib

class Helper {
    
    static var isPurchasedPremium: Bool {
        #if DEBUG
        return PurchaseProduct.isPurchasedPremium
        #else
        return PurchaseProduct.isPurchasedPremium
        #endif
    }
}
