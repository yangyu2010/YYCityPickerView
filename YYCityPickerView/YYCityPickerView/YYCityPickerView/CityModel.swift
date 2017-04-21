//
//  CityModel.swift
//  YYCityPickerView
//
//  Created by Young on 2017/4/21.
//  Copyright © 2017年 YuYang. All rights reserved.
//

import UIKit

class CityModel: NSObject {

}


class Province: NSObject {
    var code : String?
    var name : String?
    var sub_area : [City] = [City]()
    
//    init(dict : [String : Any]) {
//        super.init()
//        
//        setValuesForKeys(dict)
//        
//        if let sub_area = dict["sub_area"] as? [[String : Any]] {
//            for area in sub_area {
//                let model = City(dict: area)
//                self.sub_area.append(model)
//            }
//        }
//    }
//    
//    override func setValue(_ value: Any?, forUndefinedKey key: String) {
//    }
    
}

class City: NSObject {
    var code : String?
    var name : String?
    var sub_area : [Area] = [Area]()
    
//    init(dict : [String : Any]) {
//        super.init()
//        setValuesForKeys(dict)
//        
//        if let sub_area = dict["sub_area"] as? [[String : Any]] {
//            for area in sub_area {
//                let model = Area(dict: area)
//                self.sub_area.append(model)
//            }
//        }
//    }
//    
//    override func setValue(_ value: Any?, forUndefinedKey key: String) {
//    }
}

class Area: NSObject {
    
    var code : String?
    var name : String?
    
//    init(dict : [String : Any]) {
//        super.init()
//        setValuesForKeys(dict)
//    }
//    
//    override func setValue(_ value: Any?, forUndefinedKey key: String) {
//    }
}
