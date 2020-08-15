//
//  ViewController.swift
//  CalorieTracker
//
//  Created by Waseem Idelbi on 8/14/20.
//  Copyright © 2020 Waseem Idelbi. All rights reserved.
//

import UIKit
//import SwiftChart

class ViewController: UIViewController {
    
    //MARK: - Properties and IBOutlets -
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .short
        return dateFormatter
    }
    
    var calorieEntries: [CalorieIntake]?
    
    @IBOutlet weak var tableView: UITableView!
//    @IBOutlet weak var chartView: Chart!
    
    //MARK: - Methods and IBActions -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        fetchCalorieEntries()
    }
    
    func fetchCalorieEntries() {
        
        do {
            self.calorieEntries = try context.fetch(CalorieIntake.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
            NSLog("error fetching calorie entries: \(error)")
        }
        
    }
    
    @IBAction func addEntryButtonTapped(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Add Calorie Intake", message: "Enter the amount of calories in the field", preferredStyle: .alert)
        alert.addTextField()
        
        let submitButton = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let textField = alert.textFields![0]
            textField.keyboardType = .numberPad
            
            guard let calories = Int64(textField.text ?? "") else { return }
            
            CalorieIntake(calories: calories, context: self.context)
            
            do {
            try self.context.save()
            } catch {
            NSLog("could not save to persistent store: \(error)")
            }
            
            self.fetchCalorieEntries()
        }
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel) { (_) in
            self.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(cancelButton)
        alert.addAction(submitButton)
        self.present(alert, animated: true)
    }
    
} //End of class

//MARK: - Extensions -

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return calorieEntries?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CalorieCell", for: indexPath)
        let calorieEntry = calorieEntries![indexPath.row]
        cell.textLabel?.text = "Calories: \(calorieEntry.calories)"
        cell.detailTextLabel?.text = "\(dateFormatter.string(from: calorieEntry.date))"
        return cell
        
    }
    
} //End of extension
