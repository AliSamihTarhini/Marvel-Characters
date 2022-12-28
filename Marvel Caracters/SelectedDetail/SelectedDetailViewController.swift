//
//  SelectedDetailViewController.swift
//  Marvel Caracters
//
//  Created by Ali Tarhini on 28/12/2022.
//

import UIKit

class SelectedDetailViewController: UIViewController {

    @IBOutlet weak var selectedLabel: UILabel!
    @IBOutlet weak var selectedDetailsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpCollectionView()
    }
    
    private func setUpCollectionView(){
        selectedDetailsCollectionView.dataSource = self
        selectedDetailsCollectionView.delegate = self
        selectedDetailsCollectionView.register(UINib(nibName: "SelectedDetailCell", bundle: nil), forCellWithReuseIdentifier: "SelectedDetailCell")
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
}
extension SelectedDetailViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = selectedDetailsCollectionView.dequeueReusableCell(withReuseIdentifier: "SelectedDetailCell", for: indexPath) as! SelectedDetailCell
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
