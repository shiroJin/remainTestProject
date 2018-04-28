//
//  SwiftViewController.swift
//  TestProject
//
//  Created by remain on 2018/4/27.
//  Copyright © 2018年 remain. All rights reserved.
//

import UIKit

class SwiftViewController: UIViewController, SDCycleScrollViewDelegate {

    private var cycleView: SDCycleScrollView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.darkGray
        
        let width = UIScreen.main.bounds.width
        cycleView = SDCycleScrollView(frame: CGRect(x: 0, y: 0, width:width , height: 200), delegate: self, placeholderImage: nil)
        view.addSubview(cycleView!)

        let images = ["http://cc.cocimg.com/api/uploads/180417/8821e2c1bfedd7367d4e79ec261f833a.png",
                      "http://cc.cocimg.com/api/uploads/180417/abb4e0df2034b8d26d5e1b9bf57b7eb3.png",
                      "http://cc.cocimg.com/api/uploads/180418/00ade475e9bfc14239ab989bc80dbf41.png",
                      "http://cc.cocimg.com/api/uploads/180419/ec713d121c36b934de1aaffa2c4ff025.png"]
        cycleView?.imageURLStringsGroup = images
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
