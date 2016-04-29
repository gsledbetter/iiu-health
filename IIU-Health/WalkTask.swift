import ResearchKit

public var WalkTask: ORKOrderedTask {
    return ORKOrderedTask.fitnessCheckTaskWithIdentifier("WalkTask",
                                                         intendedUseDescription: nil,
                                                         walkDuration: 60 as NSTimeInterval,
                                                         restDuration: 10 as NSTimeInterval,
                                                         options: .None)

}