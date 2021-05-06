//
//  ExerciseButtonTableViewCell.swift
//  FemFitDraft
//
//  Created by Leila on 5/3/21.
//  Copyright © 2021 Leila. All rights reserved.
//

import UIKit

class ExerciseButtonTableViewCell: UITableViewCell {

    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        //button.layer.cornerRadius = 10
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
