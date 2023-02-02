//
//  SelectedTagViewController.swift
//  Tags
//
//  Created by Misiel on 1/29/23.
//

import UIKit

class SelectedTagViewController: ExtendedViewController {
    // This will always have a value since we navigate to this VC with a selected tag
    var selectedTag: TagModel!
    lazy var taggedItems = selectedTag.taggedItems
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.size.width/2.2, height: view.frame.size.width/3)
        layout.sectionInset = UIEdgeInsets(top: 50, left: 10, bottom: 10, right: 10)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(TagItemCustomCell.self, forCellWithReuseIdentifier: TagItemCustomCell.identifier)
        cv.dataSource = self
        cv.delegate = self
        
        return cv
    }()
    
    lazy var removeTagButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(systemName: "xmark.app")
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(deleteTag), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    private func setupUI() {
        navigationItem.title = selectedTag.title
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: removeTagButton)
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10)
        ])
    }
    
    @objc private func deleteTag() {
        HomeViewModel.shared.deleteTag(tag: selectedTag)
        navigationController?.popViewController(animated: true)
    }
}

//MARK: - collection view extensions
extension SelectedTagViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        taggedItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagItemCustomCell.identifier, for: indexPath) as? TagItemCustomCell else { return UICollectionViewCell() }
        
        cell.configure(with: taggedItems[indexPath.row])
        return cell
    }
    
    
}
