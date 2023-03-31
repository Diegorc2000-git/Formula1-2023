//
//  AlertManager.swift
//  Formula1
//
//  Created by Diego Rodriguez Casillas on 30/3/23.
//

import Foundation
import SwiftUI

class AlertManager: ObservableObject {
    @Published var isPresented: Bool
    @Published var model: AlertModelView
    
    init(isPresented: Bool = false, model: AlertModelView = AlertModelView()) {
        self.isPresented = isPresented
        self.model = model
    }
    
    func popAlert(
        title: String,
        subtitle: String,
        primaryActionTitle: String,
        secondaryActionTitle: String? = nil,
        primaryAction: @escaping (()->Void),
        secondaryAction: (()->Void)? = nil
    ) {
        self.model.title = title
        self.model.subtitle = subtitle
        self.model.primaryButtonLabel = primaryActionTitle
        self.model.secondaryButtonLabel = secondaryActionTitle
        self.model.primaryButtonAction = primaryAction
        self.model.secondaryButtonAction = secondaryAction
        self.isPresented = true
    }
   
    func popAlert(
        model: AlertModelView
    ) {
        self.model = model
        self.isPresented = true
    }
    
    func getAlert() -> Alert {
        if model.secondaryButtonAction == nil {
            return getSimpleAlert()
        } else {
            return getComplexAlert()
        }
    }
    
    private func getSimpleAlert() -> Alert {
        return Alert(
            title: Text(model.title),
            message: Text(model.subtitle),
            dismissButton:
                Alert.Button.default(
                    Text(model.primaryButtonLabel ?? "")
                    , action: {
                        self.performActionOnMainThread(
                            self.model.primaryButtonAction
                        )
                    }
                )
        )
    }
    
    private func getComplexAlert() -> Alert {
        return Alert(
            title: Text(model.title),
            message: Text(model.subtitle),
            primaryButton:
              Alert.Button.default(
                    Text(model.primaryButtonLabel ?? "")
                    , action: {
                        self.performActionOnMainThread(
                            self.model.primaryButtonAction
                        )
                    }
                )
            ,
            secondaryButton:
                Alert.Button.cancel(
                    Text(model.secondaryButtonLabel ?? "")
                    , action: {
                        self.performActionOnMainThread(
                            self.model.secondaryButtonAction
                        )
                    }
                )
        )
    }
 
    private func performActionOnMainThread(_ action: (()->Void)?) {
        DispatchQueue.main.async {
            if let action = action {
                action()
            }
        }
    }
}

struct AlertModelView {
    var title: String = ""
    var subtitle: String = ""
    var primaryButtonLabel: String?
    var primaryButtonAction: (()->Void)?
    var secondaryButtonLabel: String?
    var secondaryButtonAction: (()->Void)?
}


