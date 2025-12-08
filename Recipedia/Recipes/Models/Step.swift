//
//  Step.swift
//  Recipedia
//
//  Created by Pablo García López on 6/12/25.
//

import Foundation

class Step: Codable {
    private(set) var id: UUID
    var title: String
    var instruction: String
    
    init(id: UUID = UUID(), title: String, instruction: String) {
        self.id = id
        self.title = title
        self.instruction = instruction
    }
}
