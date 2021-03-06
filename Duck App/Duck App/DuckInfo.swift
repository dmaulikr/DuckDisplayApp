//
//  DuckInfo.swift
//  Duck App
//
//  Duck Info object stores details of a duck card when presented
//
//  Created by Auburn University Senior Design on 4/6/17.
//  Copyright © 2017 Auburn University. All rights reserved.
//

import UIKit

class DuckInfo {
    
    // MARK: Constants
    
    // Indices needed to construct text information array
    static let NUM_TEXT_SLOTS = 12
    enum TextInfoIndices: Int {
        case imageLabel
        case audioPath
        case name
        case scienceName
        case desc
        case behavior
        case food
        case habitat
        case nesting
        case conservation
        case funFacts
        case extraPhotos
    }
    
    // MARK: Properties
    var duckImage: UIImage?
    var duckImageLabel: String
    var duckAudioPath: String
    var duckName: String
    var duckScienceName: String
    var duckDesc: String
    var duckBehavior: String
    var duckFood: String
    var duckHabitat: String
    var duckNesting: String
    var duckConservation: String
    var duckFunFacts: String
    var duckExtraPhotos: String
    
    // MARK: Initialization
    init? (duckImage: UIImage?, textInfoArray: [String]) {
        // Init fails if string array is empty OR improper number of elements present
        guard !textInfoArray.isEmpty && (textInfoArray.count == DuckInfo.NUM_TEXT_SLOTS) else {
            return nil
        }
        
        // Assign values to object
        self.duckImage = duckImage
        
        // Iterate through array, values need to match up, index-for-index
        self.duckImageLabel = textInfoArray[TextInfoIndices.imageLabel.rawValue]
        self.duckAudioPath = textInfoArray[TextInfoIndices.audioPath.rawValue]
        self.duckName = textInfoArray[TextInfoIndices.name.rawValue]
        self.duckScienceName = textInfoArray[TextInfoIndices.scienceName.rawValue]
        self.duckDesc = textInfoArray[TextInfoIndices.desc.rawValue]
        self.duckBehavior = textInfoArray[TextInfoIndices.behavior.rawValue]
        self.duckFood = textInfoArray[TextInfoIndices.food.rawValue]
        self.duckHabitat = textInfoArray[TextInfoIndices.habitat.rawValue]
        self.duckNesting = textInfoArray[TextInfoIndices.nesting.rawValue]
        self.duckConservation = textInfoArray[TextInfoIndices.conservation.rawValue]
        self.duckFunFacts = textInfoArray[TextInfoIndices.funFacts.rawValue]
        self.duckExtraPhotos = textInfoArray[TextInfoIndices.extraPhotos.rawValue]
    }
    
}
