//
//  TableViewCellMENU.swift
//  ACSprojects
//
//  Created by Максим Евлентьев on 04.12.16.
//  Copyright © 2016 Максим Евлентьев. All rights reserved.
//

import UIKit

class TableViewCellMENU: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var imag: UIImageView!
    var name: String?

       override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
