//
//  Step.swift
//  Recipedia
//
//  Created by Pablo García López on 6/12/25.
//

import Foundation

class Step: Codable {
    private(set) var stepId: UUID
    var title: String
    var instruction: String
    
    init(stepId: UUID = UUID(), title: String, instruction: String) {
        self.stepId = stepId
        self.title = title
        self.instruction = instruction
    }
}
