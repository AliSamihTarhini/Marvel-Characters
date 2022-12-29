//
//  SelectedDetailCell.swift
//  Marvel Caracters
//
//  Created by Ali Tarhini on 28/12/2022.
//

import UIKit
import Kingfisher

class SelectedDetailCell: UICollectionViewCell {
    
    @IBOutlet var selectedDescriptionLabel: UILabel!
    @IBOutlet var selectedDescriptionImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setUpCell(model: SelectedDescModel){
        selectedDescriptionLabel.text = model.name
        selectedDescriptionImage.kf.setImage(with: URL(string: model.image))
        
    }
    
}
