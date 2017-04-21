//
//  CityPickerView.swift
//  HuaChuMall
//
//  Created by Young on 2017/4/21.
//  Copyright © 2017年 YuYang. All rights reserved.
//

import UIKit

protocol CityPickerViewDelegate : class {
    func cityPickerViewDidSelect(cityString : String)
}

fileprivate let KCityPickerName = "name"
fileprivate let kCityPickerSubArea = "sub_area"

class CityPickerView: UIPickerView {

    /// 当前被选中的省
    fileprivate lazy var provinceIndex : Int = 0
    
    /// 当前被选中的市/区
    fileprivate lazy var cityIndex : Int = 0
    
    fileprivate lazy var areaIndex : Int = 0
    
    /// 当前被选中的区/县
    fileprivate lazy var provinceArr : [Province] = [Province]()

    weak var selfDelegate : CityPickerViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        //fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
        setupUI()
    }
    
    
    /// 初始化数据
    private func setupUI() {
        loadCityData()
        delegate = self
        dataSource = self
    }
}


extension CityPickerView : UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
 
        let selectedProvince = provinceArr[provinceIndex]
        let selectedCity = selectedProvince.sub_area[cityIndex]
        
        if component == 0 {
            return provinceArr.count
        }else if component == 1 {
            return selectedProvince.sub_area.count
        }else {
            return selectedCity.sub_area.count
        }
    }
    
}

extension CityPickerView : UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        if component == 0 {
            
            let selectedProvince = provinceArr[row]
            return selectedProvince.name
            
        }else if component == 1 {
            
            let selectedProvince = provinceArr[provinceIndex]
            let selectedCity = selectedProvince.sub_area[row]
            return selectedCity.name
            
        }else {
            
            let selectedProvince = provinceArr[provinceIndex]
            let selectedCity = selectedProvince.sub_area[cityIndex]
            
            if selectedCity.sub_area.count > 0 {
                let selectedArea = selectedCity.sub_area[row]
                return selectedArea.name
            }else {
                return nil
            }
            
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        if component == 0 {
            provinceIndex = row
            pickerView.reloadComponent(1)
            pickerView.reloadComponent(2)
            pickerView.selectRow(0, inComponent: 1, animated: true)
            pickerView.selectRow(0, inComponent: 2, animated: true)
        }else if component == 1 {
            cityIndex = row
            pickerView.reloadComponent(2)
            pickerView.selectRow(0, inComponent: 2, animated: true)
        }else {
            areaIndex = row
        }
        
        //settleAllName()
    }
}

// MARK: method
extension CityPickerView {

    /// 取出数据
    fileprivate func loadCityData() {
        
        guard let path = Bundle.main.path(forResource: "cityCode", ofType: "plist") else { return }
        guard let cityArr = NSArray(contentsOfFile: path) else { return }
        for dict in cityArr {
            guard let model = Province.deserialize(from: dict as? NSDictionary) else { continue }
            provinceArr.append(model)
        }

    }

}


