//
//  XInteractor.swift
//  MiProyecto
//
//  Created by Diego Rodriguez Casillas on 8/3/23.
//

import Foundation
import VIPERPLUS

protocol XInteractorInputProtocol: BaseInteractorInputProtocol {
	
}

final class XInteractor: BaseInteractor {
	
	// MARK: VIPER Dependencies
	weak var presenter: XInteractorOutputProtocol? { super.basePresenter as? XInteractorOutputProtocol }
	var provider: XProviderProtocol?
	var assemblyDTO: XAssemblyDTO?
	
}

extension XInteractor: XInteractorInputProtocol {
	
}
