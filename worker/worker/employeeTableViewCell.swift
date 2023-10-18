//
//  employeeTableViewCell.swift
//  worker
//
//  Created by Common Room Bangi on 01/10/2023.
//

import UIKit

class employeeTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var nophoneLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var workerImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        

        // Configure the view for the selected state
    }

}
