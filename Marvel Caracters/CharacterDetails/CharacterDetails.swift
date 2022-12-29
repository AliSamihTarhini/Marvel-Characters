//
//  CharacterDetails.swift
//  Marvel Caracters
//
//  Created by Ali Tarhini on 28/12/2022.
//

import UIKit

class CharacterDetails: UIViewController {
    
    
    let viewModel = CharacterDetailsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpUI()
        bindToViewModel()
    }

    func bindToViewModel(){
        viewModel.navigateToSelectedDetailsVc = { [weak self] myModel in
            guard let myModel = myModel else { return }
            let vc = SelectedDetailViewController(nibName: "SelectedDetailViewController", bundle: nil)
            vc.viewModel.modelToRecieve = myModel
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    private func setUpUI(){
        self.title = viewModel.modelToRecieve?.name
        self.navigationItem.backButtonTitle = ""
    }
    
    @IBAction func selectedDetailPressed(_ sender: UIButton) {
        viewModel.didSelectButton(with: sender.tag)
    }
}
