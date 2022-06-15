//
//  HomeViewController.swift
//  BareksaCompare
//
//  Created by BCA-GSIT-MACBOOK-5 on 15/06/22.
//

import UIKit

class HomeViewController: UIViewController {

    var viewModel: HomeViewModel!
    
    init(viewModel: HomeViewModel) {
        super.init(nibName: "HomeViewController", bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

}
