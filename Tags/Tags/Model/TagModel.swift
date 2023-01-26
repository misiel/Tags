//
//  TagModel.swift
//  Tags
//
//  Created by Misiel on 1/25/23.
//

import UIKit

class TagModel: Equatable {
    static func == (lhs: TagModel, rhs: TagModel) -> Bool {
        return
            (lhs.title == rhs.title &&
             lhs.taggedItems == rhs.taggedItems)
    }
    
    var isOpen: Bool
    var title: String
    var taggedItems: [String]
    
    init(isOpen: Bool, title: String, taggedItems: [String]) {
        self.isOpen = isOpen
        self.title = title
        self.taggedItems = taggedItems
    }
}
