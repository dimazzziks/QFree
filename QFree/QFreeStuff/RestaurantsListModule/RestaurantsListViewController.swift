//
//  RestaurantsListViewController.swift
//  QFreeStuff
//
//  Created by Maxim V. Sidorov on 5/10/21.
//

import UIKit

protocol RestaurantsListViewInput: class {
  var restaurants: [Restaurant] { get set }
}

final class RestaurantsListViewController: UIViewController, RestaurantsListViewInput {

  var restaurants: [Restaurant] {
    didSet {
      collectionView.reloadData()
    }
  }

  private lazy var collectionView: UICollectionView = {
    let flowLayout = UICollectionViewFlowLayout()
    let collectionView = UICollectionView(
      frame: .zero,
      collectionViewLayout: flowLayout
    )
    collectionView.backgroundColor = .white
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.register(
      RestaurantCell.self,
      forCellWithReuseIdentifier: RestaurantCell.reuseId
    )
    return collectionView
  }()

  private let presenter: RestaurantsListOutput

  init(presenter: RestaurantsListOutput) {
    self.presenter = presenter
    self.restaurants = []
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .white
    setupCollectionView()
    presenter.loadRestaurants()
  }

  private func setupCollectionView() {
    view.addSubview(collectionView)
    NSLayoutConstraint.activate([
      collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      collectionView.topAnchor.constraint(equalTo: view.topAnchor),
      collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  }
}

extension RestaurantsListViewController: UICollectionViewDataSource {
  func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int {
    restaurants.count
  }

  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: RestaurantCell.reuseId,
      for: indexPath
    ) as! RestaurantCell
    let restaurant = restaurants[indexPath.row]
    cell.configure(with: restaurant)
    return cell
  }
}

extension RestaurantsListViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    CGSize(width: view.frame.width / 2 + 100, height: 300)
  }
}

extension RestaurantsListViewController: UICollectionViewDelegate {

}
