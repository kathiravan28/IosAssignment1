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
    var myTableView: UITableView  = UITableView()
    private var webservice :APILayer!
    
    private var sourceListViewModel :ProfileViewModel!
    private var items :[RowsModel]!
    private var dataSource :TableViewDataSource<CustomTableViewCell,RowsModel>!
    var titleValue: String = ""
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUp()
        tableViewUI()
        addRefreshControl()
        updateUI()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if CheckInternet.connection() {
            self.alert(message: "Connected")
        }
        else {
            self.alert(message: "Your Device is not connected with internet")
        }
        
    }
    
    func alert (message: String) {
        
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    func addRefreshControl() {
        
        refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor.red
        refreshControl.addTarget(self, action: #selector(refreshList), for: .valueChanged)
        myTableView.addSubview(refreshControl)
        
        
    }
    
    @objc func refreshList() {
        
        refreshControl.endRefreshing()
        myTableView.reloadData()
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
        
        self.webservice.loadSources { (rows) in
            self.sourceListViewModel = ProfileViewModel(webservice: self.webservice)
            self.sourceListViewModel.sourceViewModels = rows
            
            
           // self.setNavBar(title: ro)
            
            self.updateDataSource()
        }
        
    }

    private func updateDataSource() {
        
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
                // print(vm.photoURL)
                cell.userImage.image = UIImage(named: "F1")
                cell.userImage.image =  UIImage(named: "F1.jpg", in: Bundle(for: ViewController.self), compatibleWith: nil)
                
            }
           
        }
        DispatchQueue.main.async {
            self.setNavBar(title: self.titleValue)
            self.myTableView.dataSource = self.dataSource
            self.myTableView.reloadData()
        }
        
    }
    
    func setNavBar(title: String) {
        self.navigationItem.title = title
    }
    
    func setUp() {
        let url = URL(string: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json")!
        
        Web().getArticles(url: url) { (tit) in
            
            print(tit!)
            
            if let tit = tit {
                
            self.titleValue = tit
                
            }
        }
        
    }
    
}
extension UIImageView {
    
    func downloadImageFrom(_ link:String, contentMode: UIView.ContentMode) {
        
        
        URLSession.shared.dataTask( with: URL(string:link)!, completionHandler: {
            
            (data, response, error) -> Void in
            
            
            
//            print(error?.localizedDescription)
            
            DispatchQueue.main.async {
                
                self.contentMode =  contentMode
                
                if let data = data {
                    
                    self.image = UIImage(data: data)
                    
                    
                    
                }
                
            }
            
        }).resume()
        
    }
    
}
