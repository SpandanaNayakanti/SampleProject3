//
//  ViewController.swift
//  InfyProject
//
//  Created by Spandana Nayakanti on 12/11/18.
//  Copyright © 2018 Spandana. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    var dataModel:DataModel?
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "List"
        // Do any additional setup after loading the view, typically from a nib.
        parseJson()
    }
    
    /**! Method to parse the json data into the dict and then store in Model objects
      */
    func parseJson() {
        
        if let path = Bundle.main.path(forResource: "data", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                if let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String:Any] {
                    //print("jsonData:\(jsonResult)")
                    dataModel = DataModel(withDict: jsonResult)
                    if self.dataModel?.parsedDict.count != 0 {
                        tableView.reloadData()
                    }
                }else {
                    print("no dict")
                }
                
            } catch let error {
                print("parse error: \(error.localizedDescription)")
            }
        } else {
            print("Invalid filename/path.")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: TableView Delegate Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataModel?.parsedDict.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.frame =  CGRect(x: 0 , y: 0, width: tableView.frame.size.width, height: 44);
        let titleLbl = UILabel(frame : CGRect(x: 32 , y: 0, width: headerView.frame.size.width - 64, height: headerView.frame.size.height))
        titleLbl.font = UIFont(name: "Helevetica", size: 25)
        titleLbl.textColor = UIColor.black
        let keys = self.dataModel?.parsedDict.map({ $0.key })
        titleLbl.text = keys![section]
        headerView.addSubview(titleLbl)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let keys = self.dataModel?.parsedDict.map({ $0.key })
        if let valueArray = self.dataModel?.parsedDict[keys![section]] as? [[String:Any]] {
            return valueArray.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell
        if cell == nil {
            let nib = Bundle.main.loadNibNamed("TableViewCell", owner: self, options: nil)
            cell = nib?.first as? TableViewCell
        }
        let keys = self.dataModel?.parsedDict.map({ $0.key })
        if let valueArray = self.dataModel?.parsedDict[keys![indexPath.section]] as? [[String:Any]] {
            let infoDict = valueArray[indexPath.row]
            if let name = infoDict["name"] as? String {
                cell?.name.text = String(format: "%@", name)
            }else{
                cell?.name.text = ""
            }
            if let color = infoDict["color"] as? String {
                cell?.colour.text = String(format: "Color: %@", color)
            }else{
                cell?.colour.text = ""
            }
            if let doors = infoDict["doors"] as? String {
                cell?.doors.text = String(format: "Doors: %@", doors)
            }else{
                cell?.doors.text = ""
            }
            if let price = infoDict["price"] as? String {
                cell?.price.text = String(format: "Price: %@", price)
            }else{
                cell?.price.text = ""
            }
            if let milage = infoDict["milage"] as? String {
                cell?.milage.text = String(format: "Milage: %@", milage)
            }else{
                cell?.milage.text = ""
            }
            if let age = infoDict["age"] as? String {
                cell?.doors.text = String(format: "Age: %@", age)
            }
            if let age = infoDict["purchase_date"] as? String {
                cell?.doors.text = String(format: "Purchase Date: %@", age)
            }
            if infoDict["purchase_date"] == nil && infoDict["age"] == nil {
                cell?.doors.text = ""

            }
            if let imageDict = infoDict["image"]  as? [String:String] {
                cell?.imgView.imageFromURL(urlString: imageDict["url"] ?? "")
            }
        }
        cell?.selectionStyle = .none
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailViewController = storyboard.instantiateViewController(withIdentifier: "DetailVC") as! DetailViewController
        detailViewController.title = "Details"
        let keys = self.dataModel?.parsedDict.map({ $0.key })
        if let valueArray = self.dataModel?.parsedDict[keys![indexPath.section]] as? [[String:Any]] {
             detailViewController.detailDict = valueArray[indexPath.row]
        }
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}

extension UIImageView {
    public func imageFromURL(urlString: String) {
        
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicator.frame = CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        activityIndicator.startAnimating()
        if self.image == nil{
            self.addSubview(activityIndicator)
        }
        
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error ?? "No Error")
                DispatchQueue.main.async(execute: { () -> Void in
                    activityIndicator.removeFromSuperview()

                })
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                activityIndicator.removeFromSuperview()
                self.image = image
            })
            
        }).resume()
    }
}

