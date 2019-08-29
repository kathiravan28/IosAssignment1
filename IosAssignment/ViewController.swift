//
//  ViewController.swift
//  IosAssignment
//
//  Created by kathiravan Raju on 18/08/19.
//  Copyright © 2019 kathiravan Raju. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
   
    var refreshControl = UIRefreshControl()
    var indicator = UIActivityIndicatorView()
    
    var myTableView: UITableView  = UITableView()
    private var webservice :APILayer!
    private var sourceListViewModel :ProfileViewModel!
    private var items :[RowsModel]!
    private var dataSource :TableViewDataSource<CustomTableViewCell,RowsModel>!
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableViewUI()
        addRefreshControl()
        updateUI()
    }
   override func viewDidAppear(_ animated: Bool) {
    
    activityIndicator()
    self.indicator.isHidden = false
    self.myTableView.isHidden = true
    self.indicator.startAnimating()
    }
    func activityIndicator() {
        indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        indicator.style = UIActivityIndicatorView.Style.whiteLarge
        indicator.color = .red
        indicator.center = self.view.center
        self.view.addSubview(indicator)
    }
    func addRefreshControl() {
        
        refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor.red
        refreshControl.addTarget(self, action: #selector(ViewController.updateUI), for: .valueChanged)
        myTableView.addSubview(refreshControl)
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
    
    @objc private func updateUI() {
        
        self.webservice = APILayer()
        
        self.webservice.loadSources { (rows) in
            self.sourceListViewModel = ProfileViewModel(webservice: self.webservice)
            self.sourceListViewModel.sourceViewModels = rows
            self.updateDataSource()
        }
        
    }

    @objc private func updateDataSource() {
        
        self.dataSource = TableViewDataSource(cellIdentifier: "r_id", items: self.sourceListViewModel.sourceViewModels) { cell, vm in
            
            if vm.name != nil {
                cell.namelbl.text = vm.name
            }else {
                cell.namelbl.text = "No Name"
            }
            
            if vm.description != nil {
                cell.desclbl.text = vm.description
            }else {
                cell.namelbl.text = "No Name"
            }
            
            if vm.photoURL != nil {
                
                cell.userImage.downloadImageFrom(vm.photoURL, contentMode: .scaleAspectFit)
                
                
                
            }else {
                cell.userImage.image = UIImage(named: "F1")
                cell.userImage.image =  UIImage(named: "F1.jpg", in: Bundle(for: ViewController.self), compatibleWith: nil)
                
            }
           
        }
        DispatchQueue.main.async {
            self.indicator.isHidden = true
            self.myTableView.isHidden = false
            self.indicator.stopAnimating()
            self.setNavBar(title: self.webservice.titleValue)
            self.myTableView.dataSource = self.dataSource
            self.myTableView.reloadData()
            self.refreshControl.endRefreshing()
        }
        
    }
    
    func setNavBar(title: String) {
        self.navigationItem.title = title
    }
    
}
extension UIImageView {
    
    func downloadImageFrom(_ link:String, contentMode: UIView.ContentMode) {
        
        
        URLSession.shared.dataTask( with: URL(string:link)!, completionHandler: {
            
            (data, response, error) -> Void in
            
            DispatchQueue.main.async {
                
                self.contentMode =  contentMode
                
                if let data = data {
                    
                    self.image = UIImage(data: data)

                }
                
            }
            
        }).resume()
        
    }
    
}
