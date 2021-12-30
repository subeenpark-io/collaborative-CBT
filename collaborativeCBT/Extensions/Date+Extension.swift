//
//  Date+Extension.swift
//  collaborativeCBT
//
//  Created by Subeen Park on 2021/12/31.
//

import Foundation

extension Date {
    
    var commentTime: String {
        
        var formatter_time = DateFormatter()
        formatter_time.dateFormat = "HH:mm"
        var time_string = formatter_time.string(from: self)

        return time_string
    }
}
