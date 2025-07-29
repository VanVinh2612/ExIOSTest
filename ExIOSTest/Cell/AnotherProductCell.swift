//
//  AnotherProductCell.swift
//  ExIOSTest
//
//  Created by Vinh Nguyen on 29/7/25.
//

import UIKit

class AnotherProductCell: UICollectionViewCell {

    static let identifier = String(describing: AnotherProductCell.self)
    static let nib = UINib(nibName: identifier, bundle: nil)
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.cornerRadius = 14
        priceView.cornerRadius = 13
    }

    func configCell(_ product: Product) {
        titleLabel.text = product.name
        imageView.image = UIImage(named: product.thumbnailImage)
    }
}
