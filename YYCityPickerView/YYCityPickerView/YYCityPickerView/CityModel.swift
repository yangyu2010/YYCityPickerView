//
//  CityModel.swift
//  YYCityPickerView
//
//  Created by Young on 2017/4/21.
//  Copyright © 2017年 YuYang. All rights reserved.
//

import UIKit
import HandyJSON

class CityModel: NSObject{

}


class Province: HandyJSON {
    var code : String?
    var name : String?
    var sub_area : [City] = [City]()
    
    required init() {}
}

class City : HandyJSON {
    var code : String?
    var name : String?
    var sub_area : [Area] = [Area]()
    
    required init() {}
}

class Area : HandyJSON {
    
    var code : String?
    var name : String?
    
    required init() {}
}
