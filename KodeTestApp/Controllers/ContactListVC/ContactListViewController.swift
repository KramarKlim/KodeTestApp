//
//  ContactListViewController.swift
//  KodeTestApp
//
//  Created by Клим on 27.10.2021.
//

import UIKit

class ContactListViewController: UIViewController {
    
    var model: ContactListModelProtocol! = ContactListModel()
    
    let refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        return refreshControl
    }()
        
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var sortContactsCollectionView: UICollectionView!
    @IBOutlet var ContactTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        request()
    }
    
    @objc private func refresh(sender: UIRefreshControl) {
        ContactTableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    private func setup() {
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        searchBar.showsBookmarkButton = true
        searchBar.setImage(UIImage(systemName: "list.bullet.indent"), for: .bookmark, state: .normal)
        searchBar.delegate = self
        searchBar.sizeToFit()
        UIBarButtonItem.appearance(whenContainedInInstancesOf:[UISearchBar.self]).tintColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        searchBar.setValue("Отмена", forKey: "cancelButtonText")
        
        sortContactsCollectionView.register(UINib(nibName: "SortedListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "sort")
        sortContactsCollectionView.dataSource = self
        sortContactsCollectionView.delegate = self

        ContactTableView.delegate = self
        ContactTableView.dataSource = self
        ContactTableView.register(UINib(nibName: "ContactTableViewCell", bundle: nil), forCellReuseIdentifier: "contact")
        ContactTableView.refreshControl = refreshControl
    }
    
    private func request() {
        model.fetchRequest { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.ContactTableView.reloadData()
            }
        }
    }
}

extension ContactListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        model.numberOfCells()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.deselectItem(at: indexPath, animated: true)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sort", for: indexPath) as! SortedListCollectionViewCell
        let name = model.sortedList(indexPath: indexPath)
        cell.model = name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.model.lastActiveIndex != indexPath {
            
            let cell = collectionView.cellForItem(at: indexPath) as! SortedListCollectionViewCell
            cell.nameLabel.textColor = .black
            cell.colorView.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
            
            let cell1 = collectionView.cellForItem(at: model.lastActiveIndex) as! SortedListCollectionViewCell
            cell1.nameLabel.textColor = .lightGray
            cell1.colorView.backgroundColor = .white
            self.model.lastActiveIndex = indexPath
        }
    }
}

extension ContactListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        model.didChanged(text: searchText)
        ContactTableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        model.isSearching = false
        searchBar.showsCancelButton = false
        ContactTableView.reloadData()
        searchBar.showsBookmarkButton = true
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.endEditing(true)
    }
}

extension ContactListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model.getNumberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.dequeueReusableCell(withIdentifier: "contact", for: indexPath) as! ContactTableViewCell
        let contact = model.contactModel(indexPath: indexPath)
        cell.model = contact
        return cell
    }
}
