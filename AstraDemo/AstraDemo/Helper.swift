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
        return CTPurchaseProduct.isPurchasedPremium
        #else
        return CTPurchaseProduct.isPurchasedPremium
        #endif
    }
}
