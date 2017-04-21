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

    /// 装载整个列表的数组
    fileprivate lazy var totalData : [[String : Any]] = [[String : Any]]()
    /// 当前被选中的数组
    fileprivate lazy var selectedArr : [[String : Any]] = [[String : Any]]()
    /// 省份
    fileprivate lazy var provinceArr : [String] = [String]()
    /// 城市或者区
    fileprivate lazy var cityArr : [String] = [String]()
    /// 区县
    fileprivate lazy var areaArr : [String] = [String]()
    
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
        if component == 0 {
            return provinceArr.count
        }else if component == 1 {
            return cityArr.count
        }else {
            return areaArr.count
        }
    }
    
}

extension CityPickerView : UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return provinceArr[row]
        }else if component == 1 {
            return cityArr[row]
        }else {
            if areaArr.count > 0 {
                return areaArr[row]
            }else {
                return nil
            }
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        if component == 0 {
            refreshCityData(index: row)
            pickerView.reloadComponent(1)
            pickerView.reloadComponent(2)
            pickerView.selectRow(0, inComponent: 1, animated: true)
            pickerView.selectRow(0, inComponent: 2, animated: true)
        }else if component == 1 {
            refreshAreaData(index: row)
            pickerView.reloadComponent(2)
            pickerView.selectRow(0, inComponent: 2, animated: true)
        }
        
        settleAllName()
    }
}

// MARK: method
extension CityPickerView {

    
    /// 取出数据
    fileprivate func loadCityData() {

        guard let url = Bundle.main.url(forResource: "all_area", withExtension: "json") else { return }
        guard let data = try? Data(contentsOf: url) else { return }
        guard let total = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [[String : Any]] else { return }
        
        totalData += total
        
        // 取出所有省份
        for(_, value) in totalData.enumerated() {
            guard let name = value[KCityPickerName] as? String else { return }
            self.provinceArr.append(name)
        }
        
        // 取出第一个省市 布局ui
        refreshCityData(index: 0)
        
    }

    /// 根据传过来的省份index 来取出这个省份下的所有city
    ///
    /// - Parameter index: 对应省份的下表
    fileprivate func refreshCityData(index : Int) {
        
        // 取出city数组
        guard let indexCityArr = totalData[index][kCityPickerSubArea] as? [[String : Any]] else { return }
        
        // 删除老数据
        cityArr.removeAll()
        
        // 遍历数组,取出下面的city
        for (_, value) in indexCityArr.enumerated() {
            guard let name = value[KCityPickerName] as? String else { return }
            self.cityArr.append(name)
        }
        
        // 更新选中数组的内容
        selectedArr.removeAll()
        selectedArr += indexCityArr
        
        // 去刷新city下第一区县的数据
        refreshAreaData(index: 0)
    }
    
    
    /// 根据city对应的index, 取出city下面的所有的区县 或者 没有
    ///
    /// - Parameter index: 对应city下标
    fileprivate func refreshAreaData(index : Int) {
        guard let indexArea = selectedArr[index][kCityPickerSubArea] as? [[String : Any]] else { return }
        areaArr.removeAll()
        for (_, value) in indexArea.enumerated() {
            guard let name = value[KCityPickerName] as? String else { return }
            self.areaArr.append(name)
        }
    }
    
    fileprivate func settleAllName() {
        let index1 = selectedRow(inComponent: 0)
        let index2 = selectedRow(inComponent: 1)
        let index3 = selectedRow(inComponent: 2)
        
        let province = provinceArr[index1]
        let city = cityArr[index2]
        var area = ""
        
        if areaArr.count > 0 {
            area = areaArr[index3]
        }

        selfDelegate?.cityPickerViewDidSelect(cityString: province + " " + city + " " + area)
        
    }
}


