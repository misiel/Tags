//
//  TagModel.swift
//  Tags
//
//  Created by Misiel on 1/25/23.
//

import UIKit

class TagModel {
    var isOpen: Bool
    var title: String
    var taggedItems: [String]
    
    init(isOpen: Bool, title: String, taggedItems: [String]) {
        self.isOpen = isOpen
        self.title = title
        self.taggedItems = taggedItems
    }
}
