import ResearchKit
import SwiftyJSON

class ViewController: UIViewController, ORKTaskViewControllerDelegate {
    
    var taskResultsStore:TaskResultsStore
    
    required init(coder aDecoder: NSCoder) {
        
        taskResultsStore = TaskResultsStore()
        super.init(coder: aDecoder)!
    
    }
    
    override func viewDidLoad() {
        self.title = "IIU Health"
    }
    
    
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
    
        let taskViewController = ORKTaskViewController(task: FitnessCheckTask, taskRunUUID: nil)
        taskViewController.delegate = self
        taskViewController.outputDirectory = NSURL(fileURLWithPath:
            NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0],
                                                   isDirectory: true)
        presentViewController(taskViewController, animated: true, completion: nil)
        //HealthKitManager.startMockHeartData()
    }
    
    func taskViewController(taskViewController: ORKTaskViewController, didFinishWithReason reason: ORKTaskViewControllerFinishReason, error: NSError?) {
        
        // HealthKitManager.stopMockHeartData()
        if (taskViewController.task?.identifier == FitnessCheckTaskId && reason == .Completed) {
            
            self.taskResultsStore.storeFitnessCheckData(taskViewController.result)
            
        }

        if (reason != .Failed) {
            taskViewController.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    // MARK: - Segues
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDashboard" {
            let vc = segue.destinationViewController as! DashboardViewController
            vc.taskResultsStore = self.taskResultsStore
            
        } 
        
    }

    
}
