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
    @IBOutlet weak var topView: UIView!                     // 1st UIVIEW WITH TITLE SOURCE
    @IBOutlet weak var segmentBaseView: UIView!             // 2nd UIVIEW : USING FOR SEGMENT
    
    var segmentedControl : HMSegmentedControl?
    
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    let reusableCellIdentifier = "NRSourceCollectionViewCell" as String
    
    var mainSourceArray : NSMutableArray?
    var collectionArray : NSMutableArray?
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.collectionArray = NSMutableArray()
        self.fetchSources()
        self.intializeSegmentView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        for familyName:String in UIFont.familyNames {
            print("Family Name: \(familyName)")
            for fontName:String in UIFont.fontNames(forFamilyName: familyName) {
                print("--Font Name: \(fontName)")
            }
        }
    }
    
    //====================================================================================================================================
    // SEGMENT VIEW ACTION
    //====================================================================================================================================
    
    func intializeSegmentView() {
    
        let topFrame : CGRect = self.segmentBaseView.frame
        let topViewSize : CGSize = topFrame.size
        
        self.segmentedControl = HMSegmentedControl(frame: CGRect(x: topFrame.origin.x,
                                                                 y: 0,
                                                                 width: topViewSize.width,
                                                                 height: topViewSize.height))
        
        self.segmentedControl?.sectionTitles = ["General",
                                                "Technology",
                                                "Sport",
                                                "Business",
                                                "Entertainment",
                                                "Gaming",
                                                "Music",
                                                "Science"]
        
        self.segmentedControl?.selectedSegmentIndex = 1
        self.segmentedControl?.backgroundColor = UIColor(red:0.7, green:0.7, blue:0.7, alpha:1.0)
        self.segmentedControl?.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.segmentedControl?.selectedTitleTextAttributes = [NSForegroundColorAttributeName: UIColor(red:1.0, green:1.0, blue:1.0, alpha:1.0)]
        self.segmentedControl?.selectionIndicatorColor = UIColor(red:0.3, green:0.3, blue:0.3, alpha:1.0)
        self.segmentedControl?.selectionStyle = HMSegmentedControlSelectionStyle.box
        self.segmentedControl?.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocation.down
        self.segmentedControl?.titleTextAttributes = [NSFontAttributeName : UIFont(name: "SanFranciscoDisplay-Regular", size: 18) as Any]
        
        self.segmentBaseView.addSubview(segmentedControl!)
        
        self.segmentedControl?.indexChangeBlock = {(_ index: Int) -> Void in
            self.segmentedControlChangedValue(index: index)
        }
    }
    
    func segmentedControlChangedValue(index: Int) {
        
        let category = self.segmentedControl?.sectionTitles[index] as! NSString
        var arrayForIndex : [Any]?
        let predicate = NSPredicate(format: "SELF.category contains[cd] %@", category)
        arrayForIndex = self.mainSourceArray?.filtered(using: predicate)
//        print("CATEGORY : \(category) && ARRAY :: \(arrayForIndex!)")
        
//        if ((self.collectionArray?.count)! > 0){
            self.collectionArray = NSMutableArray(array: arrayForIndex!)
            self.collectionView.reloadData()
//        }
         self.loader.stopAnimating()
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
        
//        print("SOURCE_LARGE : \(source.large!)")
//        print("SOURCE_CATEGORY : \(source.category!)")
        
        return sourceViewCell
    }
    
    //====================================================================================================================================
    // FETCH SOURCES FROM SERVER
    //====================================================================================================================================
    
    func fetchSources() {
        
        self.loader.startAnimating()
        let networkManager = NRNetworkManager()
        networkManager.getNewsSource(completion: { (sourceArray, error) in
            
            OperationQueue.main.addOperation {
                self.mainSourceArray = NSMutableArray(array: sourceArray)
                self.segmentedControlChangedValue(index: 1)
            }
        })
    }

}
