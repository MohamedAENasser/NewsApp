//
//  Array+SortedInsertion.swift
//  NewsApp
//
//  Created by Mohamed Abd ElNasser on 13/08/2021.
//

import Foundation

extension Array {
    mutating func insertWithCondition(_ element: Element, condition: (Element, Element) -> Bool) {
        var minIndex = 0
        var maxIndex  = self.count - 1
        while minIndex <= maxIndex {
            let midIndex = (minIndex + maxIndex)/2
            if condition(self[midIndex], element) {
                minIndex = midIndex + 1
            } else if condition(element, self[midIndex]) {
                maxIndex = midIndex - 1
            } else {
                insert(element, at: midIndex)
                return
            }
        }
        insert(element, at: minIndex)
    }
}
