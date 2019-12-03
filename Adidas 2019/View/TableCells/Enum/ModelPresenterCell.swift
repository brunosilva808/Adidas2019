//
//  ModelPresenter.swift
//  Farfetch 2019
//
//  Created by Bruno on 28/10/2019.
//  Copyright © 2019 Bruno. All rights reserved.
//

import Foundation

protocol ModelPresenterCell {
    associatedtype Model
    var model: Model? { get set }
}
