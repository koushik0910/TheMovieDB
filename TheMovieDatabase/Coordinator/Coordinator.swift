//
//  Coordinator.swift
//  TheMovieDatabase
//
//  Created by Koushik Dutta on 18/02/24.
//

import Foundation

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    func start()
}
