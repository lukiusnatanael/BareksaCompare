//
//  CompareFundsViewController.swift
//  BareksaCompare
//
//  Created by BCA-GSIT-MACBOOK-5 on 15/06/22.
//

import UIKit

class CompareFundsViewController: UIViewController {

    private var viewModel: CompareFundsViewModel!
    
    init() {
        super.init(nibName: "CompareFundsViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewModel()
        setupNavigationBar()
    }
    
    func configureViewModel() {
        self.viewModel = CompareFundsViewModel()
    }
    
    func setupNavigationBar() {
        let customView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))

        let button = UIButton.init(type: .system)
        button.setBackgroundImage(UIImage(named: "icon_arrow_back"), for: .normal)
        button.frame = CGRect(x: 0, y: 12, width: 20, height: 20)
        button.addTarget(self, action: #selector(navigationLeftBtnTapped(button:)), for: .touchUpInside)
        customView.addSubview(button)

        let marginX = CGFloat(button.frame.origin.x + button.frame.size.width + 36)
        let label = UILabel(frame: CGRect(x: marginX, y: 0, width: UIScreen.main.bounds.width - marginX, height: 44))
        label.font = UIFont(name: "Montserrat-SemiBold", size: 20.0)
        
        let title = "Perbandingan";
        let letterSpace = 1.25
        let attrString = NSMutableAttributedString(string: title)
        attrString.addAttribute(NSAttributedString.Key.kern, value: letterSpace, range: NSMakeRange(0, attrString.length))
        label.attributedText = attrString
        customView.addSubview(label)
        
        let leftButton = UIBarButtonItem(customView: customView)
        self.navigationItem.leftBarButtonItem = leftButton
    }
    
    @objc func navigationLeftBtnTapped(button: UIButton) {
        navigationController?.popViewController(animated: true)
    }

}
