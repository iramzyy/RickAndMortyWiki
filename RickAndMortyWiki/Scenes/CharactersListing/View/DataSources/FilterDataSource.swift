//
//  FilterDataSource.swift
//  RickAndMortyWiki
//
//  Created by Ahmed Ramzy on 28/09/2024.
//

import UIKit
import SwiftUI
import Core
import DesignKit
import CharactersDomain

typealias SelectFilterItemCallback = ((CharactersDomain.CharacterStatus?) -> Void)

class FiltersDataSource: NSObject,
                        UICollectionViewDelegate,
                            UICollectionViewDataSource,
                        UICollectionViewDelegateFlowLayout {
    private let cellReuseID = "FilterCell"

    private var collectionView: UICollectionView
    private var callback: SelectFilterItemCallback?
    private var filters: [CharactersDomain.CharacterStatus] = []
    private var selectedFilter: CharactersDomain.CharacterStatus?
    
    init(collectionView: UICollectionView,
         callback: SelectFilterItemCallback? = nil,
         filters: [CharactersDomain.CharacterStatus],
         selectedFilter: CharactersDomain.CharacterStatus? = nil) {
        self.collectionView = collectionView
        self.callback = callback
        self.filters = filters
        self.selectedFilter = selectedFilter

        super.init()

        collectionView.register(UICollectionViewCell.self,
                                forCellWithReuseIdentifier: cellReuseID)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
    }

    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let filters = filters.map { $0.rawValue }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseID, for: indexPath)
        cell.contentConfiguration = UIHostingConfiguration(content: {
            GridView(items: filters, selectedItem: Binding(get: {
                self.selectedFilter?.rawValue
            }, set: { selected in
                self.selectedFilter = CharacterStatus(rawValue: selected ?? "")
                self.callback?(self.selectedFilter)
            }))
        })
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width, height: 50)
    }
    
}
