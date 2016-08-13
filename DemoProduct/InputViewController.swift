//
//  InputViewController.swift
//  DemoProduct
//
//  Created by YANGSHENG ZOU on 2016-08-12.
//  Copyright © 2016 YANGSHENG ZOU. All rights reserved.
//

import UIKit
import SwiftyJSON

protocol inputProcessDelegate {
    func processInputAfterClose()
    // what will be done after dismiss?
}
class InputViewController: UIViewController {
    
    
    
    
    @IBOutlet weak var commodityPickerView: UIPickerView! // picker for commodity
    
    @IBOutlet weak var regionsTableView: UITableView! // tableview for auto complete regions
    
    @IBOutlet weak var regionSearchBar: UISearchBar! // for location input
    
    var delegate:inputProcessDelegate?
    
    let regionsTableViewCellReuseIdentifier = "region" // reuse id for regions tableview
    
    let commodityUnitJSON = DataProcessor.sharedInstance().getDataFromCache(DataProcessor.sharedInstance().commodityUnitCacheKey) // get the commodityUnit data
    
    var timer = NSTimer() // timer for delaying tableview reload
    
    var selectedCommodityId: Int? // the id of selected commodity
    var selectedRegionId: Int? // the id of selected region
    
    var regionsTableViewDataSource : [SwiftyJSON.JSON] = []  // the textfield matching list
    
    override func viewDidLoad() {
        super.viewDidLoad()
        regionsTableView.registerClass(NSClassFromString("RegionsTableViewCell") , forCellReuseIdentifier: regionsTableViewCellReuseIdentifier)  // register custom cell
        
        selectedCommodityId = commodityUnitJSON![0]["id"].int! // the first one is picked without any action
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func personalizationDecided(sender: UIButton) {
        
        // okay button clicked
        dismissViewControllerAnimated(true, completion: {
            self.delegate?.processInputAfterClose()
        })
        
    }
    
    
    //-------------------- PickerView DataSource and delegate-----------------------------
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int{
        return 1
    }
    
    func pickerView(pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int) -> Int{
        
        // depends on the count of commodity units
        if (commodityUnitJSON != nil){
            return commodityUnitJSON!.count
        }
        return 0
    }
    func rowSize(forComponent component: Int) -> CGSize{
        
        // size of row
        return CGSize(width: commodityPickerView.bounds.width, height: commodityPickerView.bounds.height/4)
        
        
    }
    
    func pickerView(pickerView: UIPickerView,titleForRow row: Int, forComponent component: Int) -> String?{
        
        // title of row
        return commodityUnitJSON![row]["name"].string
        
    }
    
    func pickerView(pickerView: UIPickerView,didSelectRow row: Int, inComponent component: Int){
        
        // get the selected row of id
        selectedCommodityId = commodityUnitJSON![row]["id"].int
       
    }
    
    
    //----------------------------------end---------------------------------------------
    
    
    
    
    
    
    // ---------------------------- search response----------------------------------
    
    
   
    func searchBarSearchButtonClicked(searchBar: UISearchBar){
        searchBar.endEditing(true)
    }

    
    
    func searchBar(searchBar: UISearchBar,textDidChange searchText: String){
        // when text change, match the result
        timer.invalidate()  // stop last scheduled timer
        timer = NSTimer.scheduledTimerWithTimeInterval(0.4, target: self, selector: #selector(reloadTableView) , userInfo: searchText, repeats: false) // 400ms before reload
        
            }
    
    func reloadTableView (timer:NSTimer){
        regionsTableViewDataSource = DataProcessor.sharedInstance().getMatchingRegion(timer.userInfo as! String)
        regionsTableView.reloadData()
        regionsTableView.hidden = false

    }
    
    
    
    // ---------------------------------end----------------------------------------------
    
    
    
    
    
    
    
    
    
    
    //----------------------------- tableview datasource and delegate--------------------
    
    func tableView(tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int{
        return regionsTableViewDataSource.count
    }
    
    func tableView(tableView: UITableView,
                   cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        // cutomize row
        var regionsTableViewCell = tableView.dequeueReusableCellWithIdentifier(regionsTableViewCellReuseIdentifier) as? RegionsTableViewCell
        if regionsTableViewCell == nil {
            regionsTableViewCell = RegionsTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: regionsTableViewCellReuseIdentifier)
        }
        let row = regionsTableViewDataSource[indexPath.row];
        regionsTableViewCell?.textLabel?.numberOfLines = 2;
        regionsTableViewCell!.textLabel?.text = row["city_name"].string! + "\n" + row["province_name"].string!  // get the name of the selected region
        
        regionsTableViewCell!.id = row["city_id"].int! // get the id of selected region
        
        return regionsTableViewCell!
    }
    
    func tableView(tableView: UITableView,
                   didSelectRowAtIndexPath indexPath: NSIndexPath){
        tableView.hidden = true
        view.endEditing(true) // close the keyboard
        selectedRegionId =  regionsTableViewDataSource[indexPath.row]["city_id"].int! //get the region id
        regionSearchBar.text = regionsTableViewDataSource[indexPath.row]["city_name"].string!
        // refresh the text in search bar
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
