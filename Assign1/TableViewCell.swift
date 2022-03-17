//
//  TableViewCell.swift
//  Assign1
//  Created by Nancy Jain on 10/03/22.
//

import UIKit

class TableViewCell: UITableViewCell {

//    @IBOutlet weak var imageCellLbl: UIImageView!
//    @IBOutlet weak var cellLbl: UILabel!
    
    @IBOutlet weak var imageCellLbl: UIImageView!
    @IBOutlet weak var cellLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
