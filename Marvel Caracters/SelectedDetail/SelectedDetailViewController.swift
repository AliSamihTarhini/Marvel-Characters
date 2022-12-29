//
//  SelectedDetailViewController.swift
//  Marvel Caracters
//
//  Created by Ali Tarhini on 28/12/2022.
//

import UIKit

class SelectedDetailViewController: UIViewController {

    @IBOutlet weak var selectedDetailsCollectionView: UICollectionView!
    
    let viewModel = SelectedDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpCollectionView()
        setUpUI()
        viewModel.fetchSelectedDetail()
        bindToViewModel()
    }
    
    private func setUpCollectionView(){
        selectedDetailsCollectionView.dataSource = self
        selectedDetailsCollectionView.delegate = self
        selectedDetailsCollectionView.register(UINib(nibName: "SelectedDetailCell", bundle: nil), forCellWithReuseIdentifier: "SelectedDetailCell")
    }
    func setUpUI(){
        if let model = viewModel.modelToRecieve?.tag{
            self.title = viewModel.checkSelectedDetail(modle: model)
            navigationItem.backButtonTitle = ""
        }
    }
    
    func bindToViewModel(){
        viewModel.selectedDetailsDataArray.bind { [weak self] selectedDesc in
            self?.reloadCollectionView()
        }
    }
    private func reloadCollectionView(){
        DispatchQueue.main.async {
            self.selectedDetailsCollectionView.reloadData()
        }
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
}
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
extension SelectedDetailViewController: UICollectionViewDelegate {
    
}
extension SelectedDetailViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 190, height: 200)
    }
}
