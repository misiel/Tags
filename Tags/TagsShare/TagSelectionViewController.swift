//
//  TagSelectionViewController.swift
//  TagsShare
//
//  Created by Misiel on 2/2/23.
//

import Foundation
import UIKit

class TagSelectionViewController: UITableViewController {
    var listOfTags: Set<TagModel>!
    let tableViewCellIdentifier = "tagSelectionCell"
    var selectedTagTitle = "None"
    var delegate: TagSelectionViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfTags.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellIdentifier, for: indexPath) as UITableViewCell
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let setToList = Array(listOfTags)
        if let theDelegate = delegate {
            selectedTagTitle = setToList[indexPath.row].title
            theDelegate.tagSelection?(self, selectedTag: selectedTagTitle)
        }
    }
}
