import UIKit
import CoreData

class ClientTableViewController: UITableViewController {
    
    var clients: [Client] = []
    var managedContext: NSManagedObjectContext?
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        managedContext = appDelegate!.persistentContainer.viewContext
        refreshTable()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        refreshTable()
    }
    
    
    // use prepare for segue below to send client data to next view controller
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ClientName" {
        }
    }*/
    
    func loadClients() {
        
        let fetchRequest = NSFetchRequest<Client>(entityName: "Client")
        
        do {
            clients = try managedContext!.fetch(fetchRequest)
        } catch {
            print("Error fetching data because \(error)")
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClientCell")!
        let client = clients[indexPath.row]
        cell.textLabel?.text = client.name
        cell.detailTextLabel?.text = ""
        return cell
    }
    
    override func tableView(_ tableview: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clients.count
    }
    
    
    //swipe to delete function
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            //warns user they are about to delete client
            let alert = UIAlertController(title: "Delete Client", message: "Are you sure you want to delete this client?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("Yes", comment: "Yes Action"), style: .default, handler: { _ in
                
                let row = indexPath.row
                let client = self.clients[row]
                self.managedContext!.delete(client)
                
                do {
                    try self.managedContext!.save()
                } catch {
                    print("Error deleting \(error)")
                }
                self.refreshTable()
                
            }
            ))
            alert.addAction(UIAlertAction(title: NSLocalizedString("No", comment: "No Action"), style: .default, handler: { _ in NSLog("The no alert occured.")
            }))
            self.present(alert, animated: true, completion: nil)
            
        }
    }

    
    func refreshTable() {
        loadClients()
        tableView.reloadData()
    }
    
    func deleteSelectedClient() {
        guard let selectedPath = tableView.indexPathForSelectedRow else {return}
        let row = selectedPath.row
        
        let client = clients[row]
        
        managedContext!.delete(client)
        
        do {
            try managedContext!.save()
        } catch {
            print("Error deleting \(error)")
        }
    }
}

