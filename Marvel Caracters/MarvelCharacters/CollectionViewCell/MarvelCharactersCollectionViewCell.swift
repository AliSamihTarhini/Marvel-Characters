//
//  MarvelCharactersCollectionViewCell.swift
//  Marvel Caracters
//
//  Created by Ali Tarhini on 27/12/2022.
//

import UIKit
import Kingfisher

class MarvelCharactersCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var labelCell: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageCell.layer.cornerRadius = 15
        imageCell.layer.borderWidth = 1
        imageCell.layer.borderColor = UIColor.black.cgColor
    }

    
    func setUpCell(model: MarvelCharacters){
        labelCell.text = model.name
        imageCell.kf.setImage(with: URL(string: model.image))
        
    }
}
