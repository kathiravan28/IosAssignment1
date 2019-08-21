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
                    
                    let json = try? JSONSerialization.jsonObject(with: dataUTF8, options: [])
                    let sourceDictionary = json as? JSONDictionary
                    let dictionaries = sourceDictionary?["rows"] as? [JSONDictionary]
                    var sources : [RowsModel] = [RowsModel]()
                    for itm in dictionaries! {
                        print("\(itm)")
                        sources.append(RowsModel.init(dictionary: itm) ?? sources[0])
                        
                    }
                    
                    DispatchQueue.main.async {
                        completion(sources)
                    }
                }
            }
            
            }.resume()
        
    }
}

class Web {
    
    func getArticles(url: URL, completion: @escaping(String?) -> ()) {
        
        URLSession.shared.dataTask(with: url) {data, response, error in
            
            if let error = error {
                
                print(error.localizedDescription)
            }
            else if let data = data {
                let strISOLatin = String(data: data, encoding: .isoLatin1)
                let dataUTF8 = strISOLatin?.data(using: .utf8)
                
                
                if let dataUTF8 = dataUTF8 {
                    let rowList = try? JSONDecoder().decode(Row.self, from: dataUTF8)
                    
                    
                    completion(rowList?.title)
                    

                }
            }
            
            }.resume()
        
    }
    
}
