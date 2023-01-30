//
//  TagView.swift
//  Tags
//
//  Created by Misiel on 1/25/23.
//

import UIKit

class TagView: UIView {
    
    let padding = UIEdgeInsets(top: 10, left: 10, bottom: -10, right: -10)
    lazy var tagModel: TagModel = TagModel(isOpen: false, title: "", taggedItems: [])
    
    // Visible Views
    let titleButton : UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        button.titleLabel?.tintColor = .red
        button.addTarget(self, action: #selector(goToSelectedTag), for: .touchUpInside)
        return button
    }()
    
    let dropDownButton : UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.setImage(UIImage(systemName: "chevron.down"), for: .selected)
        button.addTarget(self, action: #selector(showDropDown), for: .touchUpInside)
        return button
    }()
    
    // Views for touch size
    let leftTouchView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let rightTouchView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let touchStackView : UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.distribution = .fillEqually
        sv.axis = .horizontal
        sv.backgroundColor = .lightGray
        sv.isUserInteractionEnabled = true
        return sv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        nil
    }

    func configure(with tagModel: TagModel) {
        self.tagModel = tagModel
        titleButton.setTitle(tagModel.title, for: .normal)
        dropDownButton.isSelected = tagModel.isOpen
    }
    
    private func setupUI() {
        leftTouchView.addSubview(titleButton)
        rightTouchView.addSubview(dropDownButton)
        
        addSubview(touchStackView)
        touchStackView.addArrangedSubview(leftTouchView)
        touchStackView.addArrangedSubview(rightTouchView)
        
        NSLayoutConstraint.activate([
            touchStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: padding.top),
            touchStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: padding.bottom),
            touchStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: padding.left),
            touchStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: padding.right),
            touchStackView.widthAnchor.constraint(equalToConstant: 100),
            touchStackView.heightAnchor.constraint(equalToConstant: 50),
            
            titleButton.topAnchor.constraint(equalTo: leftTouchView.topAnchor, constant: padding.top),
            titleButton.bottomAnchor.constraint(equalTo: leftTouchView.bottomAnchor, constant: padding.bottom),
            titleButton.leadingAnchor.constraint(equalTo: leftTouchView.leadingAnchor, constant: padding.left ),
            titleButton.trailingAnchor.constraint(equalTo: leftTouchView.trailingAnchor, constant: padding.right),
            
            dropDownButton.topAnchor.constraint(equalTo: rightTouchView.topAnchor, constant: padding.top),
            dropDownButton.bottomAnchor.constraint(equalTo: rightTouchView.bottomAnchor, constant: padding.bottom),
            dropDownButton.leadingAnchor.constraint(equalTo: rightTouchView.leadingAnchor, constant: padding.left + 50),
            dropDownButton.trailingAnchor.constraint(equalTo: rightTouchView.trailingAnchor, constant: padding.right),
            
//            leftTouchView.widthAnchor.constraint(equalToConstant: touchStackView.frame.width),
//            leftTouchView.heightAnchor.constraint(equalToConstant: touchStackView.frame.height),
//            rightTouchView.widthAnchor.constraint(equalToConstant: touchStackView.frame.width),
//            rightTouchView.heightAnchor.constraint(equalToConstant: touchStackView.frame.height),
        ])
    }
    
    @objc func goToSelectedTag() {
        HomeViewModel.shared.sendSelectedTag(tag: tagModel)
    }
    
    @objc func showDropDown() {
        let isOpen = tagModel.isOpen
        // set Tag's open state to opposite of what it was
        tagModel.isOpen = !isOpen
        
        dropDownButton.isSelected = tagModel.isOpen
        HomeViewModel.shared.changeTagIsOpenState(tag: tagModel)
    }
}
