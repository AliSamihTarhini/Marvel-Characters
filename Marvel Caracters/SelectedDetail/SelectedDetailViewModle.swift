//
//  SelectedDetailViewModle.swift
//  Marvel Caracters
//
//  Created by Ali Tarhini on 28/12/2022.
//

import Foundation



class SelectedDetailViewModel {
    
    var modelToRecieve: SelectedModel?
    var finalArray = Dynamic([SelectedDescModel]())
    var numberOfDesc: Int {
        return finalArray.value.count
    }
    
    var reloadCollectionView: (()->())?
    
    func configureCell(cell: SelectedDetailCell, at index: IndexPath ){
        let model = finalArray.value[index.row]
        cell.setUpCell(model: model)
    }
    
    let hashing = md5Formation()
    let baseUrl = "https://gateway.marvel.com/v1/public/characters/"
    var additional = ""
    func checkSelectedDetail(modle: Int) -> String{
        if modle == 0{
            additional = "/comics"
            return "Comics"
        }
        else if modle == 1{
            additional = "/events"
            return  "Events"
        }else if modle == 2{
            additional = "/series"
            return "Series"
        }else {
            additional = "/stories"
            return "Stories"
        }
    }
    
    func fetchSelectedDetail(){
        let additional2 = "?apikey=\(hashing.pubKey)&hash=\(hashing.generateMD5(string: "\(hashing.ts)\(hashing.priKey)\(hashing.pubKey)"))&ts=\(hashing.ts)"
        guard let id = modelToRecieve?.id else { return }
        guard let url = URL(string: "\(baseUrl)\(id)\(additional)\(additional2)") else{ return }
        print(url)
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else{
                print(error!)
                return
            }
            do{
                let decodedData = try JSONDecoder().decode(SelectedDescData.self, from: data)
                var myArray: [SelectedDescModel] = []
                for i in 0..<decodedData.data.results.count{
                    let selectedDesc = SelectedDescModel(name: decodedData.data.results[i].title, image: "\(decodedData.data.results[i].thumbnail.path).\(decodedData.data.results[i].thumbnail.extension)")
                    myArray.append(selectedDesc)
                }
                self.checkUpIfNull(array: myArray)
            }
            catch{
                print(error)
            }
            
        }.resume()
    }
    func checkUpIfNull(array: [SelectedDescModel]){
        if array.isEmpty {
            let defaultData = SelectedDescModel(name: "No Data", image: "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available.jpg")
            finalArray.value = [defaultData]
        }
        else{
            finalArray.value = array
        }
    }
}
