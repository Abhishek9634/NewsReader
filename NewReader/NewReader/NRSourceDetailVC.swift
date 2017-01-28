//
//  NRSourceDetailVC.swift
//  NewReader
//
//  Created by Abhishek Thapliyal on 1/25/17.
//  Copyright © 2017 Abhishek Thapliyal. All rights reserved.
//

/************************************************************************************************************
 NRSourceDetailVC : THIS VIEW CONTROLLER CLASS
 IS FOR SOURCE DETAIL WHEN USER TAP ON SOURCE CELL
 ************************************************************************************************************/

import UIKit

class NRSourceDetailVC: UIViewController {

    
    @IBOutlet weak var categoryLabel: UILabel?
    @IBOutlet weak var sourceImageView: UIImageView?
    @IBOutlet weak var nameLabel: UILabel?
    @IBOutlet weak var descritionTextView: UITextView?
    
    var source : NRSource?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    /**************************************
     UPDATING SUBVIEW OF CURRENT VIEW
     **************************************/
        
        let imageURL = NSURL(string : self.source?.large as! String)
        self.sourceImageView?.sd_setImage(with: imageURL as URL!)
        self.categoryLabel?.text = self.source?.category as String?
        self.nameLabel?.text = self.source?.name as String?
        self.descritionTextView?.text = self.source?.sourceDescription as String?
    }
    
    /************************************************************************************************************
     FULL STORY BUTTON ACTION : RE-DIRECT TO WEB BROWSER
     ************************************************************************************************************/
    
    @IBAction func redirectWeb(_ sender: Any) {
        let sourceURL = NSURL(string : self.source?.url as! String)
        UIApplication.shared.open(sourceURL as! URL)
    }
    
    /************************************************************************************************************
     BACK BUTTON ACTION
     ************************************************************************************************************/
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
