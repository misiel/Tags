//
//  TagItemModel.swift
//  Tags
//
//  Created by Misiel on 2/2/23.
//

import Foundation

class TaggedItem: Codable {
    var title: String
    var data: Data?
    
    init(title: String, data: Data? = nil) {
        self.title = title
        self.data = data
    }
}
