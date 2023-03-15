//
//  XAssembly.swift
//  MiProyecto
//
//  Created by Diego Rodriguez Casillas on 8/3/23.
//

import Foundation
import VIPERPLUS
import UIKit

// MARK: - module builder
final class XAssembly: BaseAssembly {
	
	static func navigationController() -> UINavigationController {
		let navigationController = UINavigationController(rootViewController: view())
		return navigationController
	}
	
	static func view() -> XViewController {
		let view = XViewController()
		
		_ = BaseAssembly.assembly(baseView: view,
								  presenter: XPresenter.self,
								  router: XRouter.self,
								  interactor: XInteractor.self)
		
		return view
	}
}

class XAssemblyDTO {
	
}
