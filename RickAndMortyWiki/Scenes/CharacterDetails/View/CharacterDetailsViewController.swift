//
//  CharacterDetailsViewController.swift
//  RickAndMortyWiki
//
//  Created by Ahmed Ramzy on 28/09/2024.
//

import UIKit
import Combine
import SwiftUI

class CharacterDetailsViewController: UIViewController {
    var viewModel: CharacterDetailsViewModel
    var activityIndicator = UIActivityIndicatorView(style: .large)
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Init
    init(viewModel: CharacterDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar() 
        setupActivityIndicator()
        setupBindings()
        viewModel.loadData()
        
    }
    private func setupNavigationBar() {
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.tintColor = .black
    }
        
    private func setupActivityIndicator() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setupBindings() {
        viewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                if isLoading {
                    self?.activityIndicator.startAnimating()
                } else {
                    self?.activityIndicator.stopAnimating()
                }
            }
            .store(in: &cancellables)
        
        viewModel.$character
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.setupUI()
            }
            .store(in: &cancellables)
    }
    
    private func setupUI() {
        let swiftuiView = CharacterDetailsSwiftUI(viewModel: viewModel)
        addSubSwiftUIView(swiftuiView, to: view, backgroundColor: .white)
    }
}
