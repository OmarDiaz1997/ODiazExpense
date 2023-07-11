import UIKit

class CategoryCell: UITableViewCell {
    @IBOutlet weak var ImageCategory: UIImageView!
    @IBOutlet weak var NameCategory: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        ImageCategory?.layer.cornerRadius = (ImageCategory?.frame.size.width ?? 0.0) / 2
        ImageCategory?.clipsToBounds = true
        ImageCategory?.layer.borderWidth = 3.0
        ImageCategory?.layer.borderColor = UIColor.white.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

}
