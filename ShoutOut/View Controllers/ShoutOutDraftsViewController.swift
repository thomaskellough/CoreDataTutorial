//
//  ViewController.swift
//  ShoutOut

import CoreData
import UIKit

class ShoutOutDraftsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ManagedObjectContextDependentType, NSFetchedResultsControllerDelegate {

	@IBOutlet weak var tableView: UITableView!
    
    var managedObjectContext: NSManagedObjectContext!
    var fetchedResultsController: NSFetchedResultsController<ShoutOut>!
	
	override func viewDidLoad() {
		super.viewDidLoad()
        
        configureFetchedResultsController()
        
        do {
            try self.fetchedResultsController.performFetch()
        } catch {
            let ac = UIAlertController(title: "Loading ShoutOuts Failed", message: "There was a problem with loading your ShoutOuts", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
	}
    
    func configureFetchedResultsController() {
        let shoutOutFetchRequest = NSFetchRequest<ShoutOut>(entityName: Entity.shoutOut.name)
        let lastNameSortDescriptor = NSSortDescriptor(key: #keyPath(ShoutOut.toEmployee.lastName), ascending: true)
        let firstNameSortDescriptor = NSSortDescriptor(key: #keyPath(ShoutOut.toEmployee.firstName), ascending: true)
        shoutOutFetchRequest.sortDescriptors = [lastNameSortDescriptor, firstNameSortDescriptor]
        
        self.fetchedResultsController = NSFetchedResultsController<ShoutOut>(fetchRequest: shoutOutFetchRequest, managedObjectContext: self.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        
        self.fetchedResultsController.delegate = self
    }
	
	// MARK: TableView Data Source methods
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return nil
	}
	
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = self.fetchedResultsController.sections {
            return sections[section].numberOfObjects
        }
        
        return 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "subtitleCell", for: indexPath)
        let shoutOut = self.fetchedResultsController.object(at: indexPath)
        
        cell.textLabel?.text = "\(shoutOut.toEmployee.firstName) \(shoutOut.toEmployee.lastName)"
        cell.detailTextLabel?.text = shoutOut.shoutCategory
		
		return cell
	}
	
	// MARK: TableView Delegate methods
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
	}
    
    // MARK: NSFetchedResultsController Delegate Methods
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let insertIndexPath = newIndexPath {
                self.tableView.insertRows(at: [insertIndexPath], with: .fade)
            }
        case .delete:
            if let deleteIndexPath = newIndexPath {
                self.tableView.deleteRows(at: [deleteIndexPath], with: .fade)
            }
        case .update:
            if let updateIndexPath = newIndexPath {
                let cell = self.tableView.cellForRow(at: updateIndexPath)
                let updatedShoutOut = self.fetchedResultsController.object(at: updateIndexPath)
                
                cell?.textLabel?.text = "\(updatedShoutOut.toEmployee.firstName) \(updatedShoutOut.toEmployee.lastName)"
                cell?.detailTextLabel?.text = updatedShoutOut.shoutCategory
            }
        case .move:
            if let deleteIndexPath = newIndexPath {
                self.tableView.deleteRows(at: [deleteIndexPath], with: .fade)
            }
            if let insertIndexPath = newIndexPath {
                self.tableView.insertRows(at: [insertIndexPath], with: .fade)
            }
        @unknown default:
            fatalError("Unknown type handled: \(type)")
        }
    }
	
	// MARK: - Navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "shoutOutDetails":
            let destinationVC = segue.destination as! ShoutOutDetailsViewController
            destinationVC.managedObjectContext = self.managedObjectContext
            
            let selectedIndexPath = self.tableView.indexPathForSelectedRow!
            let selectedShoutOut = self.fetchedResultsController.object(at: selectedIndexPath)
            destinationVC.shoutOut = selectedShoutOut
        case "addShoutOut":
            let navigationController = segue.destination as! UINavigationController
            let destinationVC = navigationController.viewControllers[0] as! ShoutOutEditorViewController
            destinationVC.managedObjectContext = self.managedObjectContext
        default:
            break
        }
	}
}
