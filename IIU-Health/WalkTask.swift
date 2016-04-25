import ResearchKit

public var WalkTask: ORKOrderedTask {
    return ORKOrderedTask.fitnessCheckTaskWithIdentifier("WalkTask",
                                                         intendedUseDescription: nil,
                                                         walkDuration: 10 as NSTimeInterval,
                                                         restDuration: 2 as NSTimeInterval,
                                                         options: .None)
}