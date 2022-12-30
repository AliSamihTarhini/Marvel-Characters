//
//  SelectedDetailViewModle.swift
//  Marvel Caracters
//
//  Created by Ali Tarhini on 28/12/2022.
//

import Foundation



class SelectedDetailViewModel {
    //MARK: Var keys
    var modelToRecieve: SelectedModel?
    let serviceLayer = ServiceLayer()
    let urlBase = UrlBase()
    var selectedDetailsDataArray = Dynamic([SelectedDescModel]())
    var numberOfDesc: Int {
        return selectedDetailsDataArray.value.count
    }
    //MARK: Closures
    var reloadCollectionView: (()->())?
    var hideIndicator: (()->())?
    
    var url = ""
    //MARK: - Configuring the cell -
    func configureCell(cell: SelectedDetailCell, at index: IndexPath ){
        let model = selectedDetailsDataArray.value[index.row]
        cell.setUpCell(model: model)
    }
    //MARK: - Cheking the selected detail -
    func checkSelectedDetail(modle: Int) -> String{
        guard let id = modelToRecieve?.id else { return "" }
        if modle == 0{
            url =  urlBase.getUrlComics(id: id)
            return "Comics"
        }
        else if modle == 1{
            url = urlBase.getUrlEvents(id: id)
            return  "Events"
        }else if modle == 2{
            url = urlBase.getUrlSeries(id: id)
            return "Series"
        }else {
            url = urlBase.getUrlStories(id: id)
            return "Stories"
        }
    }
    //MARK: - Network Call and fetshing data -
    func fetchSelectedDetail(){
        serviceLayer.downloadContent(fromUrlString: url)
        { result in
            self.hideIndicator?()
            switch result {
            case .success(let data):
                let decodedData = try! JSONDecoder().decode(SelectedDescData.self, from: data)
                var myArray: [SelectedDescModel] = []
                for i in 0..<decodedData.data.results.count{
                    let selectedDesc = SelectedDescModel(name: decodedData.data.results[i].title, image: "\(decodedData.data.results[i].thumbnail?.path ?? "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available").\(decodedData.data.results[i].thumbnail?.extension ?? "jpg")")
                    myArray.append(selectedDesc)
                }
                self.checkUpIfNull(array: myArray)
                break
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        }
        
    }
    
    //MARK: - Cheking if the data has no image -
    func checkUpIfNull(array: [SelectedDescModel]){
        if array.isEmpty {
            let defaultData = SelectedDescModel(name: "No Data", image: "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available.jpg")
            selectedDetailsDataArray.value = [defaultData]
        }
        else{
            selectedDetailsDataArray.value = array
        }
    }
}
