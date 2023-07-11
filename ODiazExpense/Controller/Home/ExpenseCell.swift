//
//  ExpenseCell.swift
//  ODiazExpense
//
//  Created by MacbookMBA8 on 14/06/23.
//

import UIKit

class ExpenseCell: UITableViewCell {
    @IBOutlet weak var ImageExpenseCell: UIImageView!
    @IBOutlet weak var NameExpenseCell: UILabel!
    @IBOutlet weak var DateExpenseCell: UILabel!
    @IBOutlet weak var MontoExpenseCell: UILabel!
    //@IBOutlet weak var ContentViewCell: UIView!
    
//    override var frame: CGRect {
//         get {
//             return super.frame
//         }
//         set (newFrame) {
//             var frame =  newFrame
//             frame.origin.y += 4
//             frame.size.height -= 4 * 5
//             super.frame = frame
//             
//             super.separatorInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
//         }
//       }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        ImageExpenseCell?.layer.cornerRadius = (ImageExpenseCell?.frame.size.width ?? 0.0) / 2
        ImageExpenseCell?.clipsToBounds = true
        ImageExpenseCell?.layer.borderWidth = 3.0
        ImageExpenseCell?.layer.borderColor = UIColor.white.cgColor
        layer.shadowRadius = 4.0
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 10)
        
//        let verticalPading: CGFloat = 10
//        let maskLayer = CALayer()
//        maskLayer.frame = CGRect(x: self.bounds.origin.x, y: self.bounds.origin.y, width: self.bounds.width, height: self.bounds.height).insetBy(dx: 0, dy: verticalPading/2)
//        self.layer.mask = maskLayer
        
        //contentView.layer.cornerRadius = 25
        //contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
