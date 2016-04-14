import ResearchKit

public var ConsentTask: ORKOrderedTask {
  
  var steps = [ORKStep]()
  
  let consentDocument = ConsentDocument
  let visualConsentStep = ORKVisualConsentStep(identifier: "VisualConsentStep", document: consentDocument)
  steps += [visualConsentStep]
  
  let signature = consentDocument.signatures!.first
  let reviewConsentStep = ORKConsentReviewStep(identifier: "ConsentReviewStep", signature: signature, inDocument: consentDocument)
  
  reviewConsentStep.text = "Review Consent!"
  reviewConsentStep.reasonForConsent = "Consent to join study"
  
  steps += [reviewConsentStep]
  
  return ORKOrderedTask(identifier: "ConsentTask", steps: steps)
}
