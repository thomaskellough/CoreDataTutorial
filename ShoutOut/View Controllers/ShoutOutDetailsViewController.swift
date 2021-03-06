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
        
        setUIValues()
        
        // Alternate to NSFetchedResultsController + delegate to show and sync data
//        NotificationCenter.default.addObserver(forName: NSNotification.Name.NSManagedObjectContextDidSave,
//                                           object: nil,
//                                           queue: nil,
//                                           using:
//        {
//            (notification: Notification) in
//            if let updatedShoutOuts = notification.userInfo?[NSUpdatedObjectsKey] as? Set<ShoutOut> {
//                self.shoutOut = updatedShoutOuts.first
//                self.setUIValues()
//            }
//        })
        
    }
//
//    deinit {
//        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.NSManagedObjectContextDidSave, object: nil)
//    }
    
    func setUIValues() {
        self.shoutCategoryLabel.text = self.shoutOut.shoutCategory
        self.messageTextView.text = self.shoutOut.message
        self.fromLabel.text = " - \(self.shoutOut.from ?? "")"
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let destinationVC = navigationController.viewControllers[0] as! ShoutOutEditorViewController
        destinationVC.managedObjectContext = self.managedObjectContext
        destinationVC.shoutOut = self.shoutOut
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
