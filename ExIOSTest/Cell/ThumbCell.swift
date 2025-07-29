//
//  ThumbCell.swift
//  ExIOSTest
//
//  Created by Vinh Nguyen on 29/7/25.
//

import UIKit

class ThumbCell: UICollectionViewCell {

    static let identifier = String(describing: ThumbCell.self)
    static let nib = UINib(nibName: identifier, bundle: nil)
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderWidth = 2
        layer.cornerRadius = 14
        layer.masksToBounds = true
    }

    func configCell(_ item: Item, isSelected: Bool) {
        imageView.image = UIImage(named: item.image)
        layer.borderColor = isSelected ? UIColor(named: "MainColor")?.cgColor : UIColor.clear.cgColor
    }
}
