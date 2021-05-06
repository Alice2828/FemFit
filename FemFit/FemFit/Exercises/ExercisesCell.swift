//
//  ExercisesCell.swift
//  FemFit
//
//  Created by User on 24.04.2021.
//  Copyright © 2021 User. All rights reserved.
//

import UIKit

class ExercisesCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
