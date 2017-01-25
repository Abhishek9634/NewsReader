//
//  NRSourcesVC.swift
//  NewReader
//
//  Created by Abhishek Thapliyal on 1/24/17.
//  Copyright © 2017 Abhishek Thapliyal. All rights reserved.
//

import UIKit
import SDWebImage

class NRSourcesVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    let reusableCellIdentifier = "NRSourceCollectionViewCell" as String
    
    var collectionArray : NSMutableArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.collectionArray = NSMutableArray()
        
        self.fetchSources()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //====================================================================================================================================
    // SEGMENT VIEW ACTION
    //====================================================================================================================================
    
    @IBAction func segmentValueChanged(_ sender: Any) {
        
    }
    
    //====================================================================================================================================
    // COLLECTION VIEW DELEGATES
    //====================================================================================================================================
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let sourceDetailVC : NRSourceDetailVC = storyBoard.instantiateViewController(withIdentifier: "NRSourceDetailVC") as! NRSourceDetailVC
        sourceDetailVC.source = self.collectionArray?.object(at: indexPath.row) as? NRSource
        self.present(sourceDetailVC, animated: true, completion: nil)
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("SOURCE_COUNT : \(self.collectionArray?.count)")
        return (self.collectionArray?.count)!
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let sourceViewCell : NRSourceCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: self.reusableCellIdentifier,
                                                                                               for: indexPath) as! NRSourceCollectionViewCell
        
        sourceViewCell.backgroundColor = UIColor.white
        if (indexPath.row % 2 != 0) {
            sourceViewCell.backgroundColor = UIColor(red:180.0/255, green:100.0/255, blue:100.0/255, alpha:0.2)
        }
        
        let source = self.collectionArray?.object(at: indexPath.row) as! NRSource
        let imageURL = NSURL(string : source.large as! String)
        sourceViewCell.sourceImageView.sd_setImage(with: imageURL as URL!)
        sourceViewCell.nameLabel.text = source.name as String?
        sourceViewCell.descriptionLabel.text = source.sourceDescription as String?
        
        print("SOURCE_LARGE : \(source.large!)")
        
        return sourceViewCell
    }
    
    //====================================================================================================================================
    // FETCH SOURCES FROM SERVER
    //====================================================================================================================================
    
    func fetchSources() {
        
        let networkManager = NRNetworkManager()
        networkManager.getNewsSource(completion: { (sourceArray, error) in
            
            OperationQueue.main.addOperation {
                self.collectionArray = NSMutableArray(array: sourceArray)
                self.collectionView.reloadData()
            }
        })
    }

}
