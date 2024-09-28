//
//  CharactersListViewController.swift
//  RickAndMortyWiki
//
//  Created by Ahmed Ramzy on 28/09/2024.
//

import Combine
import Core
import DesignKit
import UIKit
import NVActivityIndicatorView

class CharactersListViewController: UIViewController {
    @IBOutlet var filtersCollectionView: UICollectionView!
    @IBOutlet var charactersTableView: UITableView!

    private var cancellables = Set<AnyCancellable>()

    var viewModel: CharactersListViewModel?
    var activityIndicator = UIActivityIndicatorView(style: .large)

    private var filtersDataSource: FiltersDataSource?
    private var charactersDataSource: CharactersDataSource?

    // MARK: - Init

    init(viewModel: CharactersListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        consoleLogger.error("init(coder:) has not been implemented")
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupActivityIndicator()
        viewModel?.loadData()
        setupLoadingObserver()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Characters Wiki"
    }
    
    private func setupActivityIndicator() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    private func setupLoadingObserver() {
        viewModel?.$isLoading.sink(receiveValue: { [weak self] isLoading in
            guard let self = self else { return }
            if isLoading {
                activityIndicator.startAnimating()
            } else {
                activityIndicator.stopAnimating()
                setupFiltersDataSource()
                setupCharactersDataSource()
            }
        }).store(in: &cancellables)
    }
}

extension CharactersListViewController {
    private func setupFiltersDataSource() {
        filtersDataSource = FiltersDataSource(collectionView: filtersCollectionView,
                                              callback: { [weak self] selectedFilter in
                                                  self?.viewModel?.selectedFilter = selectedFilter
                                              },
                                              filters: viewModel?.filters ?? [],
                                              selectedFilter: viewModel?.selectedFilter)
    }

    private func setupCharactersDataSource() {
        charactersDataSource = CharactersDataSource(tableView: charactersTableView,
                                                    characters: viewModel?.characters ?? [],
                                                    paginationCallback: { [weak self] isPaging in
                                                        if isPaging {
                                                            self?.viewModel?.loadMore()
                                                        }

                                                    }, selectionCallBack: { [weak self] selectedIndex in
                                                        self?.viewModel?.didSelectCharacter(index: selectedIndex)
                                                    })
    }
}
