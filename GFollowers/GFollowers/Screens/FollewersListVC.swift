//
//  FollewersListVC.swift
//  GFollowers
//
//  Created by Alperen Selçuk on 10.12.2021.
//  Copyright © 2021 Alperen Selçuk. All rights reserved.
//

import UIKit

protocol FollowerListVCDelegate: class {
    func didRequestFollowers(for username: String)
}

class FollewersListVC: UIViewController {
    enum Section {
        case main
    }
    
    var userName: String!
    var followers: [Follower] = []
    var filteredFollowers: [Follower] = []
    var page: Int = 1
    var hasMoreFollowers: Bool = true
    var isSearhcing: Bool = false
    
    var collectionView: UICollectionView!
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
         
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureCollectionView()
        configureSearchController()
        getFollowers(userName: userName, page: page)
        configureDatasource()
    }
    
    //MARK: View lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    //MARK: Configuration
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
    }

    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: self.view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
    
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }

 
    func configureSearchController() {
        let searchController        = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate    = self
        searchController.searchBar.placeholder = "Search for a username"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController        = searchController
    }

    func getFollowers(userName: String, page: Int) {
        
        showLoadingView()
        
        NetworkManager.shared.getFollowers(for: userName, page: page) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingValue()
            
            switch result {
                case .success(let followers):

                    if followers.count < 100 { self.hasMoreFollowers = false}
                    self.followers.append(contentsOf: followers)
                    
                    if self.followers.isEmpty  {
                        let message = "This User doesnt have any followers. Go follow then "
                        DispatchQueue.main.async { self.showEmptyStateView(with: message, in: self.view) }
                        return
                    }
                    self.updateData(on: self.followers)
                
                case .failure(let error):
                    self.presentGFAlertOnMainThread(title: "Bad stuff happend", message: error.rawValue, buttonTitle: "OK")
                
            }
        }
    }
    
    func configureDatasource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            
            return cell
        })
    }
    
    func updateData(on followers: [Follower]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        
        DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }
    }
    
    @objc func addButtonTapped() {
        showLoadingView()
        NetworkManager.shared.getUserInfo(for: userName) {[weak self] result in
            guard let self = self else { return }
            self.dismissLoadingValue()
            
            switch result {
            case .success(let user):
                let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
                
                PersistenceManager.updateWith(favorite: favorite, actionType: .add) {[weak self] error in
                    guard let self = self else { return }
                    guard let error = error else {
                        self.presentGFAlertOnMainThread(title: "Success", message: "You have successfully favorited this user", buttonTitle: "Horrayy")
                        return
                    }
                    self.presentGFAlertOnMainThread(title: "something went wrong", message: error.rawValue, buttonTitle: "OK")
                }
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK")
                
            }
        }
    }
}




extension FollewersListVC: UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offSet          = scrollView.contentOffset.y
        let contentHeight   = scrollView.contentSize.height
        let height          = scrollView.frame.size.height
        

        if offSet > contentHeight - height {
            guard hasMoreFollowers else { return }
            page += 1
            getFollowers(userName: userName, page: page)
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray = isSearhcing ? filteredFollowers: followers
        let follower    = activeArray[indexPath.item]
        
        

        
        
        let destVC = UserInfoVC()
        destVC.userName = follower.login
        destVC.delegate = self
        let navController = UINavigationController(rootViewController: destVC)
        present(navController,animated: true)
    }
}

extension FollewersListVC: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else { return }
        isSearhcing = true
        filteredFollowers = followers.filter{ $0.login.lowercased().contains(filter.lowercased()) }
        updateData(on: filteredFollowers)
        
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearhcing = false
        
        updateData(on: followers)
    }
}

extension FollewersListVC: FollowerListVCDelegate {
    func didRequestFollowers(for username: String) {
        self.userName = username
        title = username
        page = 1
        followers.removeAll()
        filteredFollowers.removeAll()
        collectionView.setContentOffset(.zero, animated: true)
        getFollowers(userName: username, page: page)
    }
}
