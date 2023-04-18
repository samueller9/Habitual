//
//  ConfirmHabitViewController.swift
//  Habitual
//
//  Created by Stefan Mueller on 4/10/23.
//

import UIKit

class ConfirmHabitViewController: UIViewController {
    var habitImage: Habit.Images!
    
    private func updateUI() {
        title = "New Habit"
        habitImageView.image = habitImage.image
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var habitImageView: UIImageView!
        
    
    @IBOutlet weak var habitNameInputField: UITextField!
    

    @IBAction func createHabitButtonPressed(_ sender: Any) {
        var persistenceLayer = PersistenceLayer()
        guard let habitText = habitNameInputField.text else { return }
        
        persistenceLayer.createNewHabit(name: habitText, image: habitImage)
        
        print(presentingViewController)
        print(habitText)
        
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
}
