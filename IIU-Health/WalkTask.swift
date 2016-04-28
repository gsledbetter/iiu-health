import ResearchKit

public var WalkTask: ORKOrderedTask {
    return ORKOrderedTask.fitnessCheckTaskWithIdentifier("WalkTask",
                                                         intendedUseDescription: nil,
                                                         walkDuration: 10 as NSTimeInterval,
                                                         restDuration: 5 as NSTimeInterval,
                                                         options: .None)
}