//
//  TagItemCustomCell.swift
//  Tags
//
//  Created by Misiel on 1/29/23.
//

import UIKit

class TagItemCustomCell: UICollectionViewCell {
    static let identifier = "TagItemCustomCell"
    var tagItem: String!
    
    private let padding = UIEdgeInsets(top: 10, left: 10, bottom: -10, right: -10)
    let title : UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = UIFont.systemFont(ofSize: 18, weight: .heavy)
        return text
    }()
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .orange
        view.layer.cornerRadius = 20
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        
    }
    required init?(coder: NSCoder) {
        fatalError("TagItemCustomCell could not be init")
    }
    
    private func setupUI() {
        containerView.addSubview(title)
        contentView.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: padding.top),
            containerView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: padding.bottom),
            containerView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: padding.left),
            containerView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: padding.right),
            
            title.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding.top),
            title.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding.left)
        ])
    }
    
    func configure(with tagItem: String){
        self.tagItem = tagItem
        title.text = tagItem
    }
}
