//
//  BankClerk.swift
//  BankManagerConsoleApp
//
//  Created by sole on 2021/01/08.
//

import Foundation

class BankClerk {
    var bankWindowNumber: Int
    var finishedCustomerNumber: Int = 0
    var totalTaskTime: Double = 0.0
    var working: Bool = false
    
    init(bankWindowNumber: Int) {
        self.bankWindowNumber = bankWindowNumber
    }
    
    func work() {
        startWork()
        finishWork()
    }
    
    private func startWork() {
        guard let customer = bankManager.waitingList.delete() else {
            return
        }
        working = true
        let startMessage = String(format: ClerkWork.stratMessage.rawValue, bankWindowNumber, customer.index, customer.grade.rawValue, customer.businessType.rawValue)
        print(startMessage)
        totalTaskTime += customer.businessType.taskTime
        finishedCustomerNumber += 1
        let finishedMessage = String(format: ClerkWork.FinishedMessage.rawValue, bankWindowNumber, customer.index, customer.grade.rawValue, customer.businessType.rawValue)
        print(finishedMessage)
    }
    
    private func finishWork() {
        working = false
    }
}

