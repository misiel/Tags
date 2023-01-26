//
//  DropDownCell.swift
//  Tags
//
//  Created by Misiel on 1/25/23.
//

import UIKit

class DropDownCell: UITableViewCell {
    static let identifier = "DropCownCell"
    
    let padding = UIEdgeInsets(top: 10, left: 10, bottom: -10, right: -10)
    let title : UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textColor = .black
        title.font = UIFont.systemFont(ofSize: 12)
        return title
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder) is not implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(title)
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: padding.top),
            title.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: padding.bottom),
            title.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: padding.right),
            title.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: padding.left)
        ])
    }
}
