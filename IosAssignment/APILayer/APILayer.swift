//
//  APILayer.swift
//  IosAssignment
//
//  Created by kathiravan Raju on 18/08/19.
//  Copyright © 2019 kathiravan Raju. All rights reserved.
//

import Foundation

class APILayer {
    
    typealias JSONDictionary = [String:Any]
    private let sourcesURL = URL(string: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json")!
    
    func loadSources(completion :@escaping ([RowsModel]) -> ()) {
        
        URLSession.shared.dataTask(with: sourcesURL) { data, _, _ in
            
            if let data = data {
                let strISOLatin = String(data: data, encoding: .isoLatin1)
                let dataUTF8 = strISOLatin?.data(using: .utf8)
                
                if let dataUTF8 = dataUTF8 {
                    
                    let json = try! JSONSerialization.jsonObject(with: dataUTF8, options: [])
                    let sourceDictionary = json as! JSONDictionary
                    let dictionaries = sourceDictionary["rows"] as! [JSONDictionary]
                    var sources : [RowsModel] = [RowsModel]()
                    for i in dictionaries {
                        print("\(i)")
                        sources.append(RowsModel.init(dictionary: i) ?? sources[0])
                        
                    }
                    
                    DispatchQueue.main.async {
                        completion(sources)
                    }
                }
            }
            
            }.resume()
        
    }
}
