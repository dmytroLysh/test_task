//
//  PreloaderViewModel.swift
//  Test
//
//  Created by Dmytro Lyshtva on 29.01.2025.
//

import Foundation

protocol PreloaderNavigation: AnyObject {
    func goToMainScreen()
}

final class PreloaderViewModel {
    
    var navigation: PreloaderNavigation
    
    init(navigation: PreloaderNavigation) {
        self.navigation = navigation
    }
    
    func determineInitialScreen() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            
            guard let self = self else { return }
            
            self.navigation.goToMainScreen()
        }
        
    }
    
    
}
