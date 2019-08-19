//
//  RowsModel.swift
//  IosAssignment
//
//  Created by kathiravan Raju on 18/08/19.
//  Copyright © 2019 kathiravan Raju. All rights reserved.
//

import Foundation
class RowsModel {
    
    
    var name :String!
    var photoURL :String!
    var description :String!
    
    init?(dictionary :[String : Any]) {
        
        //        guard let name = dictionary["title"] as? String,
        //            let description = dictionary["description"], let photoURL = dictionary["imageHref"] as? String else {
        //                return nil
        //        }
        
        
        if let name = dictionary["title"] as? String {
            self.name = name
        }
        
        if let photoURL = dictionary["imageHref"] as? String {
            self.photoURL = photoURL
        }
        
        if let description = dictionary["description"] as? String {
            self.description = description
        }
        
    }
    
    init(viewModel :RowViewModelItem) {
        
        
        self.name = viewModel.name
        self.photoURL = viewModel.photoURL
        self.description = viewModel.description
    }
    
}
