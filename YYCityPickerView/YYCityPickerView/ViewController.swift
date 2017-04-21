//
//  ViewController.swift
//  YYCityPickerView
//
//  Created by Young on 2017/4/21.
//  Copyright © 2017年 YuYang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cityField: UITextField!
    @IBOutlet weak var cityPicker: CityPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        cityField.text = "北京市 东城区"
        cityPicker.selfDelegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController : CityPickerViewDelegate {
    func cityPickerViewDidSelect(cityString: String) {
        cityField.text = cityString
    }
}
