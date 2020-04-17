//
//  Row.swift
//  Eventoon
//
//  Created by Pedro Arenhardt Wagner  on 16/04/20.
//  Copyright © 2020 Pedro Arenhardt Wagner . All rights reserved.
//

import UIKit

typealias ConfigurationClosure = (_ cell: UIView, _ row: Row, _ indexPath: IndexPath) -> Void
typealias DidSelectRowClosure = (_ cell: UIView, _ row: Row, _ indexPath: IndexPath) -> Void

protocol RowRepresentable {
    var identifier: String { get }
    var configuration: ConfigurationClosure? { get set }
}

final class Row: RowRepresentable {
    var identifier: String
    
    var configuration: ConfigurationClosure?
    var didSelect: DidSelectRowClosure?
    
    init(identifier: String) {
        self.identifier = identifier
    }
    
    func setConfiguration(_ configurationClosure: @escaping ConfigurationClosure) {
        self.configuration = configurationClosure
    }
    
    func setDidSelect(_ didSelectClosure: @escaping DidSelectRowClosure) {
        self.didSelect = didSelectClosure
    }
}
