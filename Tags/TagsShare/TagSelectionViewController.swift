//
//  TagSelectionViewController.swift
//  TagsShare
//
//  Created by Misiel on 2/2/23.
//

import Foundation
import UIKit

@objc(TagSelectionViewControllerDelegate)
protocol TagSelectionViewControllerDelegate {
    @objc optional func tagSelection(
        _ sender: TagSelectionViewController,
        selectedTag: String)
}

class TagSelectionViewController: UITableViewController {
    var listOfTags: Array<TagModel>!
    let tableViewCellIdentifier = "tagSelectionCell"
    var selectedTagTitle = "None"
    var delegate: TagSelectionViewControllerDelegate!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
        
    // Initialize the tableview
    override init(style: UITableView.Style) {
        super.init(style: style)
        tableView.register(UITableViewCell.classForCoder(),
                forCellReuseIdentifier: tableViewCellIdentifier)
        title = "Choose Tag"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfTags.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellIdentifier, for: indexPath) as UITableViewCell
        let tagTitle = listOfTags[indexPath.row].title
        cell.textLabel!.text = tagTitle
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let theDelegate = delegate {
            selectedTagTitle = listOfTags[indexPath.row].title
            theDelegate.tagSelection?(self, selectedTag: selectedTagTitle)
        }
    }
}
