//
//  HomeViewController.swift
//  BareksaCompare
//
//  Created by BCA-GSIT-MACBOOK-5 on 15/06/22.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var compareBtn: UIButton!
    
    private var viewModel: HomeViewModel!
    
    init() {
        super.init(nibName: "HomeViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewModel()
        setupView()
    }
    
    func configureViewModel() {
        self.viewModel = HomeViewModel()
    }
    
    func setupView() {
        imageView.image = UIImage(named: "image_bareksa")
        
        compareBtn.setTitle("Compare Funds!", for: .normal)
        compareBtn.titleLabel?.font = UIFont(name: "Montserrat-SemiBold", size: 16.0)
        compareBtn.setTitleColor(.black, for: .normal)
        compareBtn.tintColor = .green500
        
    }

    @IBAction func compareBtnTapped(_ sender: Any) {
        let compareFundsViewController = CompareFundsViewController()
        navigationController?.pushViewController(compareFundsViewController, animated: true)
    }
    
}
