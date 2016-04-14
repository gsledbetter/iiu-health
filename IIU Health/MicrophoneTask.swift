import ResearchKit

public var MicrophoneTask: ORKOrderedTask {
  return ORKOrderedTask.audioTaskWithIdentifier("AudioTask", intendedUseDescription: "A sentence prompt will be given to you to read.", speechInstruction: "read this:", shortSpeechInstruction: "The brown fox ", duration: 10, recordingSettings: nil, options: .None)
}
