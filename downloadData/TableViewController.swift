//
//  TableViewController.swift
//  downloadData
//
//  Created by Apple Hsiao on 2016/11/25.
//  Copyright © 2016年 zeroplus. All rights reserved.
//

import UIKit
import SDWebImage

class TableViewController: UITableViewController {

    var array = [[String: AnyObject]]()
    
    func getData(){
        let url = URL(string: "https://itunes.apple.com/search?term=apple&media=software")
        let urlRequest = URLRequest(url: url!, cachePolicy:.returnCacheDataElseLoad,
                                    timeoutInterval: 30)
        let task = URLSession.shared.dataTask(with: urlRequest) {
            (data:Data?, response:URLResponse?, err:Error?) -> Void in
            guard err == nil else {
                return
            }
            if let data = data {

                do{
                    let dic = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String: AnyObject]

                        self.array = dic["results"] as! [[String: AnyObject]]
                        print(self.array.count)
                    
                    self.tableView.reloadData()
                    
                    //print(self.array[0].description)
    
                }
                catch{}
            }
        }
        task.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        getData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.array.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //與UI連結
        let cell = tableView.dequeueReusableCell(withIdentifier: "showAPPs", for: indexPath)
        let imageView = cell.contentView.viewWithTag(100) as! UIImageView
        let nameLabel = cell.contentView.viewWithTag(200) as! UILabel
        let priceLabel = cell.contentView.viewWithTag(300) as! UILabel
        let numLabel = cell.contentView.viewWithTag(400) as! UILabel
        
        // Configure the cell...
        //增加圖片邊框
        imageView.layer.cornerRadius = 8
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        
        //增加價格邊框
        priceLabel.layer.cornerRadius = 5
        priceLabel.layer.borderWidth = 1
        priceLabel.layer.borderColor = priceLabel.textColor.cgColor

        numLabel.text = String(indexPath.row + 1)
        //APP價格
        priceLabel.text = self.array[indexPath.row]["formattedPrice"] as! String?
        //APP名稱
        nameLabel.text = self.array[indexPath.row]["trackName"] as! String?
    
        //APP圖片
        let urlStr = self.array[indexPath.row]["artworkUrl100"] as! String?
        let url = URL(string: urlStr!)
        imageView.sd_setImage(with: url, placeholderImage: nil)

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
