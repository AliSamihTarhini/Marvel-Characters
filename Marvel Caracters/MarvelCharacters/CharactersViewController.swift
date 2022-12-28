//
//  CharactersViewController.swift
//  Marvel Caracters
//
//  Created by Ali Tarhini on 27/12/2022.
//

import UIKit


class CharactersViewController: UIViewController {
  
    @IBOutlet weak var charactersCollectionView: UICollectionView!
    
    private let viewModel = MarvelCharactersViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpCollectionView()
        viewModel.getMarvelCharacters()
        bindToViewModel()
    }
    func bindToViewModel(){
        viewModel.finalArray.bind { [weak self] marChar in
        self?.reloadCollectionView()
        }
    }
    
    private func reloadCollectionView(){
        DispatchQueue.main.async {
            self.charactersCollectionView.reloadData()
        }
    }

    private func setUpCollectionView(){
        charactersCollectionView.delegate = self
        charactersCollectionView.dataSource = self
        charactersCollectionView.register(UINib(nibName: "MarvelCharactersCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MarvelCharactersCollectionViewCell")
    }

}
extension CharactersViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfCharacters
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let charactersCell = charactersCollectionView.dequeueReusableCell(withReuseIdentifier: "MarvelCharactersCollectionViewCell", for: indexPath) as! MarvelCharactersCollectionViewCell
        viewModel.configureCell(cell: charactersCell, at: indexPath)
        return charactersCell
    }
}
extension CharactersViewController: UICollectionViewDelegate{
    
}
extension CharactersViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 190, height: 200)
    }
}
