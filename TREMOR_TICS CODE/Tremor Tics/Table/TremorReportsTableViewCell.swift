//
//  TremorReportsTableViewCell.swift
//  Tremor Tics
//
//  Created by Shaheer Chaudry on 8/26/19.
//  Copyright © 2019 Shaheer Chaudry. All rights reserved.
//

import UIKit

class TremorReportsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var ScoreLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var maxLabel: UILabel!
    @IBOutlet weak var baseLabel: UILabel!
    @IBOutlet weak var scoreResult: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        ScoreLabel.layer.cornerRadius = 25
        ScoreLabel.layer.shadowColor = UIColor.black.cgColor
        ScoreLabel.layer.shadowRadius = 3.0
        ScoreLabel.layer.shadowOpacity = 1.0
        ScoreLabel.layer.masksToBounds = true
        
        // Configure the view for the selected state
    }
    
}
