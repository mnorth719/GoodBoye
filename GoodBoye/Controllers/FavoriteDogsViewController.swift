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
    @IBOutlet weak var blankStateLabel: UILabel!
    
    fileprivate var favoriteDogs = [GBDog]()
    
    enum Constants {
        static let dogHeroSegueId = "DogHeroSegue"
        static let cellSpacing: CGFloat = 2
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(
            UINib(nibName: FavoriteDogCollectionViewCell.Constants.nibName, bundle: nil),
            forCellWithReuseIdentifier: FavoriteDogCollectionViewCell.Constants.reuseId
        )
        
        collectionView.contentInset = UIEdgeInsets(top: 64, left: 0, bottom: 0, right: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        FavoriteService.shared.getFavoriteDogs().then { dogs in
            DispatchQueue.main.async {
                self.favoriteDogs.removeAll()
                self.favoriteDogs.append(contentsOf: dogs)
                self.collectionView.reloadData()
                self.blankStateLabel.isHidden = self.favoriteDogs.count > 0
            }
        }.always {
            //hide loading
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        print("deinit favorites vc")
    }
}

extension FavoriteDogsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "DogHeroViewController")
        
        if let controller = controller as? DogHeroViewController {
            controller.dog = favoriteDogs[indexPath.item]
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalScreenWidth = UIScreen.main.bounds.width
        let cellsPerRow = 3
        let totalSpacing = (CGFloat(cellsPerRow) + 1) * Constants.cellSpacing
        let usableSpace = totalScreenWidth - totalSpacing
        let cellWidth = usableSpace / 3.0
        let cellHeight = cellWidth * 1.25
        return CGSize(width: cellWidth, height: cellHeight)
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
        if let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: FavoriteDogCollectionViewCell.Constants.reuseId,
            for: indexPath) as? FavoriteDogCollectionViewCell {
            cell.setup(with: favoriteDogs[indexPath.item])
            
            return cell
        }
        
        return UICollectionViewCell()
    }
}
