//
//  DesignSystemConfigurator.swift
//  RickAndMortyWiki
//
//  Created by Ahmed Ramzy on 28/09/2024.
//

import Foundation
import DesignKit
import Core

struct DesignSystemConfigurator: AppDelegateConfigurable {
    static var shared: AppDelegateConfigurable = DesignSystemConfigurator()

    func setup() {
        DesignSystem.shared.setup()
    }
}
