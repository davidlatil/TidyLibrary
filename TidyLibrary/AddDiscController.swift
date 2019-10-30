//
//  AddDiscController.swift
//  TidyLibrary
//
//  Created by David Latil on 29/10/2019.
//  Copyright © 2019 David Latil. All rights reserved.
//

import Foundation
import UIKit

class AddDiscController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    
    var pickerData: [String] = [String]()
    
    
    @IBOutlet weak var genrePicker: UIPickerView!
    
    @IBOutlet weak var artistTextField: UITextField!
    @IBOutlet weak var albumTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        genrePicker.dataSource = self
        genrePicker.delegate = self
        pickerData = ["Classique", "Jazz Vocal", "Jazz", "Chanson française", "Rock", "Rap"]
        genrePicker.selectRow(2, inComponent: 0, animated: true)
        self.albumTextField.delegate = self
        self.artistTextField.delegate = self
    }
    
    func pickerView(_ genrePicker: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ genrePicker: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    @IBAction func dismissKeyboard(_ sender: Any) {
        view.endEditing(true)
        print("test")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBSegueAction func scanner(_ coder: NSCoder) -> ScannerController? {
        return ScannerController(coder: coder)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is ScannerController
        {
            let vc = segue.destination as? ScannerController
            vc?.purpose=1
            vc?.passedAlbum=albumTextField.text!
            vc?.passedArtist=artistTextField.text!
            vc?.passedGenre=pickerData[genrePicker.selectedRow(inComponent: 0)]
        }
    }
}

