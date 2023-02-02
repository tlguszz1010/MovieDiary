//
//  Dynamic.swift
//  MovieDiary
//
//  Created by 박시현 on 2023/02/01.
//

import Foundation


public class Dynamic<T> {
    public typealias Listener = (T) -> Void?
    private var listener : Listener?
    
    public func bind(_ listener: Listener?) {
        self.listener = listener
    }
    
    // 값 바뀔 때마다 didSet으로 감지해서 listener 클로저 실행
    public var value: T {
        didSet {
            listener?(value)
        }
    }
    
    public init(_ val: T) {
        value = val
    }
}
