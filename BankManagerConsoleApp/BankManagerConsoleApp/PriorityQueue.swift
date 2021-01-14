//
//  PriorityQueue.swift
//  BankManagerConsoleApp
//
//  Created by sole on 2021/01/13.
//

import Foundation

struct Heap<T> {
    var nodes: [T] = []
    let comparator: (T, T) -> Bool
    var isEmpty: Bool {
        return nodes.isEmpty
    }
    
    init(comparator: @escaping (T, T) -> Bool) {
        self.comparator = comparator
    }
    
    func gotParentIndex(of index: Int) -> Int? {
        guard index > 0 else { return nil }
        return (index-1)/2
    }
    
    func gotLeftChildIndex(of index: Int) -> Int? {
        if case let leftChildIndex = (index * 2) + 1, leftChildIndex < nodes.count {
            return leftChildIndex
        }
        return nil
    }
    
    func gotRightChildIndex(of index: Int) -> Int? {
        if case let rightChildIndex = (index * 2) + 2, rightChildIndex < nodes.count {
            return rightChildIndex
        }
        return nil
    }
    
    mutating func siftUp(at index: Int) {
        var index = index
        while let parentIndex = gotParentIndex(of: index), comparator(nodes[index], nodes[parentIndex]) {
            nodes.swapAt(index, parentIndex)
            index = parentIndex
        }
    }
    
    mutating func insert(_ element: T) {
        nodes.append(element)
        siftUp(at: nodes.count-1)
    }
    
    func availableChildAndChange(at index: Int) -> Int? {
        //왼쪽자식없으면 바꿀필요없음
        guard let leftChildIndex = gotLeftChildIndex(of: index) else { return nil }
        //왼쪽자식있고 오른쪽자식 있으면
        if let rightChildIndex = gotRightChildIndex(of: index) {
            //자식들끼리 비교 우선순위 높은자식이랑
            let childIndex = comparator(nodes[leftChildIndex], nodes[rightChildIndex]) ? leftChildIndex : rightChildIndex
            //그자식이랑 현재인덱스랑 비교해서 안바꿔도 되면 nil
            return comparator(nodes[childIndex], nodes[index]) ? childIndex : nil
        }
        //왼쪽자식있고 오른쪽자식 없으면 왼쪽자식이랑만 비교해서 자식이이기면 바꾸고 내가이기면 안바꿔
        return comparator(nodes[leftChildIndex], nodes[index]) ? leftChildIndex : nil
    }
    
    mutating func siftDown(at index: Int) {
        var index = index
        while let childIndex = availableChildAndChange(at: index) {
            nodes.swapAt(index, childIndex)
            index = childIndex
        }
    }
    
    mutating func delete() -> T? {
        guard !isEmpty else { return nil }
        //리무브라스트를 리턴으로 토하면 왜 가끔 잘못 빠지는지 모르겠다
        let willDelete = nodes[0]
        nodes.swapAt(0, nodes.count-1)
        nodes.removeLast()
        siftDown(at: 0)
        return willDelete
    }
}
