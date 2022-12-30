//
//  SelectedDetailViewController.swift
//  Marvel Caracters
//
//  Created by Ali Tarhini on 28/12/2022.
//

import UIKit

class SelectedDetailViewController: UIViewController {
    //MARK: - IBOutlets -
    @IBOutlet weak var selectedDetailsCollectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    //MARK: - viewModel decleration -
    let viewModel = SelectedDetailViewModel()
    //MARK: - ViewDidLoad -
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        bindToViewModel()
        activityIndicator.startAnimating()
        setUpCollectionView()
        setUpUI()
        viewModel.fetchSelectedDetail()
        
    }
    //MARK: - functions -
    private func setUpCollectionView(){
        selectedDetailsCollectionView.dataSource = self
        selectedDetailsCollectionView.delegate = self
        selectedDetailsCollectionView.register(UINib(nibName: "SelectedDetailCell", bundle: nil), forCellWithReuseIdentifier: "SelectedDetailCell")
    }
    private func setUpUI(){
        if let model = viewModel.modelToRecieve?.tag{
            self.title = viewModel.checkSelectedDetail(modle: model)
            navigationItem.backButtonTitle = ""
        }
    }
    //MARK: - binding func -
    func bindToViewModel(){
        viewModel.selectedDetailsDataArray.bind { [weak self] selectedDesc in
            self?.reloadCollectionView()
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
            self.selectedDetailsCollectionView.reloadData()
        }
        
    }
    
}
//MARK: - CollectionView DataSource -
extension SelectedDetailViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfDesc
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = selectedDetailsCollectionView.dequeueReusableCell(withReuseIdentifier: "SelectedDetailCell", for: indexPath) as! SelectedDetailCell
        viewModel.configureCell(cell: cell, at: indexPath)
        return cell
    }
}
//MARK: - CollectionViewDelegateFlowLayout -
extension SelectedDetailViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width / 2 ) - 10
        let height: CGFloat = 210
        return CGSize(width: width, height: height)
    }
}
