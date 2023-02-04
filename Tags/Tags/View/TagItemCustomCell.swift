//
//  TagItemCustomCell.swift
//  Tags
//
//  Created by Misiel on 1/29/23.
//

import UIKit

class TagItemCustomCell: UICollectionViewCell {
    static let identifier = "TagItemCustomCell"
    var tagItem: TaggedItem!
    
    private let padding = UIEdgeInsets(top: 10, left: 10, bottom: -10, right: -10)
    
    let title : UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = UIFont.systemFont(ofSize: 32, weight: .heavy)
        text.textAlignment = .center
        text.textColor = .white
        return text
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .orange
        view.layer.cornerRadius = 20
        return view
    }()
    
    lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        return iv
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
        containerView.addSubview(imageView)
        contentView.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: padding.top),
            containerView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: padding.bottom),
            containerView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: padding.left),
            containerView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: padding.right),
            
            title.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding.top),
            title.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding.left),
            title.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: padding.right),
            
            imageView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: padding.top),
            imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding.left),
            imageView.trailingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding.right),
            imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: padding.bottom-10),
            imageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
        ])
    }
    
    func configure(with tagItem: TaggedItem){
        self.tagItem = tagItem
        title.text = tagItem.title
        
        guard let data = tagItem.data else {return}
        processData(data: data)
    }
    
    private func processData(data: Data) {
        if let image = UIImage(data: data) {
            DispatchQueue.main.async {
                // the data is an image
                self.imageView.image = image
            }
        }
    }
    
}
