//
//  UpgradeToPremiumViewController.swift
//  SpamDetector
//  Copyright © 2018 astraler. All rights reserved.
//

import UIKit
import AstraLib

class UpgradeToPremiumViewController: BaseViewController {
    
    static weak var current: UpgradeToPremiumViewController?
    
    @IBOutlet weak var monthlyButton: UIButton?
    @IBOutlet weak var yearlyButton: UIButton?
    @IBOutlet weak var lifetimeButton: UIButton?
    @IBOutlet weak var closeButton: UIButton?
    
    @IBOutlet weak var closeButtonTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var monthlyTitleLabel: UILabel!
    @IBOutlet weak var monthlyPriceLabel: UILabel!
    
    @IBOutlet weak var yearlyTitleLabel: UILabel!
    @IBOutlet weak var yearlyPriceLabel: UILabel!
    
    @IBOutlet weak var lifetimePriceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UpgradeToPremiumViewController.current = self
        
        getIAPProductsInfo()
        updatePricePackages()
        
        if #available(iOS 13.0, *) {
        } else {
            if let topLayout = UIApplication.shared.keyWindow?.safeAreaInsets.top {
                closeButtonTopConstraint.constant = topLayout
            }
        }
        
    }
    
    // MARK: -
    
    private func updatePricePackages() {
        updateMonthlyPrice()
        updateYearlyPrice()
        updateLifetimePrice()
    }
    
    private func updateMonthlyPrice() {
        
        guard let _ = monthlyButton else { return }
        
        let monthly = CTPurchaseProduct.monthly
        var price = monthly.priceStringDefault
        //var currencySymbol = "$"
        
        if let product = storeKitManager.productsInfo[monthly.rawValue] {
            if let priceString = product.localizedPrice {
                price = priceString.replacingOccurrences(of: ",", with: "")
                
//                if let currencySymbolString =  product.priceLocale.currencySymbol {
//                    currencySymbol = currencySymbolString
//                }
                
//                let behavior = NSDecimalNumberHandler(roundingMode: .down, scale: 2, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
//                let monPriceNumber = product.price.dividing(by: NSDecimalNumber(decimal: 1.0), withBehavior: behavior)
//
//                let currencyFormatter = NumberFormatter()
//                        currencyFormatter.usesGroupingSeparator = true
//                        currencyFormatter.numberStyle = .currency
//                currencyFormatter.locale = product.priceLocale
//                pricePerMonth = currencyFormatter.string(from: monPriceNumber) ?? pricePerMonth
            }

            if product.hasFreeTrial {
                monthlyTitleLabel.text = "3-day free trial"
                monthlyPriceLabel.text = "then \(price) / month."
            } else {
                monthlyTitleLabel.text = "Monthly"
                monthlyPriceLabel.text = "\(price) / month."
            }
        } else {
            monthlyTitleLabel.text = "Monthly"
            monthlyPriceLabel.text = "\(price) per month"
        }
    }
    
    private func updateYearlyPrice() {
        
        guard let _ = yearlyButton else { return }
        
        let yearly = CTPurchaseProduct.yearly
        var price = yearly.priceStringDefault
        //var currencySymbol = "$"
//        var pricePerMonth = yearly.pricePerMonString
        
        if let product = storeKitManager.productsInfo[yearly.rawValue] {
            if let priceString = product.localizedPrice {
                price = priceString.replacingOccurrences(of: ",", with: "")
                
//                if let currencySymbolString =  product.priceLocale.currencySymbol {
//                    currencySymbol = currencySymbolString
//                }
                
//                let behavior = NSDecimalNumberHandler(roundingMode: .down, scale: 2, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
//                let monPriceNumber = product.price.dividing(by: NSDecimalNumber(decimal: 12.0), withBehavior: behavior)
//
//                let currencyFormatter = NumberFormatter()
//                        currencyFormatter.usesGroupingSeparator = true
//                        currencyFormatter.numberStyle = .currency
//                currencyFormatter.locale = product.priceLocale
//                pricePerMonth = currencyFormatter.string(from: monPriceNumber) ?? pricePerMonth
            }

            if product.hasFreeTrial {
                yearlyTitleLabel.text = "3-day free trial"
                yearlyPriceLabel.text = "then \(price) / year."
//                yearlyPricePerMonLabel.text = "\(pricePerMonth)/mo"
//                yearlyPriceLabel.font = UIFont.Exo2.regular(15)
            } else {
                yearlyTitleLabel.text = "Yearly"
                yearlyPriceLabel.text = "\(price) / year."
//                yearlyPricePerMonLabel.text = "\(pricePerMonth)/mo"
//                yearlyPriceLabel.font = UIFont.Exo2.bold(20)
            }
        } else {
            yearlyTitleLabel.text = "Yearly"
            yearlyPriceLabel.text = "\(price) / year."
//            yearlyPricePerMonLabel.text = "\(pricePerMonth)/mo"
//            yearlyPriceLabel.font = UIFont.Exo2.bold(20)
        }
    }
    
    private func priceFormatter(locale: Locale) -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.locale = locale
        formatter.numberStyle = .currency
        return formatter
    }
    
    private func updateLifetimePrice() {
        
        guard let lifetimeButton = lifetimeButton else { return }
        
        var price = CTPurchaseProduct.lifetime.priceStringDefault
        if let product = storeKitManager.productsInfo[CTPurchaseProduct.lifetime.rawValue] {
            if let priceString = product.localizedPrice {
                price = priceString
            }
        }
        
        lifetimeButton.setTitle(price + " / lifetime", for: .normal)
    }
    
    // MARK: -
    
    @IBAction func monthlyButtonTapped(_ sender: UIButton) {
        actionPurchase(product: .monthly)
    }
    
    @IBAction func yearlyButtonTapped(_ sender: UIButton) {
        actionPurchase(product: .yearly)
    }
    
    @IBAction func lifetimeButtonTapped(_ sender: UIButton) {
        actionPurchase(product: .lifetime)
    }
    
    
    @IBAction func restoreButtonTapped(_ sender: Any) {
        actionRestore()
    }
    
    @IBAction func privacyPolicyButtonTapped(_ sender: Any) {
//        Helper.openURL(urlString: kAppPolicyURL)
    }
    
    @IBAction func termsOfUseButtonTapped(_ sender: Any) {
//        Helper.openURL(urlString: kAppTermsOfUseURL)
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        self.dismiss(animated: true){
            //self.showInterstitial()
        }
    }
    
}


extension UpgradeToPremiumViewController {
    
    var storeKitManager: CTPurchaseKit {
        return CTPurchaseKit.shared
    }
    
    func getIAPProductsInfo() {
        let productIDs = CTPurchaseProduct.currentPremiumIDs
        storeKitManager.retrieveProductsInfo(productIDs: productIDs, completion: { [weak self] isSuccess in
            if isSuccess == true {
                self?.updatePricePackages()
            }
        })
    }
    
    func actionPurchase(product: CTPurchaseProduct) {
        print("product.title: \(product.title)")
        let productID = product.rawValue
        let completion: CTPurchaseCompletion = { success in
            if success == true {
                let vc = self.presentingViewController ?? self
                vc.dismiss(animated: true, completion: nil)
                self.trackBuyEvent(package: product)
                NotificationCenter.default.post(name: .InAppPurchase, object: product)
            }
        }
        
        if let product = storeKitManager.productsInfo[productID] {
            storeKitManager.purchaseProduct(product, completion: completion)
        } else {
            storeKitManager.purchaseProduct(productID, completion: completion)
        }
    }
    
    @objc func actionRestore() {
        
        storeKitManager.restorePurchases() { (isSuccess) in
            if isSuccess == true {
                let vc = self.presentingViewController ?? self
                vc.dismiss(animated: true, completion: nil)
                self.storeKitManager.verifyPurchaseIfNeed()
                NotificationCenter.default.post(name: .InAppPurchase, object: nil)
            }
        }
    }
    
}


extension UpgradeToPremiumViewController {
    
    static func show(from: UIViewController?) {
        
        if UpgradeToPremiumViewController.current != nil { return }
        
        let storyboard = UIStoryboard(name: "UpgradeToPremium", bundle: nil)
        if let premiumVC = storyboard.instantiateInitialViewController() as? UpgradeToPremiumViewController {
            premiumVC.modalPresentationStyle = .fullScreen
            if let fromVC = from {
                fromVC.present(premiumVC, animated: true, completion: nil)
            } else {
                var presentVC = UIApplication.shared.keyWindowScene?.rootViewController
                while (presentVC?.presentedViewController != nil) {
                    presentVC = presentVC?.presentedViewController
                }
                
                presentVC?.present(premiumVC, animated: true, completion: nil)
            }
        }
    }
    
}


// MARK: - App Events

extension UpgradeToPremiumViewController {
    
    func trackBuyEvent(package: CTPurchaseProduct) {
        
        let additionParams: TrackingParameters = [:]
        
        package.trackAdjust(additionParams: [:])
        if package.type == .subscription {
            package.trackAdjustSubscription()
        }
        
        package.trackFirebase(additionParams: additionParams)
        package.trackFacebook(additionParams: additionParams)
    }
    
    /*
    func logAttributionEvent(package: CTPurchaseProduct) {
        if let product = CTPurchaseKit.shared.productsInfo[package.rawValue], let attributionApiID = UserDefaults.standard.object(forKey: kAttributionApiID) as? String {
            
            var timePeriod: Double = 0.0
            if let timeOpen = UserDefaults.standard.object(forKey: kFirstTimeOpenApp) as? Date {
                if #available(iOS 13.0, *) {
                    timePeriod = timeOpen.distance(to: Date())
                } else {
                    timePeriod = Date().timeIntervalSince(timeOpen)
                }
            }
            let currency = product.priceLocale.currencyCode ?? "USD"
            guard let receiptUrl = Bundle.main.appStoreReceiptURL else { return }
            guard let receipt = try? Data(contentsOf: receiptUrl) else { return }
            
            var eventParams: [String: Any] = ["item_id" : package.rawValue,
                               "item_name" : package.title,
                               "contition" : storeCondition,
                               "time_to_purchase" : timePeriod,
                               "currency" : currency,
                               "receipt" : receipt]
            if selectedBrand_ != nil {
                eventParams["carmake_select"] = selectedBrand_?.name
            }
            let params: [String: Any]  = ["attribution": attributionApiID,
                          "eventName": "keyconnect_in_app_purchases",
                          "eventParams": eventParams]
            let request = APIRequestInfo.postAttributionEvent(params: params)
            APIService.postAttributionEvent(info: request) {
                //
            }
        }
    }
     */
    
}
