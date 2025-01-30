//
//  Coordinator.swift
//  Test
//
//  Created by Dmytro Lyshtva on 29.01.2025.
//

protocol Coordinator: AnyObject {
    var parentCoordinator: Coordinator? { get set }
    var children: [Coordinator] { get set }
    
    func start()
    func didFinish()
}

extension Coordinator {
    func addChild(_ coordinator: Coordinator) {
        children.append(coordinator)
    }

    func childDidFinish(_ coordinator: Coordinator) {
        for (index, child) in children.enumerated() {
            if child === coordinator {
                children.remove(at: index)
                break
            }
        }
    }

    func didFinish() {
        parentCoordinator?.childDidFinish(self)
    }
}
