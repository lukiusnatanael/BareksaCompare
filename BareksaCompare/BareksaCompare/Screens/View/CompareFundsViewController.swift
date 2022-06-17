//
//  CompareFundsViewController.swift
//  BareksaCompare
//
//  Created by BCA-GSIT-MACBOOK-5 on 15/06/22.
//

import UIKit

enum ButtonState {
    case primary
    case secondary
    case plain
}

class CompareFundsViewController: UIViewController {

    @IBOutlet weak var tabBarStackView: UIStackView!
    @IBOutlet weak var tabMovingView: UIView!
    @IBOutlet weak var timeFrameStackView: UIStackView!
    @IBOutlet weak var timeFrameMovingView: UIView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    @IBOutlet weak var productStackView: UIStackView!
    @IBOutlet weak var fundsTypeStackView: UIStackView!
    @IBOutlet weak var returnStackView: UIStackView!
    @IBOutlet weak var aumStackView: UIStackView!
    @IBOutlet weak var minPurchaseStackView: UIStackView!
    @IBOutlet weak var termStackView: UIStackView!
    @IBOutlet weak var riskStackView: UIStackView!
    @IBOutlet weak var launchingStackView: UIStackView!
    @IBOutlet weak var detailBtnStackView: UIStackView!
    @IBOutlet weak var buyBtnStackView: UIStackView!
    
    private var viewModel: CompareFundsViewModel!
    var currentTab = 0
    var currentTimeTab = 2
    var tabBtnArray: [UIButton] = []
    var timeBtnArray: [UIButton] = []
    
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
        setupInitialView()
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
        
        let title = "Perbandingan"
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
        DispatchQueue.main.async {
            self.hideLoadingView()
            self.scrollView.isHidden = false
            self.setupDataToView()
        }
    }
    
    func setupTabBar() {
        
        currentTab = 0
        tabMovingView.backgroundColor = .green800
        
        for i in 0..<viewModel.tabBar.count {
            let button = createButtonWith(title: viewModel.tabBar[i], textColor: .black38, font: UIFont(name: "OpenSans-Semibold", size: 14.0)!)
            button.tag = i
            button.addTarget(self, action: #selector(tabBarBtnTapped(_:)), for: .touchUpInside)
            if i == currentTab {
                button.setTitleColor(.green800, for: .normal)
            }
            tabBtnArray.append(button)
            tabBarStackView.addArrangedSubview(button)
        }
        DispatchQueue.main.async {
            self.setSelectedTabButton(index: self.currentTab)
        }
        
        currentTimeTab = 2
        timeFrameMovingView.backgroundColor = .green800
        for i in 0..<viewModel.timeFrame.count {
            let button = createButtonWith(title: viewModel.timeFrame[i], textColor: .black54, font: UIFont(name: "Montserrat-Medium", size: 12.0)!)
            button.tag = i
            button.addTarget(self, action: #selector(timeFrameBtnTapped(_ :)), for: .touchUpInside)
            if i == currentTimeTab {
                button.setTitleColor(.green700, for: .normal)
            }
            timeBtnArray.append(button)
            timeFrameStackView.addArrangedSubview(button)
        }
        DispatchQueue.main.async {
            self.setSelectedTimeFrameButton(index: self.currentTimeTab)
        }
    }
    
    func setupInitialView() {
        
        scrollView.isHidden = true
        if #available(iOS 13.0, *) {
            indicatorView.style = .medium
        } else {
            indicatorView.style = .white
        }
        showLoading()
    }
    
    func setupDataToView() {
        for i in 0..<viewModel.compareFundsData.data.count {
            let fundData = viewModel.compareFundsData.data[i]
            let backgroundColor: UIColor = i % 3 == 0 ? .green50 : i % 3 == 1 ? .purple50 : .navy50
            
            addFundTo(stackView: productStackView, value: fundData.details, backgroundColor: backgroundColor)
            addTextViewTo(stackView: fundsTypeStackView, value: fundData.details.type, backgroundColor: backgroundColor)
            addTextViewTo(stackView: returnStackView, value: fundData.details.getReturnString(), backgroundColor: backgroundColor)
            addTextViewTo(stackView: aumStackView, value: fundData.details.getAumString(), backgroundColor: backgroundColor)
            addTextViewTo(stackView: minPurchaseStackView, value: fundData.details.getMinSubscriptionString(), backgroundColor: backgroundColor)
            addTextViewTo(stackView: termStackView, value: fundData.details.getTermString(), backgroundColor: backgroundColor)
            addTextViewTo(stackView: riskStackView, value: fundData.details.getRiskString(), backgroundColor: backgroundColor)
            addTextViewTo(stackView: launchingStackView, value: fundData.details.getInceptionDate(), backgroundColor: backgroundColor)
            
            let detailBtn = createButtonWith(title: "Detail", textColor: .green800, font: UIFont(name: "Montserrat-SemiBold", size: 14.0)!, borderWidth: 1.0, borderColor: .green800)
            detailBtn.tag = i
            detailBtn.addTarget(self, action: #selector(detailBtnTapped(_ :)), for: .touchUpInside)
            detailBtnStackView.addArrangedSubview(detailBtn)
            
            let buyBtn = createButtonWith(title: "Beli", textColor: .black, backgroundColor: .green500, font: UIFont(name: "Montserrat-SemiBold", size: 14.0)!)
            buyBtn.tag = i
            buyBtn.addTarget(self, action: #selector(buyBtnTapped(sender :)), for: .touchUpInside)
            buyBtnStackView.addArrangedSubview(buyBtn)
        }
    }
    
    func showLoading() {
        loadingView.isHidden = false
        indicatorView.startAnimating()
    }
    
    func hideLoadingView() {
        loadingView.isHidden = true
        indicatorView.stopAnimating()
    }
    
    func setSelectedTabButton(index: Int) {
        tabMovingView.center.x = tabBtnArray[index].center.x
    }
    
    func moveTabTo(index: Int) {
        
        tabBtnArray[index].setTitleColor(.green800, for: .normal)
        tabBtnArray[currentTab].setTitleColor(.black38, for: .normal)
        
        UIView.animate(withDuration: 0.35, delay: 0.0, options: .curveEaseOut, animations: {
            self.setSelectedTabButton(index: index)
        }, completion: {_ in
            
        })
        self.currentTab = index
        
    }
    
    func setSelectedTimeFrameButton(index: Int) {
        timeFrameMovingView.center.x = timeBtnArray[index].center.x
    }
    
    func moveTimeFrameTo(index: Int) {
        
        timeBtnArray[index].setTitleColor(.green700, for: .normal)
        timeBtnArray[currentTimeTab].setTitleColor(.black54, for: .normal)
        
        UIView.animate(withDuration: 0.35, delay: 0.0, options: .curveEaseOut, animations: {
            self.setSelectedTimeFrameButton(index: index)
        }, completion: {_ in
            
        })
        self.currentTimeTab = index
        
    }
    
    @objc func detailBtnTapped(_ sender: UIButton) {
        let tag = sender.tag
        let code = viewModel.compareFundsData.data[tag].code
        print("Detail Button Tapped with code \(code)")
    }
    
    @objc func buyBtnTapped(sender: UIButton) {
        let tag = sender.tag
        let code = viewModel.compareFundsData.data[tag].code
        print("Buy Button Tapped with code \(code)")
    }
    
    @objc func timeFrameBtnTapped(_ sender: UIButton) {
        let tag = sender.tag
        let time = viewModel.timeFrame[tag]
        print("Time Frame Button Tapped with value \(time)")
        
        if tag != currentTimeTab {
            moveTimeFrameTo(index: tag)
        }
    }
    
    @objc func tabBarBtnTapped(_ sender: UIButton) {
        let tag = sender.tag
        let time = viewModel.tabBar[tag]
        print("Tab Button Tapped with value \(time)")
        if sender.tag != currentTab {
            moveTabTo(index: sender.tag)
        }
    }

}
