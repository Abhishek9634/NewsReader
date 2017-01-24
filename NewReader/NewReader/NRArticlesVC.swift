//
//  NRArticlesVC.swift
//  NewReader
//
//  Created by Abhishek Thapliyal on 1/24/17.
//  Copyright © 2017 Abhishek Thapliyal. All rights reserved.
//

import UIKit

class NRArticlesVC: UIViewController {

    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    @IBAction func segmentValueChanged(_ sender: Any) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
