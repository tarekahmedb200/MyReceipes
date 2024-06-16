//
//  ReceipeItemViewModel.swift
//  MyReceipes
//
//  Created by tarek ahmed on 15/06/2024.
//

import Foundation
import UIKit


class ReceipeItemViewModel: ObservableObject {
    @Published var receipeImage : UIImage?
    var receipe : Receipe
    private var imageLocalServiceProtocol : ImageLocalServiceProtocol
    
    init(receipe: Receipe,imageLocalServiceProtocol: ImageLocalServiceProtocol) {
        self.imageLocalServiceProtocol = imageLocalServiceProtocol
        self.receipe = receipe
        receipeImage = self.imageLocalServiceProtocol.fetchImage(withName: receipe.name)
    }
    
}
