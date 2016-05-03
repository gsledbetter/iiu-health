import ResearchKit

let FitnessCheckTaskId = "FitnessCheckTask"

public var FitnessCheckTask: ORKOrderedTask {
    return ORKOrderedTask.fitnessCheckTaskWithIdentifier(FitnessCheckTaskId,
                                                         intendedUseDescription: nil,
                                                         walkDuration: 60 as NSTimeInterval,
                                                         restDuration: 10 as NSTimeInterval,
                                                         options: .None)

}