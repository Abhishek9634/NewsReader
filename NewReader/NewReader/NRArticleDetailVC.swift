//
//  NRArticleDetailVC.swift
//  NewReader
//
//  Created by Abhishek Thapliyal on 1/25/17.
//  Copyright © 2017 Abhishek Thapliyal. All rights reserved.
//

/************************************************************************************************************
 NRArticleDetailVC : THIS VIEW CONTROLLER CLASS 
                     IS FOR ARTICLE DETAIL WHEN USER TAP ON ARTICLE CELL
************************************************************************************************************/

import UIKit
import SDWebImage

class NRArticleDetailVC: UIViewController {

    @IBOutlet weak var articleImageView: UIImageView?
    @IBOutlet weak var authorLabel: UILabel?
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var descritionTextView: UITextView?
    @IBOutlet weak var publishedLabel: UILabel?
    @IBOutlet weak var backButton: UIButton?
    
    var article : NRArticle? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    /**************************************
     UPDATING SUBVIEW OF CURRENT VIEW
     **************************************/
        
        let imageURL = NSURL(string : self.article?.urlToImage as! String)
        self.articleImageView?.sd_setImage(with: imageURL as URL!)
        self.authorLabel?.text = self.article?.author as String?
        self.titleLabel?.text = self.article?.title as String?
        self.descritionTextView?.text = self.article?.newsdescription as String?
        self.publishedLabel?.text = self.article?.publishedAt as String?
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /************************************************************************************************************
     BACK BUTTON ACTION
     ************************************************************************************************************/
    
    @IBAction func backButtonAction(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
}
