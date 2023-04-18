//
//  ViewController.swift
//  Habitual
//
//  Created by Stefan Mueller on 3/20/23.
//

import UIKit

class HabitsTableViewController: UITableViewController {
    private var persistence = PersistenceLayer()
    //    var habits: [Habit] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar();navigationItem.leftBarButtonItem = self.editButtonItem // Call the new method
        tableView.register(
            HabitTableViewCell.nib,
            forCellReuseIdentifier:
                HabitTableViewCell.identifier
        )
    }
    
    // return the number of rows for the given section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persistence.habits.count
    }
    
    // return the UITableViewCell for the given indexPath
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(
        withIdentifier: HabitTableViewCell.identifier,
        for: indexPath) as! HabitTableViewCell
        
      let habit = persistence.habits[indexPath.row]
      cell.configure(habit)

      return cell
    }
        
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      switch editingStyle {
        case .delete:
          let habitToDelete = persistence.habits[indexPath.row]
          let habitIndexToDelete = indexPath.row
          let deleteAlert = UIAlertController(habitTitle: habitToDelete.title) {
            self.persistence.delete(habitIndexToDelete)
            tableView.deleteRows(at: [indexPath], with: .automatic)
          }
          self.present(deleteAlert, animated: true)
        default:
          break
      }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
      persistence.swapHabits(habitIndex: sourceIndexPath.row, destinationIndex: destinationIndexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedHabit = persistence.habits[indexPath.row]
        let habitDetailVC = HabitDetailViewController.instantiate()
        habitDetailVC.habit = selectedHabit
        habitDetailVC.habitIndex = indexPath.row
        navigationController?.pushViewController(habitDetailVC, animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        persistence.setNeedsToReloadHabits()
        tableView.reloadData()
    }
    
}
    // Add the extension
extension HabitsTableViewController {
    func setupNavBar() {
        title = "Habitual" // Add a title to the nav bar
        // Create a UIBarButtonItem
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(pressAddHabit(_:)))
        // Add the barbuttonitem to the navbar
        navigationItem.rightBarButtonItem = addButton
    }
    
    // This function handle taps on the bar button item, see #selector above
    @objc func pressAddHabit(_ sender: UIBarButtonItem) {
        let addHabitVC = AddHabitViewController.instantiate()
        let navigationController = UINavigationController(rootViewController: addHabitVC)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true, completion: nil)
    }
}

extension UIAlertController {
  convenience init(habitTitle: String, comfirmHandler: @escaping () -> Void) {
    self.init(title: "Delete Habit", message: "Are you sure you want to delete \(habitTitle)?", preferredStyle: .actionSheet)

    let confirmAction = UIAlertAction(title: "Confirm", style: .destructive) { _ in
      comfirmHandler()
    }
    self.addAction(confirmAction)

    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
    self.addAction(cancelAction)
  }
}
