//
//  CharactersDataSource.swift
//  RickAndMortyWiki
//
//  Created by Ahmed Ramzy on 28/09/2024.
//

import UIKit
import SwiftUI
import Core
import DesignKit

typealias PaginationCallback = ((Bool) -> Void)
typealias SelectCharacterCallBack = ((Int) -> Void)

class CharactersDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    private let cellReuseID = "CharacterCell"
    private var characters: [CharacterModel]
    private var paginationCallback: PaginationCallback?
    private var selectionCallBack: SelectCharacterCallBack?
    
    init(tableView: UITableView,
         characters: [CharacterModel],
         paginationCallback: PaginationCallback? = nil,
         selectionCallBack: SelectCharacterCallBack? = nil) {
        self.characters = characters
        self.paginationCallback = paginationCallback
        self.selectionCallBack = selectionCallBack

        super.init()

        tableView.register(BaseTableViewCell.self, forCellReuseIdentifier: cellReuseID)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let character = characters[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: cellReuseID,
            for: indexPath
        ) as? BaseTableViewCell else {
            return UITableViewCell()
        }
        cell.contentConfiguration = UIHostingConfiguration(content: {
            CharacterCardView(title: character.name,
                              type: character.species,
                              imageURL: character.image,
                              status: character.status.rawValue)
        })
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   willDisplay cell: UITableViewCell,
                   forRowAt indexPath: IndexPath) {
        if indexPath.row == characters.count - 5 {
            paginationCallback?(true)
        }
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        selectionCallBack?(indexPath.row)
    }
}
