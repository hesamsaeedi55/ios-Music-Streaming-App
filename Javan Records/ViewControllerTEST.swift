//
//  ViewControllerTEST.swift
//  Javan Records
//
//  Created by Hesamoddin on 11/13/20.
//  Copyright © 2020 Hesamoddin. All rights reserved.
//

import UIKit

class ViewControllerTEST: ViewController {
    
    var nameOf:String = "any"
     weak var delegate: playlist!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(nameOf)
        update()

        // Do any additional setup after loading the view.
    }
    
    func update() {
        print(nameOf)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
