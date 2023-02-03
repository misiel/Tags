//
//  HomeViewModel.swift
//  Tags
//
//  Created by Misiel on 1/26/23.
//

import Combine
import Foundation

class HomeViewModel {
    static let shared = HomeViewModel()
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    private let saved_tags_key = "saved_tags"
    let defaults = UserDefaults(suiteName: "group.tags.container")!
    
    @Published var tagWithChangedState: TagModel
    @Published var selectedTag: TagModel
    @Published var refreshTags: ()!
    
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
    
    func getTags() -> Set<TagModel> {
        guard let list = defaults.data(forKey: saved_tags_key) else {return Set()}
        let decodedList = try! decoder.decode(Set<TagModel>.self, from: list)
        return decodedList
    }
    
    func saveTag(tagTitle: String) {
        let tag = TagModel(isOpen: false, title: tagTitle.lowercased(), taggedItems: [])
        var savedTags = self.getTags()
        savedTags.insert(tag)
        let encodedList = try! encoder.encode(savedTags)
        defaults.set(encodedList, forKey: saved_tags_key)
        
        print("save tag ")

        // tell HomeVC to refresh tags after modify
        self.refreshTags = ()
    }
    
    func saveTagWithItem(tagTitle: String, withItem newItem: TaggedItem) {
        let tag = TagModel(isOpen: false, title: tagTitle.lowercased(), taggedItems: [newItem])
        var savedTags = self.getTags()
        if (savedTags.contains(tag)) {
            // Our set only compares Tags on their titles so this will give us the previous saved tag with same title
            let oldTag = savedTags.first(where: {$0 == tag})!
            let oldTaggedItems = oldTag.taggedItems
            
            tag.taggedItems.append(contentsOf: oldTaggedItems)
        }
        savedTags.update(with: tag)
        let encodedList = try! encoder.encode(savedTags)
        defaults.set(encodedList, forKey: saved_tags_key)
        
        print("save tag with item")
        // tell HomeVC to refresh tags after modify
        self.refreshTags = ()
    }
    
    func deleteTag(tag: TagModel) {
        var savedTags = self.getTags()
        savedTags.remove(tag)
        let encodedList = try! encoder.encode(savedTags)
        defaults.set(encodedList, forKey: saved_tags_key)
        
        print("delete tag")

        // tell HomeVC to refresh tags after modify
        self.refreshTags = ()
    }
}
