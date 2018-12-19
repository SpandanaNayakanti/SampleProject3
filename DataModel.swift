//
//  DataModel.swift
//  InfyProject
//
//  Created by Spandana Nayakanti on 12/11/18.
//  Copyright © 2018 Spandana. All rights reserved.
//

import UIKit

class DataModel: NSObject {
    /**! Method to parse the response data into the above declared objects
     @param sender Response Dictionary reference */
    var typeSet = Set<String>()
    var parsedDict:[String:Any] = [:]

    init(withDict: [String: Any]) {
        for (_, value) in withDict {
            let valueDict = value as? [String: Any]
            if let objectSummaryDict = valueDict?["object_summary"] as? [String: Any]{
                typeSet.insert((objectSummaryDict["type"] as? String ?? "") )
            }
        }
        var catArray:[Any] = []
        for element in typeSet {
            for (key, value) in withDict {
                var valueDict = value as? [String: Any]
                if let objectSummaryDict = valueDict?["object_summary"] as? [String: Any]{
                 let object = objectSummaryDict["type"] as? String
                    if (element == object){
                        valueDict?["name"] = key
                        catArray.append(valueDict!)
                    }
                }
            }
            if catArray.count != 0 {
                parsedDict[element] = catArray
                catArray.removeAll()

            }
        }
        print(parsedDict)
    }
}

