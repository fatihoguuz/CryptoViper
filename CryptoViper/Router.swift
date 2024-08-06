//
//  Router.swift
//  CryptoViper
//
//  Created by Fatih Oğuz on 2.08.2024.
//

import Foundation
import UIKit

// Class

typealias EntryPoint = AnyView & UIViewController

protocol AnyRouter {
    var entry : EntryPoint? {get}
    static func startExecution() -> AnyRouter
}

class CryptoRouter : AnyRouter {
    var entry : EntryPoint?
    
    static func startExecution() -> AnyRouter {
        let router = CryptoRouter()
        
        var view : AnyView = CryptoView()
        var interactor : AnyInteractor = CryptoInteractor()
        var presenter : AnyPresenter = CryptoPresenter()
        
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        router.entry = view as? EntryPoint
        
    return router
    }
}

