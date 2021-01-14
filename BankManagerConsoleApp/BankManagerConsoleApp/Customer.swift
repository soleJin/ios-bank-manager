//
//  Customer.swift
//  BankManagerConsoleApp
//
//  Created by sole on 2021/01/08.
//

import Foundation

enum Grade: String, CaseIterable {
    case VVIP = "VVIP"
    case VIP = "VIP"
    case 일반 = "일반"
    
    var priority: Int {
        switch self {
        case .VVIP:
            return 0
        case .VIP:
            return 1
        case .일반:
            return 2
        }
    }
}

enum BusinessType: String, CaseIterable {
    case deposit = "예금"
    case loan = "대출"
    
    var taskTime: Double {
        switch self {
        case .deposit:
            return 0.7
        case .loan:
            return 1.1
        }
    }
}

struct Customer {
    let index: Int
    let grade: Grade
    let businessType: BusinessType
}
