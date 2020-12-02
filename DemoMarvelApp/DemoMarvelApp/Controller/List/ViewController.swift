//
//  ViewController.swift
//  DemoMarvelApp
//
//  Created by Rahul Ranjan Kashyap on 02/12/20.
//  Copyright © 2020 Rahul Ranjan Kashyap. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var tableViewList: UITableView!
    var dicData:[String:String]?
    var listModelObj:ListModel?
    var objListModel:ListModel?
    var arrayMarvelList = [ListModel]()
    var arraySavedListId = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //load data in model and array
        if(arrayMarvelList.isEmpty)
        {
            for ind in 1...4
            {
                arrayMarvelList.insert(ListModel(imageid: ind, title: "IMAGE \(ind)", imageName: "image_\(ind)", desc: "Description image \(ind)"), at: arrayMarvelList.count)
            }
        }
        
        
        
        //load tableview list
        self.loadTableViewList()
    }
    
    func fetchSaveCoreData()
    {
        //core data fetch list
        
        CoreDataManager.fetchItemsData{ (result: [Int]) in
            
            self.arraySavedListId = result
        }
        print("My save data in databse \(arraySavedListId)")
        self.tableViewList.reloadData()
        
    }
    
    func loadTableViewList()
    {
        //load cell for table view
        self.tableViewList.register(UINib(nibName: "ListTVCell", bundle: nil), forCellReuseIdentifier: "ListTVCell")
        
        //Dynamic height of table view
        tableViewList.rowHeight = 130
        tableViewList.estimatedRowHeight = UITableView.automaticDimension
        
        //footer view
        tableViewList.tableFooterView = UIView()
        
        //core data fetch list
        self.fetchSaveCoreData()
    }
    
    
}
extension ViewController:UITableViewDelegate,UITableViewDataSource
{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayMarvelList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTVCell", for: indexPath) as! ListTVCell
        listModelObj = arrayMarvelList[indexPath.row]
        
        cell.buttonAddDelete.tag = indexPath.row
        cell.buttonAddDelete.addTarget(self, action: #selector(addRemoveItemMethod), for: .touchUpInside)
        
        
        cell.buttonAddDelete.setTitle(NSLocalizedString("MSG1", comment: ""), for: .normal)
        cell.labelName.text = listModelObj?.title
        cell.labelDesc.text = listModelObj?.desc
        cell.imageViewMarvel.image = UIImage(named: (listModelObj?.imageName)!)
        
        if(arraySavedListId.contains((listModelObj?.imageid)!))
        {
            cell.buttonAddDelete.setTitle(NSLocalizedString("MSG2", comment: ""), for: .normal)
            
        }
        else
        {
            cell.buttonAddDelete.setTitle(NSLocalizedString("MSG1", comment: ""), for: .normal)
            
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    //Method for Add in item list
    @objc func addRemoveItemMethod(sender:UIButton)
    {
        let objListModel = arrayMarvelList[sender.tag]
        
        if(arraySavedListId.contains((objListModel.imageid)!))
        {
            CoreDataManager.deleteItems(imageID:objListModel.imageid!)
        }
        else
        {
            CoreDataManager.addRecord(object: objListModel)
            
        }
        self.fetchSaveCoreData()
        
    }
    
}

