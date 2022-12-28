//
//  CharacterDetails.swift
//  Marvel Caracters
//
//  Created by Ali Tarhini on 28/12/2022.
//

import UIKit

class CharacterDetails: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailsTabelView: UITableView!
    
    
    let viewModel = CharacterDetailsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpTableView()
    }
    
    func setUpTableView(){
        detailsTabelView.dataSource = self
        detailsTabelView.delegate = self
        detailsTabelView.register(UINib(nibName: "CharacterDetailsCell", bundle: nil), forCellReuseIdentifier: "CharacterDetailsCell")
    }
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
}
extension CharacterDetails: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let detailsCell = detailsTabelView.dequeueReusableCell(withIdentifier: "CharacterDetailsCell", for: indexPath) as! CharacterDetailsCell
        return detailsCell
    }
}
extension CharacterDetails: UITableViewDelegate {
    
}
