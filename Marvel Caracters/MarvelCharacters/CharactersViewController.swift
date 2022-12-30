//
//  CharactersViewController.swift
//  Marvel Caracters
//
//  Created by Ali Tarhini on 27/12/2022.
//

import UIKit


class CharactersViewController: UIViewController {
  //MARK: - IBOutlet -
    @IBOutlet weak var charactersCollectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    //MARK: - ViewModel decleration -
    private let viewModel = MarvelCharactersViewModel()
    //MARK: - ViewDidLoad -
    override func viewDidLoad() {
        super.viewDidLoad()
        bindToViewModel()
        self.title = "Marvel Characters"
        navigationItem.backButtonTitle = ""
        // Do any additional setup after loading the view.
        setUpCollectionView()
        activityIndicator.startAnimating()
        viewModel.getMarvelCharacters()
        
    }
    //MARK: - binding func -
    func bindToViewModel(){
        viewModel.marvelCharactersDataArray.bind { [weak self] marChar in
            self?.reloadCollectionView()
        }
        viewModel.navigateToDetailsVc = { [weak self] marChar in
            guard let marChar = marChar else { return }
            let vc = CharacterDetails(nibName: "CharacterDetails", bundle: nil)
            self?.navigationController?.pushViewController(vc, animated: true)
            vc.viewModel.modelToRecieve = marChar
        }
        
        viewModel.hideIndicator = { [weak self] in
            guard let self = self else {return}
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
            }
            
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
//MARK: - collectionView dataSource -
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
//MARK: - CollectionView delegate -
extension CharactersViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectRow(at: indexPath)
    }
}
//MARK: - CollectionViewDelegateFlowLayout -
extension CharactersViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width / 2 ) - 10
        let height: CGFloat = 210
        return CGSize(width: width, height: height)
    }
}
