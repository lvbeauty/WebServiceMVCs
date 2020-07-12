//
//  MyCollectionViewController.swift
//  Service_Demo
//
//  Created by Tong Yi on 5/28/20.
//  Copyright © 2020 Tong Yi. All rights reserved.
//

import UIKit

class MyCollectionViewController: UICollectionViewController
{
    var dataSource: Service.SeviceModel = []
    private let reuseIdentifier = "Cell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupData()
        setupCollectionViewFlowLayout()
    }
    
    func setupData()
    {
        Service.loadDataSource {
            self.dataSource = Service.dataSource
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    func setupCollectionViewFlowLayout()
    {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 170, height: 260)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        collectionView.collectionViewLayout = layout
        collectionView.backgroundColor = .black
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return dataSource.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MyCollectionViewCell
        
        cell.titleLabel.text = dataSource[indexPath.item].title
        cell.titleLabel.textColor = .white
        cell.myImageView.contentMode = .scaleAspectFill
        cell.myImageView.image = UIImage(systemName: "book")
        
        // Configure the cell
        Service.loadImage(item: indexPath.item) { (image) in
            cell.myImageView.image = image
        }
        return cell
    }

}
