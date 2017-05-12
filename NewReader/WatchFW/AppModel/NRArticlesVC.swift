//
//  NRArticlesVC.swift
//  NewReader
//
//  Created by Abhishek Thapliyal on 1/24/17.
//  Copyright © 2017 Abhishek Thapliyal. All rights reserved.
//

/************************************************************************************************************
 NRArticlesVC : THIS CLASS IS FOR ARTICLES COLLECTION VIEW.
 ************************************************************************************************************/

import UIKit
import SDWebImage

class NRArticlesVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    let reusableCellIdentifier = "NRArticleCollectionViewCell" as String
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
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

        self.fetchArticles()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    //====================================================================================================================================
    // COLLECTION VIEW DELEGATES
    //====================================================================================================================================
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let articleDetailVC : NRArticleDetailVC = storyBoard.instantiateViewController(withIdentifier: "NRArticleDetailVC") as! NRArticleDetailVC
        articleDetailVC.article = self.collectionArray?.object(at: indexPath.row) as? NRArticle
        self.present(articleDetailVC, animated: true, completion: nil)
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        print("ARTICLE_COUNT : \(self.collectionArray?.count)")
        return (self.collectionArray?.count)!
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let articleViewCell : NRArticleCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: self.reusableCellIdentifier,
                                                                                               for: indexPath) as! NRArticleCollectionViewCell
        
        articleViewCell.backgroundColor = UIColor.white
        if (indexPath.row % 2 != 0) {
            articleViewCell.backgroundColor = UIColor(red:225.0/255, green:225.0/255, blue:250.0/255, alpha:0.4)
        }
        
        let article = self.collectionArray?.object(at: indexPath.row) as! NRArticle
        let imageURL = NSURL(string : article.urlToImage as! String)
        articleViewCell.articleImageView.sd_setImage(with: imageURL as URL!)
        articleViewCell.titleLabel.text = article.title as String?
        articleViewCell.authorLabel.text = article.author as String?
        
//        print("ARTICLE_TITLE : \(article.title!)")
        
        return articleViewCell
    }
    
    //====================================================================================================================================
    // FETCH ARTICLES FROM SERVER
    //====================================================================================================================================
 
    func fetchArticles() {
        
        self.loader.startAnimating()
        let networkManager = NRNetworkManager()
        networkManager.getNewsArticle(sortType: "", completion: { (articleArray, error) in
            
            OperationQueue.main.addOperation {
                self.collectionArray = NSMutableArray(array: articleArray)
                self.collectionView.reloadData()
                self.loader.stopAnimating()
            }
        })
    }
}
