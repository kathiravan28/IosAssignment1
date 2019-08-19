//
//  ProfileViewModel.swift
//  IosAssignment
//
//  Created by kathiravan Raju on 18/08/19.
//  Copyright © 2019 kathiravan Raju. All rights reserved.
//

import Foundation
import UIKit


class ProfileViewModel: NSObject {
    
    var sourceViewModels = [RowsModel]()
    private var webservice :APILayer
    var bindToSourceViewModels :(() -> ()) = {  }
    
    init(webservice :APILayer) {
        self.webservice = webservice
        super.init()
        self.bindToSourceViewModels()
    }
}

protocol ProfileViewModelItem {
    var sectionTitle: String { get }
}
