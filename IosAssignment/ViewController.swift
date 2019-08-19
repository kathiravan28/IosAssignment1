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
    private var webservice :APILayer!
    private var sourceListViewModel :ProfileViewModel!
    private var items :[RowsModel]!
    private var dataSource :TableViewDataSource<CustomTableViewCell,RowsModel>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableViewUI()
        
        updateUI()
        
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
    
    
    private func updateUI() {
        
        self.webservice = APILayer()
        
        self.webservice.loadSources { (Rows) in
            self.sourceListViewModel = ProfileViewModel(webservice: self.webservice)
            self.sourceListViewModel.sourceViewModels = Rows
            self.updateDataSource()
        }
        
    }
    
    private func updateDataSource() {
        
        self.dataSource = TableViewDataSource(cellIdentifier: "r_id", items: self.sourceListViewModel.sourceViewModels) { cell, vm in
            
            if vm.name != nil {
                cell.namelbl.text = vm.name
            }else{
                cell.namelbl.text = "No Name"
            }
            
            if vm.description != nil {
                cell.desclbl.text = vm.description
            }else{
                cell.namelbl.text = "No Name"
            }
            
            if vm.photoURL != nil {
                
                cell.userImage.downloadImageFrom(vm.photoURL, contentMode: .scaleAspectFit)
                
                
                
            }else{
                // print(vm.photoURL)
                cell.userImage.image = UIImage(named: "F1")
                cell.userImage.image =  UIImage(named: "F1.jpg", in: Bundle(for: ViewController.self), compatibleWith: nil)
                
            }
           
        }
        DispatchQueue.main.async {
            self.setNavBar(title: "About canada")
            self.myTableView.dataSource = self.dataSource
            self.myTableView.reloadData()
        }
        //        self.myTableView.dataSource = self.dataSource
        //        self.myTableView.reloadData()
        
        //
    }
    
    func setNavBar(title: String) {
        self.navigationItem.title = title
    }
    
}
extension UIImageView {
    
    func downloadImageFrom(_ link:String, contentMode: UIView.ContentMode) {
        
        
        
        URLSession.shared.dataTask( with: URL(string:link)!, completionHandler: {
            
            (data, response, error) -> Void in
            
            
            
            print(error?.localizedDescription)
            
            DispatchQueue.main.async  {
                
                self.contentMode =  contentMode
                
                if let data = data {
                    
                    self.image = UIImage(data: data)
                    
                    
                    
                }
                
            }
            
        }).resume()
        
    }
    
}
