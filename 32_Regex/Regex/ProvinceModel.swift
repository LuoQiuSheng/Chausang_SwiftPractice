//
//  Province.swift
//  Regex
//
//  Created by Metalien on 2026/6/8.
//

import Foundation

// 城市模型：包含城市名称 + 别名列表
struct CityModel {
    let name: String          // 城市名（如"北京"）
    let aliases: [String]     // 别名列表（如["燕京", "京师", "帝都"]）
}

// 省份/直辖市模型：包含省份名 + 下属城市列表
struct ProvinceModel {
    let name: String          // 省份/直辖市名（如"北京市"）
    let cities: [CityModel]   // 该省份下的所有城市
}

// MARK: - 核心：自动获取数据（优先读本地，没有就解析HTML并保存）
func getCityData() -> [ProvinceModel] {
    // 1. 先尝试读取本地 Plist
    if let localData = readProvincesFromPlist() {
        print("✅ 从本地 Plist 读取数据")
        return localData
    }
    
    // 2. 本地没有 → 解析 HTML
    let htmlData = parseLocationHTML()
    print("✅ 从 HTML 解析数据")
    
    // 3. 解析后自动保存到 Plist
    if !htmlData.isEmpty {
        saveProvinces(provinces: htmlData)
        print("✅ 数据已保存到 Plist")
    }
    
    return htmlData
}

// MARK: - 解析 HTML（按 HTML 结构过滤：只保留 h2 + ul 格式）
func parseLocationHTML() -> [ProvinceModel] {
    guard let path = Bundle.main.path(forResource: "location", ofType: "html"),
          let html = try? String(contentsOfFile: path) else {
        print("找不到 location.html")
        return []
    }
    
    var provinces = [ProvinceModel]()
    
    // 只匹配 【省份标题 + 城市列表】 的结构
    // 只有 <h2> ... <ul> 城市列表 </ul> 才会被匹配
    let pattern = "<h2(.|\n)*?<ul>(.|\n)*?</ul>"
    guard let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive) else {
        return []
    }
    
    let fullRange = NSRange(location: 0, length: html.count)
    let matches = regex.matches(in: html, range: fullRange)
    
    for match in matches {
        let block = (html as NSString).substring(with: match.range)
        
        // 1. 提取省份名称
        guard let provinceName = extractProvinceName(from: block) else {
            continue
        }
        
        // 2. 提取城市 + 别名
        let cities = extractCities(from: block)
        
        // 3. 有城市才添加
        if !cities.isEmpty {
            provinces.append(ProvinceModel(name: provinceName, cities: cities))
        }
    }
    
    return provinces
}

// 提取省份名称
private func extractProvinceName(from block: String) -> String? {
    let pattern = "\">(.+?)</span><span"
    guard let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive),
          let match = regex.firstMatch(in: block, range: NSRange(location: 0, length: block.count))
    else {
        return nil
    }
    
    var name = (block as NSString).substring(with: match.range(at: 1))
    name = name.trimmingCharacters(in: .whitespacesAndNewlines)
    return name.isEmpty ? nil : name
}

// 提取所有城市 → 已修复：自动去掉所有 HTML 标签
private func extractCities(from block: String) -> [CityModel] {
    let pattern = "<li[^>]*>(.+?)：([^<]+)</li>"
    guard let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive) else {
        return []
    }
    
    var cities = [CityModel]()
    let range = NSRange(location: 0, length: block.count)
    regex.enumerateMatches(in: block, range: range) { match, _, _ in
        guard let match = match else { return }
        
        // 1. 取出原始内容（带 <a> 标签）
        let cityRaw = (block as NSString).substring(with: match.range(at: 1))
            .trimmingCharacters(in: .whitespacesAndNewlines)
        
        // 删掉所有 HTML 标签
        let cityName = cityRaw.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression)
        
        // 别名
        let aliasText = (block as NSString).substring(with: match.range(at: 2))
            .trimmingCharacters(in: .whitespacesAndNewlines)
        
        let aliases = aliasText.components(separatedBy: ["、", "，", ","])
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }
        
        cities.append(CityModel(name: cityName, aliases: aliases))
    }
    
    return cities
}


// MARK: - 保存数据到 Plist（修复：保存顺序）
func saveProvinces(provinces: [ProvinceModel]) {
    let paths = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)
    guard let path = paths.first else { return }
    let filePath = path.appending("/Province.plist")
    
    var rootDict: [String: Any] = [:]
    var provincesData: [String: [String: [String]]] = [:]
    var order: [String] = [] // 🔥 保存顺序
    
    for province in provinces {
        order.append(province.name)
        
        var cityDict: [String: [String]] = [:]
        for city in province.cities {
            cityDict[city.name] = city.aliases
        }
        provincesData[province.name] = cityDict
    }
    
    rootDict["order"] = order
    rootDict["provinces"] = provincesData
    
    (rootDict as NSDictionary).write(toFile: filePath, atomically: true)
}

// MARK: - 从 Plist 读取数据（修复：保持顺序）
func readProvincesFromPlist() -> [ProvinceModel]? {
    let paths = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)
    guard let path = paths.first else { return nil }
    let filePath = path.appending("/Province.plist")
    
    guard FileManager.default.fileExists(atPath: filePath) else {
        return nil
    }
    
    // 🔥 修复：用 NSArray 读取，保持顺序！
    guard let data = try? Data(contentsOf: URL(fileURLWithPath: filePath)),
          let plist = try? PropertyListSerialization.propertyList(from: data, format: nil),
          let rootDict = plist as? [String: Any] else {
        return nil
    }
    
    // 🔥 关键：读取时 按照 "order" 顺序恢复
    guard let order = rootDict["order"] as? [String],
          let provincesData = rootDict["provinces"] as? [String: [String: [String]]] else {
        return nil
    }
    
    var provinces = [ProvinceModel]()
    for provinceName in order {
        guard let cityData = provincesData[provinceName] else { continue }
        var cities = [CityModel]()
        for (cityName, aliases) in cityData {
            cities.append(CityModel(name: cityName, aliases: aliases))
        }
        provinces.append(ProvinceModel(name: provinceName, cities: cities))
    }
    
    return provinces
}


