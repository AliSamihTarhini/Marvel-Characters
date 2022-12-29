//
//  MarvelCharactersViewModel.swift
//  Marvel Caracters
//
//  Created by Ali Tarhini on 27/12/2022.
//

import Foundation

class MarvelCharactersViewModel {
    let hashing = md5Formation()
    var finalArray = Dynamic([MarvelCharacters]())
    var numberOfCharacters: Int {
        return finalArray.value.count
    }
    
    var reloadCollectionView: (()->())?
    var navigateToDetailsVc: ((MarvelCharacters?)->())?
    
    func configureCell(cell: MarvelCharactersCollectionViewCell, at index: IndexPath ){
        let model = finalArray.value[index.row]
        cell.setUpCell(model: model)
    }

    func getMarvelCharacters(){
        let marvelCharactersUrl = "https://gateway.marvel.com:443/v1/public/characters?apikey=f9b05d4f16c29186b37f36e297edb0d3"
        let string = "\(hashing.ts)\(hashing.priKey)\(hashing.pubKey)"
        guard let url = URL(string: "\(marvelCharactersUrl)&hash=\(hashing.generateMD5(string: string))&ts=\(hashing.ts)") else { return }
        print(url)
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil
            else{
                print(error!)
                return
            }
            do {
                let decodedData = try JSONDecoder().decode(MarvelCharctersData.self, from: data)
                var myArray: [MarvelCharacters] = []
                for i in 0..<decodedData.data.results.count{
                    let character = MarvelCharacters(id: decodedData.data.results[i].id, name: decodedData.data.results[i].name, image: "\(decodedData.data.results[i].thumbnail.path).\(decodedData.data.results[i].thumbnail.extension)")
                    myArray.append(character)
                }
                self.finalArray.value = myArray
                print(self.finalArray.value)
            }
            catch{
                print(error)
            }
            
        }.resume()
    }
    
    
    func didSelectRow(at index: IndexPath){
        let detailsToSend = finalArray.value[index.row]
        self.navigateToDetailsVc?(detailsToSend)
    }
}
