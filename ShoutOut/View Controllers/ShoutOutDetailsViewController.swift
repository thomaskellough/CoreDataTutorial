//
//  ShoutOutDetailsViewController.swift
//  ShoutOut

import CoreData
import UIKit

class ShoutOutDetailsViewController: UIViewController, ManagedObjectContextDependentType {

    @IBOutlet weak var shoutCategoryLabel: UILabel!
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var fromLabel: UILabel!
    
    var managedObjectContext: NSManagedObjectContext!
    var shoutOut: ShoutOut!
	
    override func viewDidLoad() {
        super.viewDidLoad()
    }
	
	// MARK: - Navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let destinationVC = navigationController.viewControllers[0] as! ShoutOutEditorViewController
        destinationVC.managedObjectContext = self.managedObjectContext
	}
    
    @IBAction func deleteButtonTapped(_ sender: UIBarButtonItem) {
        let ac = UIAlertController(title: "Delete ShoutOut", message: "Are you sure you want to delete this ShoutOut?", preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.addAction(UIAlertAction(title: "I'm sure", style: .destructive, handler: { (_) -> Void in
            self.managedObjectContext.delete(self.shoutOut)
            do {
                try self.managedObjectContext.save()
            } catch {
                self.managedObjectContext.rollback()
                print("Something went wrong: \(error)")
            }
            let _ = self.navigationController?.popViewController(animated: true)
        }))
        self.present(ac, animated: true)
    }
    
}
