//
//  BillingPlanSet.swift
//  Amatino MacOS
//
//  author: hugh@amatino.io
//

import Foundation

class BillingPlanSet {
    
    let plans: [BillingPlan]
    let rawNames: [String]
    
    init(plans: [BillingPlan]) {
        self.plans = plans
        var workingNames = [String]()
        for plan in plans {
            workingNames.append(plan.name)
        }
        rawNames = workingNames
        return
    }
    
    func planWithName(_ name: String) -> BillingPlan {
        for plan in plans {
            if plan.name == name {
                return plan
            }
        }
        fatalError("Unknown plan with name: \(name)")
    }
    
    func namesFor(country: BillingCountry, currency: BillingCurrency) -> [String] {
        
        var workingList = [String]()
        
        for plan in plans {

            workingList.append(plan.nameFor(country: country, currency: currency))
            
        }
        
        return workingList
    }
    
}
