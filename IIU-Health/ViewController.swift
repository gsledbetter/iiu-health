import ResearchKit

class ViewController: UIViewController, ORKTaskViewControllerDelegate {
    
    @IBAction func consentTapped(sender : AnyObject) {
        let taskViewController = ORKTaskViewController(task: ConsentTask, taskRunUUID: nil)
        taskViewController.delegate = self
        presentViewController(taskViewController, animated: true, completion: nil)
    }
    
    @IBAction func surveyTapped(sender : AnyObject) {
        let taskViewController = ORKTaskViewController(task: SurveyTask(), taskRunUUID: nil)
        taskViewController.delegate = self
        presentViewController(taskViewController, animated: true, completion: nil)
    }
    
    @IBAction func microphoneTapped(sender : AnyObject) {
        let taskViewController = ORKTaskViewController(task: MicrophoneTask, taskRunUUID: nil)
        taskViewController.delegate = self
        taskViewController.outputDirectory = NSURL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0], isDirectory: true)
        presentViewController(taskViewController, animated: true, completion: nil)
    }
    
    @IBAction func authorizeTapped(sender: AnyObject) {
        HealthKitManager.authorizeHealthKit()
    }
    
    @IBAction func walkTapped(sender: AnyObject) {
        let taskViewController = ORKTaskViewController(task: WalkTask, taskRunUUID: nil)
        taskViewController.delegate = self
        taskViewController.outputDirectory = NSURL(fileURLWithPath:
            NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0],
                                                   isDirectory: true)
        presentViewController(taskViewController, animated: true, completion: nil)
        //HealthKitManager.startMockHeartData()
    }
    
    func taskViewController(taskViewController: ORKTaskViewController, didFinishWithReason reason: ORKTaskViewControllerFinishReason, error: NSError?) {
        
        //HealthKitManager.stopMockHeartData()
        if (taskViewController.task?.identifier == "WalkTask"
            && reason == .Completed) {
            
            let heartURLs = ResultParser.findWalkHeartFiles(taskViewController.result)
            
            for url in heartURLs {
                do {
                    let string = try NSString.init(contentsOfURL: url, encoding: NSUTF8StringEncoding)
                    print(string)
                } catch {}
            }
        }
        if (reason != .Failed) {
            taskViewController.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    
}
