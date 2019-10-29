//
//  ResultPage.swift
//  TidyLibrary
//
//  Created by David Latil on 29/10/2019.
//  Copyright © 2019 David Latil. All rights reserved.
//

import Foundation
import UIKit
class ResultPageController:UIViewController {
    var code:String = ""
    @IBOutlet weak var testResult: UILabel!
    override func viewDidLoad() {
        print(code)
        testResult.text=code
    }
}
