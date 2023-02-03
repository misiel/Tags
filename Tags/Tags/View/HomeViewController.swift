//
//  ViewController.swift
//  Tags
//
//  Created by Misiel on 1/24/23.
//

import Combine
import UIKit

class HomeViewController: ExtendedViewController {
    private var cancellables = Set<AnyCancellable>()
    
    lazy var refreshControl : UIRefreshControl = {
        let rc = UIRefreshControl()
        rc.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        return rc
    }()
    
    lazy var tableView: UITableView =  {
        let tv = UITableView()
        tv.refreshControl = refreshControl
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.delegate = self
        tv.dataSource = self
        tv.separatorStyle = .none
        tv.allowsSelection = false
        tv.register(DropDownCell.self, forCellReuseIdentifier: DropDownCell.identifier)
        return tv
    }()
    
    lazy var addTagButton: UIButton = {
        let button = UIButton(type: .custom)
        let image = UIImage(named: "plus")
        button.setImage(image, for: .normal)
        button.widthAnchor.constraint(equalToConstant: 50).isActive = true
        button.addTarget(self, action: #selector(createTag), for: .touchUpInside)
        return button
    }()
    
    lazy var refreshLabelBefore : UILabel = {
        let rl = UILabel()
        rl.translatesAutoresizingMaskIntoConstraints = false
        rl.text = "Pull to refresh"
        rl.textAlignment = .center
        rl.font = UIFont.systemFont(ofSize: 14)
        rl.textColor = .lightGray
        return rl
    }()
    
    lazy var refreshLabelAfter : UILabel = {
        let rl = UILabel()
        rl.translatesAutoresizingMaskIntoConstraints = false
        rl.text = "Refreshing..."
        rl.textAlignment = .center
        rl.font = UIFont.systemFont(ofSize: 14)
        rl.textColor = .lightGray
        return rl
    }()
    
/* Sample Data
        let tags : [TagModel] =
        [TagModel(isOpen: false, title: "Tag1", taggedItems: [TaggedItem(title: "row1"), TaggedItem(title: "row2"), TaggedItem(title: "row3")]),
         TagModel(isOpen: false, title: "Tag2", taggedItems: [TaggedItem(title: "row1"), TaggedItem(title: "row2")]),
        TagModel(isOpen: false, title: "Tag3", taggedItems: [TaggedItem(title: "row1")])]
*/
    var tags : [TagModel] = Array(HomeViewModel.shared.getTags())

    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        setupUI()
        HomeViewModel.shared.$tagWithChangedState
            .dropFirst()
            .sink { [weak self] tag in
                DispatchQueue.main.async {
                    var indexPaths = [IndexPath]()
                    guard let tagSection = self?.tags.firstIndex(of: tag) else {return}
                    guard let taggedItems = self?.tags[tagSection].taggedItems else {return}
                    for row in taggedItems.indices {
                        let idxPath = IndexPath(row: row, section: tagSection)
                        indexPaths.append(idxPath)
                    }
                                        
                    if tag.isOpen {
                        self?.tableView.insertRows(at: indexPaths, with: .fade)
                    }
                    else {
                        self?.tableView.deleteRows(at: indexPaths, with: .fade)
                    }
                }
            }
            .store(in: &cancellables)
        
        HomeViewModel.shared.$selectedTag
            .dropFirst()
            .sink { [weak self] tag in
                DispatchQueue.main.async {
                    let vc = SelectedTagViewController()
                    vc.selectedTag = tag
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
            }
            .store(in: &cancellables)
        
        HomeViewModel.shared.$refreshTags
            .dropFirst()
            .sink { [weak self] tag in
                print("We did something to tag so tableview should refresh")
                DispatchQueue.main.async {
                    self?.tags = Array(HomeViewModel.shared.getTags())
                    self?.tableView.reloadData()
                }
            }
            .store(in: &cancellables)
    }
    
    private func setupUI() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addTagButton)
        navigationItem.title = "TagIt!"
        
        view.backgroundColor = .white
        refreshControl.addSubview(refreshLabelAfter)
        view.addSubview(refreshLabelBefore)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            refreshLabelAfter.centerXAnchor.constraint(equalTo: refreshControl.centerXAnchor),
            refreshLabelAfter.bottomAnchor.constraint(equalTo: refreshControl.bottomAnchor),
            
            refreshLabelBefore.topAnchor.constraint(equalTo: tableView.bottomAnchor),
            refreshLabelBefore.centerXAnchor.constraint(equalTo: tableView.centerXAnchor)
        ])
    }
    
    @objc private func createTag() {
        // show popup that prompts user to make a title for a Tag
        // Take text from tag and create a new Tag and save it to HomeViewModel
        // refresh tableView
        let createTagVC = CreateTagViewController()
        createTagVC.modalPresentationStyle = .overCurrentContext
        present(createTagVC, animated: true)
    }
    
    @objc private func refreshData() {
        DispatchQueue.main.async {
            self.tags = Array(HomeViewModel.shared.getTags())
            self.tableView.reloadData()
        }
        print("data refreshed")
        refreshControl.endRefreshing()
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
        cell.title.text = tags[indexPath.section].taggedItems[indexPath.row].title
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        guard let selectedCell = tableView.cellForRow(at: indexPath) as? DropDownCell else {return}
//        print("button tapped")
//    }
}
