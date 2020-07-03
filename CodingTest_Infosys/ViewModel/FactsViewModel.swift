//
//  FactsViewModel.swift
//  CodingTest_Infosys
//
//  Created by Niranjan on 03/07/20.
//  Copyright © 2020 Niranjan. All rights reserved.
//
import UIKit
class FactsViewModel: NSObject {
    let service = RequestService()
    var reloadList = { () -> Void in }
    public var feedData: FeedsModel?
    func loadData() {
       service.loadData { jsonArray in
                 switch jsonArray {
                 case .success(let response):
                    self.feedData = response
                    self.reloadList()
                 case .failure:
                     print("FAILED")
                     self.reloadList()
               }
            }
    }
   }
   extension FactsViewModel: UITableViewDelegate {
       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
                     return UITableView.automaticDimension
           }
   }
   extension FactsViewModel: UITableViewDataSource {
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return feedData?.rows?.count ?? 0
           }
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DataCell", for: indexPath) as? DataCell else {
            return UITableViewCell()
        }
        cell.setData = feedData?.rows?[indexPath.row]
        return cell
           }
   }
