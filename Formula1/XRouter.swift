//
//  XRouter.swift
//  MiProyecto
//
//  Created by Diego Rodriguez Casillas on 8/3/23.
//

import Foundation
import VIPERPLUS

protocol XRouterProtocol: BaseRouterProtocol {
}

final class XRouter: BaseRouter {
	
	// MARK: VIPER Dependencies
	weak var view: XViewController? { super.baseView as? XViewController }
	
	// MARK: Private Functions
	
}

extension XRouter: XRouterProtocol {
}
