//
//  DetailViewController.swift
//  InfyProject
//
//  Created by Spandana Nayakanti on 12/11/18.
//  Copyright © 2018 Spandana. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var colorLabel: UILabel!
    @IBOutlet var ageLabel: UILabel!
    @IBOutlet var descriptionTextView: UITextView!
    @IBOutlet var typeLbl: UILabel!
    @IBOutlet var ageTextLbl: UILabel!
    
    var detailDict:[String:Any]? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = detailDict!["name"] as? String
        if let objectSummary = detailDict!["object_summary"] as? [String:String] {
            descriptionTextView.text = objectSummary["description"]
            let font = UIFont.systemFont(ofSize: 17)
            let style = NSMutableParagraphStyle()
            style.lineSpacing = 10
            let attributes: [NSAttributedStringKey: Any] = [.font: font,.paragraphStyle: style]
            descriptionTextView.attributedText = NSAttributedString(string: descriptionTextView.text, attributes: attributes)
            colorLabel.text = objectSummary["color"]
            typeLbl.text = objectSummary["type"]
        }
        if let age = detailDict!["age"] {
            ageLabel.text = age as? String
        }else if let date = detailDict!["purchase_date"] {
            ageLabel.text = date as? String
            ageTextLbl.text = "Purchase Date:"
        }
        else if let date = detailDict!["price"] {
            ageLabel.text = date as? String
            ageTextLbl.text = "Price:"
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)

    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
