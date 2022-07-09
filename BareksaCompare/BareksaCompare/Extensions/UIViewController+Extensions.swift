//
//  UIHelper.swift
//  BareksaCompare
//
//  Created by BCA-GSIT-MACBOOK-5 on 18/06/22.
//

import UIKit
import Kingfisher

extension UIViewController {
    
    func addFundTo(stackView: UIStackView, value: FundDetail, backgroundColor: UIColor) {
        
        let view = UIView()
        view.backgroundColor = backgroundColor
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        guard let url = URL(string: value.imageAvatar) else {
            return
        }
        
        imageView.kf.setImage(
            with: url,
            placeholder: UIImage(named: "image_placeholder"),
            options: [.cacheOriginalImage],
            completionHandler:  { _ in
                //Image Loaded
            }
        )
        view.addSubview(imageView)
        
        NSLayoutConstraint(item: imageView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 12.0).isActive = true
        NSLayoutConstraint(item: imageView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 12.0).isActive = true
        NSLayoutConstraint(item: imageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 40.0).isActive = true
        NSLayoutConstraint(item: imageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 40).isActive = true

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Montserrat-Semibold", size: 12.0)
        label.layer.cornerRadius = 4.0
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping

        let attrString = NSMutableAttributedString(string: value.imageName)
        attrString.addAttribute(NSAttributedString.Key.kern, value: 1.25, range: NSMakeRange(0, attrString.length))
        label.attributedText = attrString
        view.addSubview(label)
        
        NSLayoutConstraint(item: label, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 12.0).isActive = true
        NSLayoutConstraint(item: label, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: -12.0).isActive = true
        NSLayoutConstraint(item: label, attribute: .top, relatedBy: .equal, toItem: imageView, attribute: .bottom, multiplier: 1, constant: 10.0).isActive = true
        NSLayoutConstraint(item: label, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: -12.0).isActive = true
        
        stackView.addArrangedSubview(view)
    }
    
    func addTextViewTo(stackView: UIStackView, value: String, backgroundColor: UIColor) {
        let textView = UITextView()
        textView.backgroundColor = backgroundColor
        textView.font = UIFont(name: "Montserrat", size: 12.0)
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        textView.isUserInteractionEnabled = false
        textView.isEditable = false
        textView.layer.cornerRadius = 4.0
        
        let attrString = NSMutableAttributedString(string: value)
        attrString.addAttribute(NSAttributedString.Key.kern, value: 1.25, range: NSMakeRange(0, attrString.length))
        textView.attributedText = attrString
        
        stackView.addArrangedSubview(textView)
    }
        
    func createButtonWith(title: String, textColor: UIColor, backgroundColor: UIColor = .white, font: UIFont, borderWidth: CGFloat = 0, borderColor: UIColor = .white) -> UIButton {
        let button = UIButton(type: .system)
        button.titleLabel?.font = font
        button.layer.cornerRadius = 4.0
        button.setTitle(title, for: .normal)
        
        button.setTitleColor(textColor, for: .normal)
        button.backgroundColor = backgroundColor
        button.layer.borderWidth = borderWidth
        button.layer.borderColor = borderColor.cgColor
        return button
    }
    
}
