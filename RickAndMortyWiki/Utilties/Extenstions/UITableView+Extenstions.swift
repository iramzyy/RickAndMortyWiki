//
//  UITableView+Extenstions.swift
//  RickAndMortyWiki
//
//  Created by Ahmed Ramzy on 28/09/2024.
//

import UIKit

extension UITableView {
    func isLastCell(at indexPath: IndexPath) -> Bool {
        let lastSectionIndex = numberOfSections - 1
        let lastRowIndex = numberOfRows(inSection: lastSectionIndex) - 1
        return indexPath.section == lastSectionIndex && indexPath.row == lastRowIndex
    }

    func showLoadingFooter(at indexPath: IndexPath) {
        if isLastCell(at: indexPath) {
            self.showLoadingFooter()
        }
    }
    func showLoadingFooter() {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.startAnimating()
        spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: self.bounds.width, height: CGFloat(44))

        self.tableFooterView = spinner
        self.tableFooterView?.isHidden = false
    }
}
