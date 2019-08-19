//
//  RowViewModelItem.swift
//  IosAssignment
//
//  Created by kathiravan Raju on 18/08/19.
//  Copyright © 2019 kathiravan Raju. All rights reserved.
//

import Foundation

struct RowViewModelItem {
    var sectionTitle: String {
        return "Main Info"
    }
    var name: String
    var photoURL: String
    var description: String
    
    init(name: String, photoURL: String, description: String) {
        self.name = name
        self.photoURL = photoURL
        self.description = description
    }
}
