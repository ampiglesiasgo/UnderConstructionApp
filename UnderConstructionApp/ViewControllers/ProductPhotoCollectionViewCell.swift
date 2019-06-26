//
//  ProductPhotoCollectionViewCell.swift
//  UnderConstructionApp
//
//  Created by Amparo Iglesias on 6/25/19.
//  Copyright © 2019 Amparo Iglesias. All rights reserved.
//

import UIKit

class ProductPhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    
    
    override func layoutSubviews() {
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1
    }
    
}
