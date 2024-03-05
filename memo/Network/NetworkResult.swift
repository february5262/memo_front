//
//  NetworkResult.swift
//  memo
//
//  Created by visit on 2024/03/05.
//

import Foundation

enum NetworkResult<T> {
    case success(T)
    case requestErr(T)
    case pathErr
    case serverErr
    case succesnetworkFail
}
