//
//  Cell.swift
//  ODiazExpense
//
//  Created by MacbookMBA8 on 12/06/23.
//

import UIKit

class Cell: UITableViewCell {
    @IBOutlet weak var NameCell: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
