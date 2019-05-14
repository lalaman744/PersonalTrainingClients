import UIKit
import CoreData

class SessionDetailViewController: UIViewController {
    
    var clients: [Client] = []
    var managedContext: NSManagedObjectContext?
    
    //decide if session number is staying or not in CoreData
    //set up segue modally to prevent back button from showing up
    
    
    @IBOutlet var sessionNumberTextBox: UITextField!
    @IBOutlet var workoutTextBox: UITextField!
    
    @IBAction func dismissKeyboard(_ sender: Any) {
        sessionNumberTextBox.resignFirstResponder()
        workoutTextBox.resignFirstResponder()
    }
    
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        saveSessionData()
    }
    
    func saveSessionData() {
        
        let client = Client(context: managedContext!)
        client.workout = workoutTextBox.text
        //client.session = sessionNumberTextBox.text
        do {
            try managedContext!.save()
        } catch {
            print("Error saving, \(error)")
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        managedContext = appDelegate!.persistentContainer.viewContext
    }
}
