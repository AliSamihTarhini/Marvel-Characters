//
//  CharactersDetailsViewModel.swift
//  Marvel Caracters
//
//  Created by Ali Tarhini on 28/12/2022.
//

import Foundation



class CharacterDetailsViewModel {

    var modelToRecieve: MarvelCharacters?
    var navigateToSelectedDetailsVc: ((SelectedModel?)->())?
    
    
    func didSelectButton(with tag: Int){
        if let id = modelToRecieve?.id{
            let model = SelectedModel(id: id, tag: tag)
            self.navigateToSelectedDetailsVc?(model)
        }
        
        
    }
}
