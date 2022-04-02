//
//  FilteringType.swift
//  CoreDataProject
//
//  Created by harsh Khandelwal on 09/11/21.
//

import Foundation

//MARK -: Chllenge 3.1 create FilterType enum
enum FilterType: String, CaseIterable{
    case beginWidth = "BEGINSWITH"
    case beginWidthCaseSensitive = "BEGINSWITH[C]"
    case contains = "CONTAINS"
    case containsCaseSensitive = "CONTAINS[C]"
    case endsWith = "ENDSWITH"
    case endsWithCaseSensitive = "ENDSWITH[C]"
}
