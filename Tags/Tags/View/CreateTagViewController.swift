//
//  CreateTagViewController.swift
//  Tags
//
//  Created by Misiel on 2/1/23.
//

import Foundation
import UIKit
import Combine

class CreateTagViewController: ExtendedViewController {
    
    let padding = UIEdgeInsets(top: 10, left: 10, bottom: -10, right: -10)
    
    lazy var dismissButton : UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(systemName: "checkmark.circle")
        button.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(saveTag), for: .touchUpInside)
        return button
    }()
    
    lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Add Tag"
        label.font = UIFont.systemFont(ofSize: 32, weight: .heavy)
        return label
    }()
    
    lazy var textField : UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.frame = CGRect(x: 0, y: 0, width: 300, height: 40)
        tf.placeholder = "Enter Tag name..."
        tf.borderStyle = .roundedRect
        tf.textAlignment = .center
        return tf
    }()
    
    lazy var backgroundDismissView : UIView = {
        let bg = UIView()
        bg.translatesAutoresizingMaskIntoConstraints = false
        bg.backgroundColor = UIColor(
            red: 0.8,
            green: 0.5,
            blue: 0.2,
            alpha: 1.0)
        bg.isUserInteractionEnabled = true
        bg.layer.cornerRadius = 20
        
        return bg
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundDismissView.addSubview(dismissButton)
        backgroundDismissView.addSubview(titleLabel)
        backgroundDismissView.addSubview(textField)
        view.addSubview(backgroundDismissView)
        
        NSLayoutConstraint.activate([
            backgroundDismissView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backgroundDismissView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            backgroundDismissView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            backgroundDismissView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
            
            dismissButton.topAnchor.constraint(equalTo: backgroundDismissView.topAnchor, constant: padding.top),
            dismissButton.trailingAnchor.constraint(equalTo: backgroundDismissView.trailingAnchor, constant: padding.right ),
            dismissButton.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: backgroundDismissView.topAnchor, constant: padding.top),
            titleLabel.leadingAnchor.constraint(equalTo: backgroundDismissView.leadingAnchor, constant: padding.left),

            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding.top + 50),
            textField.leadingAnchor.constraint(equalTo: backgroundDismissView.leadingAnchor, constant: padding.left),
            textField.trailingAnchor.constraint(equalTo: dismissButton.trailingAnchor),
            
        ])
        
        // View dismisses if tapped in transparent background view
        // TODO: This should only activate on the transparent background and not the bounds of `backgroundDismissView`
        modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func saveTag() {
        if let tagTitle = textField.text {
            if !(tagTitle.isEmpty) {
                HomeViewModel.shared.saveTag(tagTitle: tagTitle)
            }
        }
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func dismissView() {
        dismiss(animated: true, completion: nil)
    }
}
