//
//  CacheUtil.swift
//  BPSaveu
//
//  Created by yangjian on 2024/1/25.
//

import Foundation

class CacheUtil {
    static let  shared = CacheUtil()
    
    @FileHelper(.logMode, default: .newest)
    var logMode: LogMode
    
    @FileHelper(.bpMeasures, default: [])
    private var bpMeasures: [BPModel]
    
    func appBPModel(_ model: BPModel) {
        bpMeasures.insert(model, at: 0)
    }
    
    func updateBPModel(_ model: BPModel) {
        bpMeasures = bpMeasures.compactMap({ m in
            if model.time == m.time {
                return model
            }
            return m
        })
    }
    
    func removeBPModel(_ model: BPModel) {
        bpMeasures = bpMeasures.filter({$0.time != model.time})
    }
    
    func getBPModels() -> [BPModel] {
        return bpMeasures
    }
    
}
