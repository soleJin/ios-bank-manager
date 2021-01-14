//
//  BankManager.swift
//  Created by yagom.
//  Copyright © yagom academy. All rights reserved.
//

import Foundation

class BankManager {
    let bankClerkCount: Int
    var bankClerks: [BankClerk] = []
    var waitingList = Heap<Customer>(comparator: {
        $0.grade.priority < $1.grade.priority
    })
    
    func holdCustomers() {
        let customerCount = Int.random(in: 10...30)
        for index in 1...customerCount {
            guard let randomCustomerGrade = Grade.allCases.randomElement(),
                  let randomBusinessType = BusinessType.allCases.randomElement() else {
                return
            }
            waitingList.insert(Customer(index: index, grade: randomCustomerGrade, businessType: randomBusinessType))
        }
    }
    
    func makeBankClerk() {
        for index in 1...bankClerkCount {
            self.bankClerks.append(BankClerk(bankWindowNumber: index))
        }
    }
    
    func beReportedWork() {
        guard waitingList.isEmpty else {
            return
        }
        for bankClerk in bankClerks {
            let closedMessage = String(format: ClerkWork.ClosedMessage.rawValue, bankClerk.bankWindowNumber, bankClerk.finishedCustomerNumber, bankClerk.totalTaskTime)
            print(closedMessage)
        }
    }
    
    func work() {
        while !waitingList.isEmpty {
            for bankClerk in bankClerks {
                if bankClerk.working == false {
                    bankClerk.work()
                }
            }
        }
    }

    init(bankClerkCount: Int) {
        self.bankClerkCount = bankClerkCount
    }    
}
