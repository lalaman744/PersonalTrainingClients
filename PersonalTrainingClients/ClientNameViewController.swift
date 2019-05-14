import UIKit
import CoreData


class ClientNameViewController: UIViewController {
    
    var clients: [Client] = []
    var managedContext: NSManagedObjectContext?
    
    @IBOutlet var clientNameTextBox: UITextField!
    

    @IBAction func saveButtonTapped(_ sender: Any) {
        saveNewClient()
    }
    
    func saveNewClient() {
        
        let client = Client(context: managedContext!)
        client.name = clientNameTextBox.text
        do {
            try managedContext!.save()
        } catch {
            print("Error saving, \(error)")
        }
        
        dismiss(animated: true, completion: nil)
        
        
    }
    
    @IBAction func dismissKeyboard(_ sender: Any) {
        clientNameTextBox.resignFirstResponder()
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        managedContext = appDelegate!.persistentContainer.viewContext
    }
}
