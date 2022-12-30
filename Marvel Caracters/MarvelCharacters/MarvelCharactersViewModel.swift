//
//  MarvelCharactersViewModel.swift
//  Marvel Caracters
//
//  Created by Ali Tarhini on 27/12/2022.
//

import Foundation

class MarvelCharactersViewModel {
    //MARK: - Var Kerys -
    let hashing = md5Formation()
    let serviceLayer = ServiceLayer()
    var marvelCharactersDataArray = Dynamic([MarvelCharacters]())
    let urlBase = UrlBase()
    var numberOfCharacters: Int {
        return marvelCharactersDataArray.value.count
    }
    //MARK: - Closures -
    var reloadCollectionView: (()->())?
    var navigateToDetailsVc: ((MarvelCharacters?)->())?
    var hideIndicator: (()->())?
    //MARK: - Configuring The Cell -
    func configureCell(cell: MarvelCharactersCollectionViewCell, at index: IndexPath ){
        let model = marvelCharactersDataArray.value[index.row]
        cell.setUpCell(model: model)
    }
    //MARK: - Netwoking and fetching the data -
    func getMarvelCharacters(){
        serviceLayer.downloadContent(fromUrlString: urlBase.urlCharacters) { result in
            self.hideIndicator?()
            switch result {
            case .success(let data):
                let decodedData = try! JSONDecoder().decode(MarvelCharctersData.self, from: data)
                var myArray: [MarvelCharacters] = []
                for i in 0..<decodedData.data.results.count{
                    let character = MarvelCharacters(id: decodedData.data.results[i].id, name: decodedData.data.results[i].name, image: "\(decodedData.data.results[i].thumbnail?.path ?? "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available").\(decodedData.data.results[i].thumbnail?.extension ?? "jpg")")
                    myArray.append(character)
                }
                self.marvelCharactersDataArray.value = myArray
                break
                
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        }
    }
    //MARK: - Selection of a cell func -
    func didSelectRow(at index: IndexPath){
        let detailsToSend = marvelCharactersDataArray.value[index.row]
        self.navigateToDetailsVc?(detailsToSend)
    }
}
