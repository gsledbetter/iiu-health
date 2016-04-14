import ResearchKit

public var ConsentDocument: ORKConsentDocument {
  
  let consentDocument = ORKConsentDocument()
  consentDocument.title = "Example Consent"
  
  let consentSectionTypes: [ORKConsentSectionType] = [
    .Overview,
    .DataGathering,
    .Privacy,
    .DataUse,
    .TimeCommitment,
    .StudySurvey,
    .StudyTasks,
    .Withdrawing
  ]
  
  let consentSections: [ORKConsentSection] = consentSectionTypes.map { contentSectionType in
    let consentSection = ORKConsentSection(type: contentSectionType)
    consentSection.summary = "If you wish to complete this study..."
    consentSection.content = "In this study you will be asked to complete a walking task. Your heart rate will be measured and then you will asked to complete a survey."
    return consentSection
  }
  
  consentDocument.sections = consentSections
  
  consentDocument.addSignature(ORKConsentSignature(forPersonWithTitle: nil, dateFormatString: nil, identifier: "ConsentDocumentParticipantSignature"))
  
  return consentDocument
}
