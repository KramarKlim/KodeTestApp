//
//  ContactListViewController.swift
//  KodeTestApp
//
//  Created by Клим on 27.10.2021.
//

import UIKit
import SkeletonView

class ContactListViewController: UIViewController {
    
    var model: ContactListModelProtocol = ContactListModel()
        
    let refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addSubview(GrayCircleView(frame: CGRect(x: refreshControl.center.x+18, y: refreshControl.center.y, width: 20, height: 20)))

        refreshControl.addSubview(SpinnerView(frame: CGRect(x: refreshControl.center.x+18, y: refreshControl.center.y, width: 20, height: 20)))
        refreshControl.tintColor = .clear
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        return refreshControl
    }()
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var sortContactsCollectionView: UICollectionView!
    @IBOutlet var contactTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        request()
    }
    
    @objc private func refresh(sender: UIRefreshControl) {
        model.fetchRequest { [weak self] in
            guard let self = self else { return}
            DispatchQueue.main.async {
                if self.model.isError == false {
                    let window = UIApplication.shared.windows.last!
                    let viewToShow = ErrorView(frame: CGRect(x: 0, y: 0, width: window.frame.size.width, height: window.frame.size.height / 9))
                    viewToShow.backgroundColor = UIColor.red
                    window.addSubview(viewToShow)
                    let top = CGAffineTransform(translationX: 0, y: -300)
                    Timer.scheduledTimer(withTimeInterval: 4, repeats: false) { (_) in
                        UIWindow.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                              viewToShow.transform = top
                        }, completion: nil)
                    }
                } else {
                    self.model.sortContact()
                    self.contactTableView.reloadData()
                }
                self.refreshControl.endRefreshing()
            }
        }
    }
    
    private func setup() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        setupSearchBar()
        setupCollectionView()
        setupTableView()
    }
    
    private func setupSearchBar() {
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        searchBar.showsBookmarkButton = true
        searchBar.setImage(UIImage(named: "sort"), for: .bookmark, state: .normal)
        searchBar.delegate = self
        searchBar.sizeToFit()
        UIBarButtonItem.appearance(whenContainedInInstancesOf:[UISearchBar.self]).tintColor = UIColor.customPurple
        searchBar.setValue("Отмена", forKey: "cancelButtonText")
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.backgroundColor = UIColor(red: 247.0/255.0, green: 247.0/255.0, blue: 248.0/255.0, alpha: 1)
    }
    
    private func setupCollectionView() {
        sortContactsCollectionView.register(UINib(nibName: "SortedListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "sort")
        sortContactsCollectionView.dataSource = self
        sortContactsCollectionView.delegate = self
    }
    
    private func setupTableView() {
        contactTableView.delegate = self
        contactTableView.dataSource = self
        contactTableView.register(UINib(nibName: "ContactTableViewCell", bundle: nil), forCellReuseIdentifier: "contact")
        contactTableView.refreshControl = refreshControl
        contactTableView.isSkeletonable = true
        contactTableView.showSkeleton(usingColor: .lightGray, animated: true, delay: 0, transition: .crossDissolve(0.25))
    }
    
    private func request() {
        model.fetchRequest { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.contactTableView.reloadData()
                self.contactTableView.hideSkeleton()
                self.view.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
                if self.model.isError == false {
                    let error = ErrorViewController()
                    error.reload = self
                    self.navigationController?.pushViewController(error, animated: false)
                }
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
        if indexPath == model.lastActiveIndex {
            cell.colorView.backgroundColor = UIColor.customPurple
            cell.nameLabel.textColor = .black
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.model.lastActiveIndex != indexPath {
            
            let cell = collectionView.cellForItem(at: indexPath) as! SortedListCollectionViewCell
            cell.nameLabel.textColor = .black
            cell.colorView.backgroundColor = UIColor.customPurple
            
            let cell1 = collectionView.cellForItem(at: model.lastActiveIndex) as? SortedListCollectionViewCell
            cell1?.nameLabel.textColor = .lightGray
            cell1?.colorView.backgroundColor = .white
            self.model.lastActiveIndex = indexPath
        }
        model.sortByProf(indexPath: indexPath)
        model.sortContact()
        model.isFiltered = true
        contactTableView.reloadData()
    }
}

extension ContactListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        model.didChanged(text: searchText)
        if model.filtered.isEmpty && model.isSearching && model.sortType != .date {
            contactTableView.isHidden = true
        } else if model.isSearching && model.filtered.isEmpty && model.filteredSecond.isEmpty {
            contactTableView.isHidden = true
        } else {
            contactTableView.isHidden = false
        }
        contactTableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.showsBookmarkButton = true
        searchBar.text = nil
        searchBar.endEditing(true)
        contactTableView.isHidden = false
        model.isSearching = false
        contactTableView.reloadData()
    }
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        let filerVC = FilterTypeViewController()
        let filterModel = FilterTypeModel(contacts: model.sortType)
        filerVC.model = filterModel
        filerVC.typeDelegate = self
        present(filerVC, animated: true, completion: nil)
    }
}

extension ContactListViewController: SkeletonTableViewDelegate, SkeletonTableViewDataSource {
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        "contact"
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model.getNumberOfRows(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.dequeueReusableCell(withIdentifier: "contact", for: indexPath) as! ContactTableViewCell
        cell.selectionStyle = .none
        let contact = model.contactModel(indexPath: indexPath)
        cell.model = contact
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        contactTableView.deselectRow(at: indexPath, animated: true)
        let profileModel = model.profileModel(indexPath: indexPath)
        performSegue(withIdentifier: "profile", sender: profileModel)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 && model.sortType == .date {
        return FooterView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 && model.sortType == .date {
            return 50
        } else {
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        model.numberOfSections()
    }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailVC = segue.destination as! ProfileViewController
        detailVC.model = sender as? ProfileModelProtocol
        navigationItem.backButtonTitle = ""
    }
}

extension ContactListViewController: SelectSortType {
    func didSelectType(type: SortType) {
        model.sortType = type
        model.sortContact()
        searchBar.setImage(UIImage(named: "sorted"), for: .bookmark, state: .normal)
        contactTableView.reloadData()
    }
}

extension ContactListViewController: AgainRequest {
    func needToReload() {
        setupTableView()
        request()
    }
}
