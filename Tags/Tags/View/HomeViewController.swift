//
//  ViewController.swift
//  Tags
//
//  Created by Misiel on 1/24/23.
//

import Combine
import UIKit

class HomeViewController: UIViewController {
    private var cancellables = Set<AnyCancellable>()
    
    lazy var tableView: UITableView =  {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.delegate = self
        tv.dataSource = self
        tv.separatorStyle = .none
        tv.allowsSelection = false
        tv.register(DropDownCell.self, forCellReuseIdentifier: DropDownCell.identifier)
        return tv
    }()
    
    let tags : [TagModel] =
        [TagModel(isOpen: false, title: "Tag1", taggedItems: ["row1", "row2", "row3"]),
         TagModel(isOpen: false, title: "Tag2", taggedItems: ["row1", "row2"]),
         TagModel(isOpen: false, title: "Tag3", taggedItems: ["row1"])]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        HomeViewModel.shared.$tagIsOpenState
            .dropFirst()
            .sink { [weak self] state in
                DispatchQueue.main.async {
                    print("home")
                    self?.tableView.reloadData()
                }
            }
            .store(in: &cancellables)
    }
    

    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}
// MARK: - table view extension
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    //---HEADER---
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let tag = tags[section]
        let view = TagView()
        view.configure(with: tag)
        return view
    }
    
    // each Tag is a tableview section
    func numberOfSections(in tableView: UITableView) -> Int {
        return tags.count
    }
    
    //---SECTIONS & ROWS---
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let tag = tags[section]
        if (tag.isOpen == false) {
            return 0
        }
        return tag.taggedItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DropDownCell.identifier, for: indexPath) as? DropDownCell else {return UITableViewCell()}
        cell.title.text = tags[indexPath.section].taggedItems[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedCell = tableView.cellForRow(at: indexPath) as? DropDownCell else {return}
        print("button tapped")
    }
}
