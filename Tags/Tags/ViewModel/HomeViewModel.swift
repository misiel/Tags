//
//  HomeViewModel.swift
//  Tags
//
//  Created by Misiel on 1/26/23.
//

import Combine

class HomeViewModel {
    static let shared = HomeViewModel()
    
    @Published var tagIsOpenState: Bool = false
    
    func changeTagIsOpenState() {
        self.tagIsOpenState = !self.tagIsOpenState
    }
}
