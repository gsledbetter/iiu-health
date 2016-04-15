import Foundation
import HealthKit

class HealthKitManager: NSObject {
    
    static let hkStore = HKHealthStore()
    static var timer: NSTimer?
    
    static func authorizeHealthKit() {
        
        let healthKitTypes: Set = [
            HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierHeartRate)!,
            HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDistanceWalkingRunning)!
        ]
        
        hkStore.requestAuthorizationToShareTypes(healthKitTypes,
                                                        readTypes: healthKitTypes) { _, _ in }
    }
    
    static func saveMockHeartData() {
        
        // create a heart rate BPM Sample
        let heartRateType = HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierHeartRate)!
        let heartRateQuantity = HKQuantity(unit: HKUnit(fromString: "count/min"), doubleValue: Double(arc4random_uniform(80) + 100))
        let heartSample = HKQuantitySample(type: heartRateType,
                                           quantity: heartRateQuantity, startDate: NSDate(), endDate: NSDate())
        
        // save sample to store
        hkStore.saveObject(heartSample, withCompletion: { (success, error) -> Void in
            if let error = error {
                print("Error saving heart sample: \(error.localizedDescription)")
            }
        })
    }
    
    static func startMockHeartData() {
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0,
                                                       target: self,
                                                       selector: #selector(saveMockHeartData),
                                                       userInfo: nil,
                                                       repeats: true)
    }
    
    static func stopMockHeartData() {
        self.timer?.invalidate()
    }
}
