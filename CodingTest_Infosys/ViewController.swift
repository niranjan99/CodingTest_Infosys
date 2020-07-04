//
//  ViewController.swift
//  CodingTest_Infosys
//
//  Created by Niranjan on 03/07/20.
//  Copyright © 2020 Niranjan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

        let viewModel = FactsViewModel()
        let contactsTableView = UITableView()
        var refreshControl = UIRefreshControl()
        var activityView = UIActivityIndicatorView()
          override func viewDidLoad() {
             super.viewDidLoad()
            view.backgroundColor = .white
            setupView()
         }

// MARK: Setup View
        func setupView() {
            initTableView()
            showActivityIndicator()
            viewModel.loadData()
            reloadTableView()
            refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
            contactsTableView.addSubview(refreshControl)
        }

// MARK: Pull To Refresh

       @objc func refreshData(_ sender: AnyObject) {
             viewModel.feedData = nil
             viewModel.loadData()
          }

// MARK: Initialising the tableview with Autolayouts

       func initTableView() {
            view.addSubview(contactsTableView)
    /* This code is giving a crash. could not able to find the issue at this time */
    //        contactsTableView.mas_makeConstraints { (make: MASConstraintMaker!) in
    //            make.left.mas_equalTo()(view.safeAreaLayoutGuide.leftAnchor)
    //            make.top.mas_equalTo()(view.topAnchor)
    //            make.right.mas_equalTo()(view.safeAreaLayoutGuide.rightAnchor)
    //            make.bottom.mas_equalTo()(view.safeAreaLayoutGuide.bottomAnchor)
    //            make.width.mas_equalTo()(0)
    //            make.height.mas_equalTo()(0)
    //        }
            contactsTableView.translatesAutoresizingMaskIntoConstraints = false
            contactsTableView.topAnchor.constraint(equalTo: view.topAnchor,
                                                   constant: 0).isActive = true
            contactsTableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor,
                                                    constant: 0).isActive = true
            contactsTableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor,
                                                     constant: 0).isActive = true
            contactsTableView.heightAnchor.constraint(equalToConstant: 0).isActive = true
            contactsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                                      constant: 0).isActive = true
            contactsTableView.widthAnchor.constraint(equalToConstant: 0).isActive = true
            contactsTableView.register(DataCell.self, forCellReuseIdentifier: AppConstants.cellidentifier)
            contactsTableView.delegate = viewModel
            contactsTableView.dataSource = viewModel
            contactsTableView.rowHeight = UITableView.automaticDimension
            contactsTableView.translatesAutoresizingMaskIntoConstraints = false
            contactsTableView.allowsSelection = false
           }
    func showAlert(title: String, message: String, actionTitle: String) {
         let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
         alert.addAction(UIAlertAction(title: actionTitle, style: UIAlertAction.Style.default, handler: nil))
         self.present(alert, animated: true, completion: nil)
     }
    }

// MARK: Load Data

extension ViewController {
    func reloadTableView() {
         viewModel.reloadList = { [weak self] ()  in
                    DispatchQueue.main.async {
                     self?.hideActivityIndicator()
                     self?.refreshControl.endRefreshing()
                     self?.contactsTableView.reloadData()
                     self?.title = self?.viewModel.feedData?.title
                    }
    }
    // Handling the error
    viewModel.showError = { [weak self] (error)  in
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
    func showActivityIndicator() {
           activityView = UIActivityIndicatorView(style: .large)
           activityView.center = view.center
           activityView.hidesWhenStopped = true
           activityView.startAnimating()
           contactsTableView.addSubview(activityView)
       }

    func hideActivityIndicator() {
            activityView.stopAnimating()
       }
}
