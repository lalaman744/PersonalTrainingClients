import UIKit
import CoreData


class ClientDataViewController: UITableViewController {
    
    var clients: [Client] = []
    
    var managedContext: NSManagedObjectContext?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        managedContext = appDelegate!.persistentContainer.viewContext
        refreshTable()
    }
    
    //accept client information from prepare for segue
    //Setup swipe to delete function like in initial view controller
    
    
    
    
    func loadClientDetails() {
        
        let fetchRequest = NSFetchRequest<Client>(entityName: "Client")
        
        do {
            clients = try managedContext!.fetch(fetchRequest)
        } catch {
            print("Error fetching data because \(error)")
        }
    }
    
    func refreshTable() {
        loadClientDetails()
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClientDetailCell")!
        let client = clients[indexPath.row]
        cell.textLabel?.text = client.workout
        cell.detailTextLabel?.text = ""
        return cell
    }
    
    override func tableView(_ tableview: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clients.count
    }
    
    
}
