//
//  HealthStore.swift
//  Healthify
//
//  Created by Blessy Elizabeth Saini on 27/03/2022.
//

import Foundation
import HealthKit

class HealthStore {
    var healthStore: HKHealthStore?
    var isAuthorizationSuccess: Bool?
    private let stepsQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
    var query: HKStatisticsCollectionQuery?
    init() {
        if HKHealthStore.isHealthDataAvailable() {
            healthStore = HKHealthStore()
        }
    }
    
    /// Seeks permission from user to track the health details
    /// - Parameter completion: returns true of false 
    func requestForPermission(completion:@escaping(Bool) ->Void) {
        // Access Step Count
        let healthKitTypes: Set = [ HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)! ]
       
        // Check for Authorization
        guard let healthStore = self.healthStore else {
            return completion(false)
        }

        healthStore.requestAuthorization(toShare: [], read: healthKitTypes) { (bool, error) in
            if (bool) {
                
                completion(bool)
                
            } // end if
        } // end of checking authorization
    
    }
    
    /// Retrieves the list of steps for the days of the month untill Today
    /// - Parameter completion: contains the statistics for the number of steps and returns steps with date
    func importStepsHistory(completion: @escaping(HKStatistics)->()) {
        let now = Date()
        let firstDateOfMonth = Date().startOfMonth()
        let difference = Date().daysBetweenDates(startDate: firstDateOfMonth, endDate: now)
        let startDate = Calendar.current.date(byAdding: .day, value: -difference, to: now)!
        var interval = DateComponents()
        interval.day = 1
        var anchorComponents = Calendar.current.dateComponents([.day, .month, .year], from: now)
        anchorComponents.hour = 0
        let anchorDate = Calendar.current.date(from: anchorComponents)!
        let query = HKStatisticsCollectionQuery(
            quantityType: stepsQuantityType,
            quantitySamplePredicate: nil,
            options: [.cumulativeSum],
            anchorDate: anchorDate,
            intervalComponents: interval
        )
        query.initialResultsHandler = { _, results, error in
            guard let results = results else {return}
        
            results.enumerateStatistics(from: startDate, to: now) { statistics, _ in
                
                completion(statistics)

            }
        }
        healthStore?.execute(query)
    }
    
}
