//
//  CharacterDetails.swift
//  Marvel Caracters
//
//  Created by Ali Tarhini on 28/12/2022.
//

import UIKit

class CharacterDetails: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    
    
    let viewModel = CharacterDetailsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpUI()
        bindToViewModel()
    }

    func bindToViewModel(){
        viewModel.navigateToSelectedDetailsVc = { [weak self] myModel in
            if let currentView = self{
                guard let myModel = myModel else { return }
                let vc = SelectedDetailViewController(nibName: "SelectedDetailViewController", bundle: nil)
                vc.viewModel.modelToRecieve = myModel
                vc.modalPresentationStyle = .fullScreen
                currentView.present(vc, animated: true)
            }
        }
    }
    private func setUpUI(){
        titleLabel.text = viewModel.modelToRecieve?.name
    }
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func selectedDetailPressed(_ sender: UIButton) {
        viewModel.didSelectButton(with: sender.tag)
    }
    
    
    
    
    
}
