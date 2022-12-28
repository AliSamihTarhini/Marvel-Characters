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
    }

    private func setUpUI(){
        titleLabel.text = viewModel.modelToRecieve?.name
    }
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func comicsButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func eventsButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func seriesButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func storiesButtonPressed(_ sender: UIButton) {
    }
    
    
    
}
