//
//  ViewController.swift
//  IosAssignment
//
//  Created by kathiravan Raju on 18/08/19.
//  Copyright © 2019 kathiravan Raju. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
     var myTableView: UITableView  = UITableView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableViewUI()
        
    }
    func tableViewUI() {
        
        myTableView = UITableView.init(frame: CGRect.zero, style: .plain)
        myTableView.dataSource = self as? UITableViewDataSource
        myTableView.delegate = self as? UITableViewDelegate
        myTableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "r_id")
        view.addSubview(myTableView)
        myTableView.translatesAutoresizingMaskIntoConstraints = false
        myTableView.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
        myTableView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        myTableView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        myTableView.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = true
        myTableView.estimatedRowHeight = 50
        myTableView.rowHeight = UITableView.automaticDimension
    }

}

