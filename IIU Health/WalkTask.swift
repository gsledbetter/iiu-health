import ResearchKit

public var WalkTask: ORKOrderedTask {
    return ORKOrderedTask.fitnessCheckTaskWithIdentifier("WalkTask",
                                                         intendedUseDescription: nil,
                                                         walkDuration: 30 as NSTimeInterval,
                                                         restDuration: 30 as NSTimeInterval,
                                                         options: .None)
}