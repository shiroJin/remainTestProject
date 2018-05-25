//
//  RxViewController.swift
//  TestProject
//
//  Created by quanbinjin on 2018/5/18.
//  Copyright © 2018年 remain. All rights reserved.
//

import UIKit
import RxSwift

class RxViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    static func trigger() {
        let button = PublishSubject<Void>()
        let textfield = PublishSubject<String>()
        
        let observer = button.withLatestFrom(textfield)
        let _ = observer.subscribe {
            print($0)
        }
        
        textfield.onNext("see you")
        textfield.onNext("hello rx")
        button.onNext(())
        button.onNext(())
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
