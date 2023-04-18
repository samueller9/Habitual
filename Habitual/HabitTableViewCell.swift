//
//  HabitTableViewCell.swift
//  Habitual
//
//  Created by Stefan Mueller on 3/29/23.
//

import UIKit

class HabitTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageViewIcon: UIImageView!
    @IBOutlet weak var labelHabitTitle: UILabel!
    @IBOutlet weak var labelStreaks: UILabel!
    
    static let identifier = "HabitCell"

    // Returning the xib file after instantiating it
    static var nib: UINib {
      return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    func configure(_ habit: Habit) {
      self.imageViewIcon.image = habit.selectedImage.image
      self.labelHabitTitle.text = habit.title
      self.labelStreaks.text = "streak: \(habit.currentStreak)"

      if habit.completedToday {
        self.accessoryType = .checkmark
      } else {
        self.accessoryType = .disclosureIndicator
      }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
