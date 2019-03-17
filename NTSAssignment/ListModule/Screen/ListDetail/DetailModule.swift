//
//  DetailModule.swift
//  NTSAssignment
//
//  Created by Prajwal S on 17/03/19.
//  Copyright © 2019 Prajwal S. All rights reserved.
//

import UIKit

typealias DetailViewModule = UIViewController

protocol DetailViewInput: class {
    func display(model: DetailViewModel)
}

protocol DetailViewOutput {
    func viewDidLoad()
}

protocol DetailRouterInput: class { }

protocol DetailViewInteractorInput { }

protocol DetailViewInteractorOutput: class { }
