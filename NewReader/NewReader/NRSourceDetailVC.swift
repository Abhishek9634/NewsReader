//
//  NRSourceDetailVC.swift
//  NewReader
//
//  Created by Abhishek Thapliyal on 1/25/17.
//  Copyright © 2017 Abhishek Thapliyal. All rights reserved.
//

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
        
        let imageURL = NSURL(string : self.source?.large as! String)
        self.sourceImageView?.sd_setImage(with: imageURL as URL!)
        self.categoryLabel?.text = self.source?.category as String?
        self.nameLabel?.text = self.source?.name as String?
        self.descritionTextView?.text = self.source?.sourceDescription as String?
    }
    
    @IBAction func redirectWeb(_ sender: Any) {
        let sourceURL = NSURL(string : self.source?.url as! String)
        UIApplication.shared.open(sourceURL as! URL)
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
