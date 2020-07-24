//
//  View_Extensions.swift
//  NCImageSearch
//
//  Created by Nitin Chadha on 11/06/20.
//  Copyright © 2020 Nitin Chadha. All rights reserved.
//

import UIKit

protocol ReusableView: class {
    static var reusableId: String { get }
}

extension UIStoryboard {
    func getViewController<T: UIViewController>() -> T? {
        return self.instantiateViewController(withIdentifier: T.reusableId) as? T
    }
}

extension UIViewController: ReusableView {
    static var reusableId: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}

extension String {
    func condenseWhitespace() -> String {
        let components = self.components(separatedBy: .whitespacesAndNewlines)
        return components.filter { !$0.isEmpty }.joined(separator: "+")
    }
}
