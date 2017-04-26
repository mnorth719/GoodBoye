//
//  FavoriteDogsViewController.swift
//  GoodBoye
//
//  Created by Envoy on 4/6/17.
//  Copyright © 2017 mmn. All rights reserved.
//

import UIKit

class FavoriteDogsViewController: UIViewController {
    fileprivate var favoriteDogs = [GBDog]()

    override func viewDidLoad() {
        super.viewDidLoad()
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

//extension FavoriteDogsViewController: UICollectionViewDataSource {
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return favoriteDogs.count
//    }
//}
