//
//  HomeViewModel.swift
//  Tags
//
//  Created by Misiel on 1/26/23.
//

import Combine

class HomeViewModel {
    static let shared = HomeViewModel()
    
    @Published var tagWithChangedState: TagModel
    
    init() {
        tagWithChangedState = TagModel(isOpen: false, title: "", taggedItems: [])
    }
    
    func changeTagIsOpenState(tag: TagModel) {
        self.tagWithChangedState = tag
    }
}
