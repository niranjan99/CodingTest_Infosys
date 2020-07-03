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

        func setupView() {
            initTableView()
            showActivityIndicator()
            viewModel.loadData()
            reloadTableView()
            refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
            contactsTableView.addSubview(refreshControl)
        }
       @objc func refreshData(_ sender: AnyObject) {
             viewModel.feedData = nil
             viewModel.loadData()
          }
       func reloadTableView() {
              viewModel.reloadList = { [weak self] ()  in
                  DispatchQueue.main.async {
                   self?.hideActivityIndicator()
                   self?.refreshControl.endRefreshing()
                   self?.contactsTableView.reloadData()
                   self?.title = self?.viewModel.feedData?.title
                  }
              }
          }

       func initTableView() {
        view.addSubview(contactsTableView)
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
           contactsTableView.register(DataCell.self, forCellReuseIdentifier: "DataCell")
           contactsTableView.delegate = viewModel
           contactsTableView.dataSource = viewModel
           contactsTableView.rowHeight = UITableView.automaticDimension
           contactsTableView.translatesAutoresizingMaskIntoConstraints = false
           contactsTableView.allowsSelection = false
       }

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
