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
    var shoutOut: ShoutOut!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
        fetchEmployees()
        
        let shoutOutsFetchRequest = NSFetchRequest<ShoutOut>(entityName: Entity.shoutOut.name)
        do {
            let shoutOuts = try self.managedObjectContext.fetch(shoutOutsFetchRequest)
            print(shoutOuts)
            for shoutOut in shoutOuts {
                print(shoutOut.from)
                print(shoutOut.shoutCategory)
                print(shoutOut.message)
                print("\(shoutOut.toEmployee.firstName) \(shoutOut.toEmployee.lastName)")
            }
        } catch _ {}
        
        self.toEmployeePicker.dataSource = self
        self.toEmployeePicker.delegate = self
        self.toEmployeePicker.tag = 0
        
        self.shoutCategoryPicker.dataSource = self
        self.shoutCategoryPicker.delegate = self
        self.shoutCategoryPicker.tag = 1
        
        self.shoutOut = NSEntityDescription.insertNewObject(forEntityName: Entity.shoutOut.name, into: self.managedObjectContext) as? ShoutOut
        
        
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
        self.managedObjectContext.rollback()
		self.dismiss(animated: true, completion: nil)
	}
	
	@IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        let selectedEmployeeIndex = self.toEmployeePicker.selectedRow(inComponent: 0)
        let selectedEmployee = self.employees[selectedEmployeeIndex]
        self.shoutOut.toEmployee = selectedEmployee
        
        let selectedShoutCategoryIndex = self.shoutCategoryPicker.selectedRow(inComponent: 0)
        let selectedShoutCategory = self.shoutCategories[selectedShoutCategoryIndex]
        self.shoutOut.shoutCategory = selectedShoutCategory
        
        self.shoutOut.message = self.messageTextView.text
        self.shoutOut.from = self.fromTextField.text ?? "Anonymous"
        
        do {
            try self.managedObjectContext.save()
            self.dismiss(animated: true, completion: nil)
        } catch {
            let ac = UIAlertController(title: "Trouble Saving", message: "Something with wrong with trying to save the data", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction) -> Void in
                self.managedObjectContext.rollback()
                self.shoutOut = NSEntityDescription.insertNewObject(forEntityName: Entity.shoutOut.name, into: self.managedObjectContext) as? ShoutOut
            }))
            self.present(ac, animated: true)
        }
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
