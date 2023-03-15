//
//  XViewController.swift
//  MiProyecto
//
//  Created by Diego Rodriguez Casillas on 8/3/23.
//

import UIKit
import VIPERPLUS

protocol XViewProtocol: BaseViewProtocol {
	
}

class XViewController: BaseViewController {
	
	// MARK: VIPER Dependencies
	var presenter: XPresenterProtocol? { super.basePresenter as? XPresenterProtocol }
	
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

extension XViewController: XViewProtocol {

}
