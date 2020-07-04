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
	
    override func viewDidLoad() {
        super.viewDidLoad()
    }
	
	// MARK: - Navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let destinationVC = navigationController.viewControllers[0] as! ShoutOutEditorViewController
        destinationVC.managedObjectContext = self.managedObjectContext
	}
}
