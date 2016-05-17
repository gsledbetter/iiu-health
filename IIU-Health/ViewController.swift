import ResearchKit
import SwiftyJSON

class ViewController: UIViewController, ORKTaskViewControllerDelegate {
    
    var taskResultsStore:TaskResultsStore

    
    required init(coder aDecoder: NSCoder) {
        
        taskResultsStore = TaskResults.sharedInstance.taskResultsStore
        super.init(coder: aDecoder)!
    
    }
    
    override func viewDidLoad() {
        self.title = "IIU Health"
//        if let storedTaskResultsStore = loadTaskResults() {
//            taskResultsStore = storedTaskResultsStore
//        } else {
//            taskResultsStore = TaskResultsStore()
//        }
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
            TaskResults.sharedInstance.saveTaskResults()
            
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
    
    
//    // MARK: NSCoding
//    
//    func saveTaskResults() {
//        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(taskResultsStore, toFile: TaskResultsStore.ArchiveURL.path!)
//        if !isSuccessfulSave {
//            print("Failed to save task results...")
//        }
//    }
//    
//    func loadTaskResults() -> TaskResultsStore? {
//        print("Loading Task Results from file \(TaskResultsStore.ArchiveURL.path!)")
//        if let savedTaskResults = NSKeyedUnarchiver.unarchiveObjectWithFile(TaskResultsStore.ArchiveURL.path!) as? TaskResultsStore {
//            return savedTaskResults
//        }
//        return nil
//    }
//    
//
    
    
}
