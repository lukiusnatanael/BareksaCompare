//
//  CompareFundsViewController.swift
//  BareksaCompare
//
//  Created by BCA-GSIT-MACBOOK-5 on 15/06/22.
//

import UIKit

class CompareFundsViewController: UIViewController {

    @IBOutlet weak var firstTabBtn: UIButton!
    @IBOutlet weak var secondTabBtn: UIButton!
    @IBOutlet weak var tabMovingView: UIView!
    
    private var viewModel: CompareFundsViewModel!
    var currentTab = 0
    
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
        setupTabBar()
    }
    
    func configureViewModel() {
        self.viewModel = CompareFundsViewModel()
        self.viewModel.bindCompareChartDataToController = {
            self.updateChartView()
        }
        self.viewModel.bindCompareFundsDataToController = {
            self.updateFundsView()
        }
    }
    
    func updateChartView() {
        
    }
    
    func updateFundsView() {
        
    }
    
    func setupTabBar() {
        
        currentTab = 0
        tabMovingView.backgroundColor = .primaryGreen
        
        firstTabBtn.setTitle("Imbal Hasil", for: .normal)
        firstTabBtn.setTitleColor(.primaryGreen, for: .normal)
        firstTabBtn.setTitleColor(.primaryGray, for: .highlighted)
        firstTabBtn.titleLabel?.font = UIFont(name: "OpenSans-Semibold", size: 14.0)
        
        secondTabBtn.setTitle("Dana Kelolaan", for: .normal)
        secondTabBtn.setTitleColor(.secondaryGray, for: .normal)
        secondTabBtn.setTitleColor(.primaryGray, for: .highlighted)
        secondTabBtn.titleLabel?.font = UIFont(name: "OpenSans-Semibold", size: 14.0)
    }
    
    @IBAction func tabBarBtnTapped(_ sender: UIButton) {
        
        if sender.tag != currentTab {
            moveTabTo(index: sender.tag)
        }
    }
    
    func moveTabTo(index: Int) {
        
        //TODO: Somehow it doesn't change
        if index == 0 {

            firstTabBtn.setTitleColor(.primaryGreen, for: .normal)
            secondTabBtn.setTitleColor(.secondaryGray, for: .normal)
        } else if index == 1 {
            firstTabBtn.setTitleColor(.secondaryGray, for: .normal)
            secondTabBtn.setTitleColor(.primaryGreen, for: .normal)
        }
        
        UIView.animate(withDuration: 0.35, delay: 0.0, options: .curveEaseOut, animations: {
            if index > self.currentTab {
                self.tabMovingView.frame.origin.x += self.tabMovingView.frame.size.width
            } else if index < self.currentTab {
                self.tabMovingView.frame.origin.x -= self.tabMovingView.frame.size.width
            }
        }, completion: {_ in
            self.currentTab = index
        })
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
