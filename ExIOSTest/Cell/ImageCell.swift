//
//  ImageCell.swift
//  ExIOSTest
//
//  Created by Vinh Nguyen on 29/7/25.
//

import UIKit

class ImageCell: UICollectionViewCell {
    
    static let identifier = String(describing: ImageCell.self)
    static let nib = UINib(nibName: identifier, bundle: nil)
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var priceView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        priceView.cornerRadius = 12
    }

    func configCell(_ item: Item) {
        priceLabel.text = item.price
        imageView.image = UIImage(named: item.image)
    }
}
