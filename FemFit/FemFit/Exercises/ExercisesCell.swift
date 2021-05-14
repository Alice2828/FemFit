//
//  ExercisesCell.swift
//  FemFit
//
//  Created by User on 24.04.2021.
//  Copyright © 2021 User. All rights reserved.
//

import UIKit

class ExercisesCell: UITableViewCell {
    @IBOutlet weak var exerciseImage: UIImageView!
    var exerciseIndex: Int?
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBAction func addToFavList(_ sender: UIButton) {
        if favExercisesList.isEmpty{
            for i in 0...exercisesList.count-1{
                if exercisesList[i].id == exerciseIndex{
                    favExercisesList.append(exercisesList[i])
                    
                    sender.tintColor = UIColor(named: "SelectionColor")
                    
                    break
                }
            }
        }else{
            for i in 0...favExercisesList.count-1{
                if favExercisesList[i].id == exerciseIndex{
                    favExercisesList.remove(at: i)
                    sender.tintColor = UIColor(named: "WhiteUniversal")
                    break
                }
                if i == favExercisesList.count-1{
                    for i in 0...exercisesList.count-1{
                        if exercisesList[i].id == exerciseIndex{
                            favExercisesList.append(exercisesList[i])
                            sender.tintColor = UIColor(named: "SelectionColor")
                            break
                        }
                    }
                }
                
            }
        }
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        nameLabel.layer.masksToBounds = true
        nameLabel.layer.cornerRadius = 10
        authorLabel.layer.masksToBounds = true
        authorLabel.layer.cornerRadius = 10
       // exerciseImage.layer.cornerRadius = 10
        cellView.layer.masksToBounds = true
        cellView.layer.cornerRadius = 10
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
