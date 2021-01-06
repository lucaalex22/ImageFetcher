//
//  ImagesListViewController.swift
//  AbiHome
//
//  Created by Alexandru Luca on 05/01/2021.
//

import UIKit

final class ImagesListViewController: ViewController {

    // MARK: - Private Properties

    private let viewModel: ImagesListViewModel

    private lazy var collectionViewLayout: UICollectionViewLayout = {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.2), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.2))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .flexible(50)
        group.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: nil, top: .fixed(10), trailing: nil, bottom: .fixed(10))

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 36, leading: 36, bottom: 36, trailing: 36)
        let layout = UICollectionViewCompositionalLayout(section: section)

        return layout
    }()

    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout).configured {
        $0.backgroundColor = .white
        $0.register(ImageCell.self)
        $0.delegate = self
        $0.prefetchDataSource = self
        $0.showsVerticalScrollIndicator = false
        $0.backgroundView = self.loadingIndicator
    }

    private lazy var dataSource: UICollectionViewDiffableDataSource<ImagesListViewModelImpl.Section, ImageCellViewModelImpl> = {
        UICollectionViewDiffableDataSource<ImagesListViewModelImpl.Section, ImageCellViewModelImpl>(collectionView: collectionView) { collectionView, indexPath, viewModel in
            guard let cell: ImageCell = collectionView.dequeueReusableCell(for: indexPath) else { return UICollectionViewCell() }
            cell.viewModel = viewModel
            return cell
        }
    }()

    private let loadingIndicator = UIActivityIndicatorView(style: .medium)

    // MARK: - Initializers

    init(with viewModel: ImagesListViewModel) {
        self.viewModel = viewModel
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Lifecycle

    override func setupView() {
        view.addSubviews([collectionView, loadingIndicator])
        collectionView.dataSource = dataSource
    }

    override func setupConstraints() {
        let constraints = NSLayoutConstraint.constraints(for: collectionView, filling: view)
        NSLayoutConstraint.activate(constraints)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.handleViewDidLoad()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        collectionView.collectionViewLayout.invalidateLayout()
        collectionView.layoutIfNeeded()
    }

}

extension ImagesListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.handleSelection(on: indexPath.item)
    }
}

extension ImagesListViewController: ImagesListViewUpdater {

    func showLoading(_ value: Bool) {
        value ? loadingIndicator.startAnimating() : loadingIndicator.stopAnimating()
    }

    func reloadData() {
        dataSource.apply(viewModel.dataSourceSnapshot, animatingDifferences: true)
    }

}

extension ImagesListViewController: UICollectionViewDataSourcePrefetching {

    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        let indexes: [Int] = indexPaths.map { $0.item }
        viewModel.handlePrefetch(for: indexes)
    }

}
