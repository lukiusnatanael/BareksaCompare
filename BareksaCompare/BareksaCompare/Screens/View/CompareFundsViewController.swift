//
//  CompareFundsViewController.swift
//  BareksaCompare
//
//  Created by BCA-GSIT-MACBOOK-5 on 15/06/22.
//

import UIKit

class CompareFundsViewController: UIViewController {

    var viewModel: CompareFundsViewModel!
    
    init(viewModel: CompareFundsViewModel) {
        super.init(nibName: "CompareFundsViewController", bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

}
