import ResearchKit

let SurveyTaskId = "SurveyTaskId"

public class SurveyTask: NSObject, ORKTask {
    
    let introStepID = "intro_step"
    let countStepID = "count_step"
    let feelingStepID = "feeling_step"
    let summaryStepID = "summary_step"
    
    public var identifier: String { get { return SurveyTaskId} }
    
    public func stepBeforeStep(step: ORKStep?, withResult result: ORKTaskResult) -> ORKStep? {
        
        switch step?.identifier {
        case .Some(countStepID):
            return stepWithIdentifier(introStepID)
            
        case .Some(feelingStepID):
            return stepWithIdentifier(countStepID)
            
        case .Some(summaryStepID):
            return stepWithIdentifier(feelingStepID)
            
        default:
            return nil
        }
    }
    
    public func stepAfterStep(step: ORKStep?, withResult result: ORKTaskResult) -> ORKStep? {
        
        switch step?.identifier {
        case .None:
            return stepWithIdentifier(introStepID)
            
        case .Some(introStepID):
            return stepWithIdentifier(countStepID)
            
        case .Some(countStepID):
            return stepWithIdentifier(feelingStepID)
            
        case .Some(feelingStepID):
            return stepWithIdentifier(summaryStepID)
            
        default:
            return nil
        }
    }
    
    public func stepWithIdentifier(identifier: String) -> ORKStep? {
        switch identifier {
            
        case introStepID:
            let instructionStep = ORKInstructionStep(identifier: introStepID)
            instructionStep.title = "After Walk Survey"
            instructionStep.text = "Answer the following questions after completing the walking task."
            return instructionStep
            
        case countStepID:
            let countAnswerFormat = ORKTextAnswerFormat(maximumLength: 20)
            countAnswerFormat.multipleLines = false
            let countQuestionStepTitle = "How many steps did you take?"
            return ORKQuestionStep(identifier: countStepID, title: countQuestionStepTitle, answer: countAnswerFormat)
            
        case feelingStepID:
            return feelingStep("")
            
            
        case summaryStepID:
            let summaryStep = ORKCompletionStep(identifier: "SummaryStep")
            summaryStep.title = "Summary"
            summaryStep.text = "Thank you for participating!"
            return summaryStep
            
        default:
            return nil
        }
    }
    
    func findCount(result: ORKTaskResult) -> String? {
        
        if let stepResult = result.resultForIdentifier(countStepID) as? ORKStepResult,
            let subResults = stepResult.results
            where subResults.count > 0,
            let textQuestionResult = subResults[0] as? ORKTextQuestionResult {
            
            return textQuestionResult.textAnswer
        }
        return nil
    }
    
    func findFeeling(result:ORKTaskResult) -> Int {
        if let stepResult = result.resultForIdentifier(feelingStepID) as? ORKStepResult,
            let subResults = stepResult.results
            where subResults.count > 0,
            let textQuestionResult = subResults[0] as? ORKChoiceQuestionResult {
            
            return textQuestionResult.choiceAnswers![0] as! Int
        }
        return 0
        

        
    }
    
    func feelingStep(name: String?) -> ORKStep {
        
        let feelingQuestionStepTitle = "How do you feel?"
        
        
        let textChoices = [
            ORKTextChoice(text: "Exhausted", value: 3),
            ORKTextChoice(text: "Slightly winded", value: 2),
            ORKTextChoice(text: "Fine", value: 1)
        ]
        let feelingAnswerFormat: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormatWithStyle(.SingleChoice, textChoices: textChoices)
        return ORKQuestionStep(identifier: feelingStepID, title: feelingQuestionStepTitle, answer: feelingAnswerFormat)
    }
}
