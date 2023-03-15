//
//  XPresenter.swift
//  MiProyecto
//
//  Created by Diego Rodriguez Casillas on 8/3/23.
//

import Foundation
import VIPERPLUS

protocol XPresenterProtocol: BasePresenterProtocol {
}

protocol XInteractorOutputProtocol: BaseInteractorOutputProtocol {
	
}

final class XPresenter: BasePresenter {
	
	// MARK: VIPER Dependencies
	weak var view: XViewProtocol? { super.baseView as? XViewProtocol }
	var router: XRouterProtocol? { super.baseRouter as? XRouterProtocol }
	var interactor: XInteractorInputProtocol? { super.baseInteractor as? XInteractorInputProtocol }
//	var viewModel: XViewModel?
		
	// MARK: Private Functions
	func viewDidLoad() {
		
	}
	
}

extension XPresenter: XPresenterProtocol {}

extension XPresenter: XInteractorOutputProtocol {}
