//
//  FactsViewModel.swift
//  CodingTest_Infosys
//
//  Created by Niranjan on 03/07/20.
//  Copyright © 2020 Niranjan. All rights reserved.
//
final class FactsViewModel: NSObject {
   private let service = RequestService()
   internal var reloadList = { () -> Void in }
   internal var showError = { (error: String) -> Void in }
   var feedData: FeedsModel?

// MARK: Service Call to get data from URL
    func loadData() {
        // Checking internet availability
     if Reach().isNetworkReachable() == true {
        // Calling webservice to get data
       service.loadData { jsonArray in
                 switch jsonArray {
                 case .success(let response):
                    self.feedData = response
                    self.reloadList()
                 case .failure(let response):
                    self.showError(AppConstants.dataError + response.localizedDescription)
               }
       }
     }
     else { self.showError(AppConstants.internetError) }
       }
   }

// MARK: UITableViewDelegate Methods

   extension FactsViewModel: UITableViewDelegate {
       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
                     return UITableView.automaticDimension
           }
   }
// MARK: UITableViewDataSource Methods

   extension FactsViewModel: UITableViewDataSource {
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return feedData?.rows?.count ?? 0
           }
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AppConstants.cellidentifier, for: indexPath) as? DataCell else {
            return UITableViewCell()
        }
        cell.setData = feedData?.rows?[indexPath.row]
        return cell
    }
   }
