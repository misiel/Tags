//
//  TagModel.swift
//  Tags
//
//  Created by Misiel on 1/25/23.
//

import UIKit

class TagModel: Equatable, Hashable, Codable {
    
    var isOpen: Bool
    var title: String
    var taggedItems: [TaggedItem]
    
    init(isOpen: Bool, title: String, taggedItems: [TaggedItem]) {
        self.isOpen = isOpen
        self.title = title
        self.taggedItems = taggedItems
    }
    
    static func == (lhs: TagModel, rhs: TagModel) -> Bool {
        return lhs.title == rhs.title
    }
    
    // Each Tag will have a unique title
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
}
