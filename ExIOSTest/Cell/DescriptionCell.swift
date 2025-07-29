//
//  DescreptionCell.swift
//  ExIOSTest
//
//  Created by Vinh Nguyen on 29/7/25.
//

import UIKit

class DescriptionCell: UITableViewCell {
    
    static let identifier = String(describing: DescriptionCell.self)
    static let nib = UINib(nibName: identifier, bundle: nil)
    
    @IBOutlet weak var descriptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configCell(_ text: String) {
        descriptionLabel.text = text
    }
}
