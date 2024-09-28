//
//  ViewController+SwiftUI.swift
//  RickAndMortyWiki
//
//  Created by Ahmed Ramzy on 28/09/2024.
//

import UIKit
import SwiftUI

public extension UIViewController {
    func addSubSwiftUIView<Content>(
        _ swiftUIView: Content,
        to view: UIView,
        isPresent: Bool? = nil,
        backgroundColor: UIColor? = .clear) where Content: View {
        let childView = UIHostingController(rootView: swiftUIView.environment(\.layoutDirection, .leftToRight))
        addChild(childView)
        if isPresent ?? false {
            childView.view.backgroundColor = .clear
            view.backgroundColor = .clear
        } else {
            childView.view.backgroundColor = backgroundColor
            view.backgroundColor = backgroundColor
        }
        childView.view.frame = view.bounds
        childView.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(childView.view)
        childView.didMove(toParent: self)
    }
}

