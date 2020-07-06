//
//  ViewController.swift
//  CodingTest_Infosys
//
//  Created by Niranjan on 03/07/20.
//  Copyright © 2020 Niranjan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

       private let viewModel = FactsViewModel()
       private let contactsTableView = UITableView()
       private var refreshControl = UIRefreshControl()
       private var activityView = UIActivityIndicatorView()

// MARK: ViewController Lifecycle
          override func viewDidLoad() {
             super.viewDidLoad()
            view.backgroundColor = .white
            setupView()
         }

// MARK: Setup View
    private func setupView() {
            initTableView()
            showActivityIndicator()
            reloadTableView()
            refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
            contactsTableView.addSubview(refreshControl)
            viewModel.loadData()
        }

// MARK: Pull To Refresh

       @objc func refreshData(_ sender: AnyObject) {
             viewModel.feedData = nil
             viewModel.loadData()
          }

// MARK: Initialising the tableview with Autolayouts

      private func initTableView() {
            view.addSubview(contactsTableView)
            contactsTableView.translatesAutoresizingMaskIntoConstraints = false
            contactsTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
            contactsTableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 0).isActive = true
            contactsTableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: 0).isActive = true
            contactsTableView.heightAnchor.constraint(equalToConstant: 0).isActive = true
            contactsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
            contactsTableView.widthAnchor.constraint(equalToConstant: 0).isActive = true
            contactsTableView.register(DataCell.self, forCellReuseIdentifier: AppConstants.cellidentifier)
            contactsTableView.delegate = viewModel
            contactsTableView.dataSource = viewModel
            contactsTableView.rowHeight = UITableView.automaticDimension
            contactsTableView.translatesAutoresizingMaskIntoConstraints = false
            contactsTableView.allowsSelection = false
           }
   private func showAlert(title: String, message: String, actionTitle: String) {
         let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
         alert.addAction(UIAlertAction(title: actionTitle, style: UIAlertAction.Style.default, handler: nil))
         self.present(alert, animated: true, completion: nil)
     }
    }

// MARK: Load Data

extension ViewController {
   private func reloadTableView() {
    /* Reload the data when the data has been changed */
         viewModel.reloadList = { [weak self] ()  in
                    DispatchQueue.main.async {
                     self?.hideActivityIndicator()
                     self?.refreshControl.endRefreshing()
                     self?.contactsTableView.reloadData()
                     self?.title = self?.viewModel.feedData?.title
                    }
    }
    // Handling the error
    viewModel.showError = { [weak self] error  in
                 DispatchQueue.main.async {
                  self?.hideActivityIndicator()
                  self?.refreshControl.endRefreshing()
                  self?.showAlert(title: "Error", message: error, actionTitle: "OK")
                 }
              }
            }
   }

// MARK: Show/Hide ActivityIndicator
extension ViewController {
    /* Show Progress Indicator */
   private func showActivityIndicator() {
        if #available(iOS 13.0, *) {
            activityView = UIActivityIndicatorView(style: .large)
        }
        else {
            activityView.style = .whiteLarge
        }
           activityView.center = view.center
           activityView.hidesWhenStopped = true
           activityView.startAnimating()
           contactsTableView.addSubview(activityView)
       }
/* Hide progress Indicator */
   private func hideActivityIndicator() {
            activityView.stopAnimating()
       }
}
