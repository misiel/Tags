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
    @Published var selectedTag: TagModel
    
    init() {
        tagWithChangedState = TagModel(isOpen: false, title: "", taggedItems: [])
        selectedTag = TagModel(isOpen: false, title: "", taggedItems: [])
    }
    
    func changeTagIsOpenState(tag: TagModel) {
        self.tagWithChangedState = tag
    }
    
    func sendSelectedTag(tag: TagModel) {
        self.selectedTag = tag
    }
}
