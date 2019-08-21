//
//  DataSource.swift
//  IosAssignment
//
//  Created by kathiravan Raju on 18/08/19.
//  Copyright © 2019 kathiravan Raju. All rights reserved.
//

import Foundation
import UIKit

class TableViewDataSource<Cell :UITableViewCell,RowsModel> : NSObject, UITableViewDataSource, UITableViewDelegate {
    
    private var cellIdentifier :String!
    private var items :[RowsModel]!
    var configureCell :(Cell,RowsModel) -> ()
    
    init(cellIdentifier :String, items :[RowsModel], configureCell: @escaping (Cell,RowsModel) -> ()) {
        
        self.cellIdentifier = cellIdentifier
        self.items = items
        self.configureCell = configureCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as? Cell
        let item = self.items[indexPath.row]
        self.configureCell(cell!,item)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
