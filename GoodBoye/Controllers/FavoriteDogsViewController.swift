//
//  FavoriteDogsViewController.swift
//  GoodBoye
//
//  Created by Envoy on 4/6/17.
//  Copyright © 2017 mmn. All rights reserved.
//

import UIKit

class FavoriteDogsViewController: UIViewController {
    @IBOutlet fileprivate weak var collectionView: UICollectionView!
    fileprivate var favoriteDogs = [GBDog]()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        
        FavoriteService.shared.getFavoriteDogs().then { dogs in
            DispatchQueue.main.async {
                self.favoriteDogs.removeAll()
                self.favoriteDogs.append(contentsOf: dogs)
                
            }
        }.always {
            //hide loading
        }
     }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension FavoriteDogsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteDogs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = UICollectionViewCell()
        return UICollectionViewCell()
    }
}
