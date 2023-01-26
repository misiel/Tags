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
    
    let title : UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textColor = .red
        title.font = UIFont.systemFont(ofSize: 16)
        return title
    }()
    
    let dropDownButton : UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.setImage(UIImage(systemName: "chevron.down"), for: .selected)
        button.addTarget(self, action: #selector(showDropDown), for: .touchUpInside)
        return button
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
        title.text = tagModel.title
        dropDownButton.isSelected = tagModel.isOpen
    }
    
    private func setupUI() {
        addSubview(title)
        addSubview(dropDownButton)
        
        setupDropDownButton()
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: padding.top),
            title.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: padding.bottom),
            title.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: padding.left)
        ])
    }
    
    private func setupDropDownButton() {
        NSLayoutConstraint.activate([
            dropDownButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: padding.top),
            dropDownButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: padding.bottom),
            dropDownButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: padding.right),
        ])
    }
    
    @objc func showDropDown() {
        let isOpen = tagModel.isOpen
        // set Tag's open state to opposite of what it was
        tagModel.isOpen = !isOpen
        
        dropDownButton.isSelected = tagModel.isOpen
        HomeViewModel.shared.changeTagIsOpenState(tag: tagModel)
    }
}
