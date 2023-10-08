//
//  CustomTableViewCell.swift
//  TableViewAssignment
//
//  Created by Arunesh Gupta on 07/10/23.
//

import UIKit
import SDWebImage

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var cellImageView: LazyImageView!
    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var cellSubtitle: UILabel!
    @IBOutlet weak var imageViewWidth: NSLayoutConstraint!
    @IBOutlet weak var imageOuterViewWidth: NSLayoutConstraint!
    
    static var identifier = "CustomTableViewCell"
    
    static func nib() -> UINib{
        return UINib(nibName: identifier, bundle: nil)
    }
    
    public func configure(with title: String, subtitle: String, imageName: String?){
        cellTitle.text = title
        cellSubtitle.text = subtitle
        if let imageName = imageName{
            let imageURL = URL(string: imageName)
            imageViewWidth.constant = 60
            imageOuterViewWidth.constant = 92
            
            // To Use SDWebImage
            cellImageView.sd_setImage(with: imageURL, placeholderImage: UIImage(systemName: "photo.artframe.circle.fill"), options: .continueInBackground, completed: nil)
            
            // Uncomment below to use custom method to download Image and use custom caching for better performance instead of using SDWebImage
//            cellImageView.loadImage(fromURL: imageURL!, placeholderImage: "photo.artframe.circle.fill")
        }
        else{
            imageViewWidth.constant = 0
            imageOuterViewWidth.constant = 0
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cellImageView.image = nil
    }
    
}
