//
//  ShoutOutEditorViewController.swift
//  ShoutOut

import CoreData
import UIKit

class ShoutOutEditorViewController: UIViewController, ManagedObjectContextDependentType, UIPickerViewDataSource, UIPickerViewDelegate {
        
    @IBOutlet weak var toEmployeePicker: UIPickerView!
    @IBOutlet weak var shoutCategoryPicker: UIPickerView!
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var fromTextField: UITextField!
    
    var managedObjectContext: NSManagedObjectContext!
    
    let shoutCategories = [
        "Great Job!",
        "Awesome work!",
        "Excellent!",
        "Very cool!",
    ]
    
    var employees: [Employee]!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
        fetchEmployees()
        
        self.toEmployeePicker.dataSource = self
        self.toEmployeePicker.delegate = self
        self.toEmployeePicker.tag = 0
        
        self.shoutCategoryPicker.dataSource = self
        self.shoutCategoryPicker.delegate = self
        self.shoutCategoryPicker.tag = 1
        
		messageTextView.layer.borderWidth = CGFloat(0.5)
        messageTextView.layer.borderColor = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1).cgColor
		messageTextView.layer.cornerRadius = 5
		messageTextView.clipsToBounds = true
	}
    
    func fetchEmployees() {
        let employeesFetchRequest = NSFetchRequest<Employee>(entityName: Entity.employee.name)
        let primarySortDescriptor = NSSortDescriptor(key: #keyPath(Employee.lastName), ascending: true)
        let secondarySortDescriptor = NSSortDescriptor(key: #keyPath(Employee.firstName), ascending: true)
        
        employeesFetchRequest.sortDescriptors = [primarySortDescriptor, secondarySortDescriptor]
        
        do {
            self.employees = try self.managedObjectContext.fetch(employeesFetchRequest)
        } catch {
            self.employees = []
            print("Something went wrong: \(error)")
        }
    }

	@IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
		self.dismiss(animated: true, completion: nil)
	}
	
	@IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
		self.dismiss(animated: true, completion: nil)
	}
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        pickerView.tag == 0 ? self.employees.count : self.shoutCategories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 0 {
            let employee = self.employees[row]
            
            return "\(employee.firstName) \(employee.lastName)"
        } else {
            return shoutCategories[row]
        }
    }

}
