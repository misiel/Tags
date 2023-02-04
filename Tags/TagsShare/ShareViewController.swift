//
//  ShareViewController.swift
//  TagsShare
//
//  Created by Misiel on 1/31/23.
//

import UIKit
import Social
import UniformTypeIdentifiers

class ShareViewController: SLComposeServiceViewController, TagSelectionViewControllerDelegate {
    private let typeText = UTType.text.identifier
    private let typeURL = UTType.url.identifier
    private let typeImage = UTType.image.identifier
    
    let listOfTags = HomeViewModel.shared.getTags()
    var selectedTag: String!
    var selectedTagName = "None"
    var tagItemTitle: String!
    
    lazy var tagConfigurationItem: SLComposeSheetConfigurationItem = {
        let item = SLComposeSheetConfigurationItem()
        item!.title = "Tags"
        item!.value = self.selectedTagName
        item!.tapHandler = self.showTagSelection
        return item!
    }()
    
    private func showTagSelection() {
        let vc = TagSelectionViewController(style: UITableView.Style.plain)
        vc.delegate = self
        vc.listOfTags = Array(self.listOfTags)
        pushConfigurationViewController(vc)
    }
    
    func tagSelection(_ sender: TagSelectionViewController, selectedTag: String) {
        tagConfigurationItem.value = selectedTag
        self.selectedTagName = selectedTag
        popConfigurationViewController()
    }
    
    override func isContentValid() -> Bool {
        // Do validation of contentText and/or NSExtensionContext attachments here
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
    }
    
    override func didSelectPost() {
        // With selectedTagName and tagItemTitle, we should called HomeViewModel.saveTagWithItem:
        // TODO: to avoid errors we probably want to make "Save" only appear when user has selected a tag and typed a title
        if let content = extensionContext!.inputItems[0] as? NSExtensionItem {
            if let contents = content.attachments {
                for attachment in contents {
                    saveAttachment(attachment: attachment, title: contentText)
                }
            }
        }
        
        // Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
        super.didSelectPost()
    }

    override func configurationItems() -> [Any]! {
        // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
        return [tagConfigurationItem]
    }

    private func setupUI() {
        placeholder = "Name your saved item..."
        // Change Post button text.
        for item in (self.navigationController?.navigationBar.items)! {
            if let rightItem = item.rightBarButtonItem {
                rightItem.title = "Save"
                break
            }
        }
    }
    
    private func saveAttachment(attachment: NSItemProvider, title: String) {
        let imageType = typeImage
        let urlType = typeURL
        
        if attachment.hasItemConformingToTypeIdentifier(imageType) {
            attachment.loadItem(forTypeIdentifier: imageType, completionHandler: { data, error in
                let url = data as! NSURL
                if (!self.selectedTagName.isEmpty || self.selectedTagName != "None"){
                    if let imageData = NSData(contentsOf: url as URL) {
                        let taggedItem = TaggedItem(title: title, data: imageData as Data)
                        HomeViewModel.shared.saveTagWithItem(tagTitle: self.selectedTagName, withItem: taggedItem)
                    }
                }
            })
        }
    }
    
}
