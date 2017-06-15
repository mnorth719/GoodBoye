//
//  FavoriteDogsViewModel.swift
//  GoodBoye
//
//  Created by Envoy on 6/15/17.
//  Copyright © 2017 mmn. All rights reserved.
//

import Foundation

class FavoriteDogsViewModel: NSObject {
    @objc dynamic var favoriteDogs = [GBDog]()
    
    func updateDogs() {
        FavoriteService.shared.getFavoriteDogs().then {[weak self] dogs -> Void in
            self?.favoriteDogs.removeAll()
            self?.favoriteDogs = [GBDog](dogs)
        }.always {/*  complete  */ }
    }
}
