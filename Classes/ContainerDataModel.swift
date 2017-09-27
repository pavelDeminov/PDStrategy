//
//  ArrayBaseDataModel.swift
//  PositiveClub
//
//  Created by Pavel Deminov on 07/08/2017.
//  Copyright © 2017 Company. All rights reserved.
//

import UIKit

class ContainerDataModel: BaseDataModel {
    
    var containerData: [BaseDataModel]?
    
    override func validate() {
        
        guard let containerData = containerData else {
            return
        }
        
        for cellInfo in containerData {
            cellInfo.validate()
            isValid = cellInfo.isValid
            switch isValid {
            case .invalid(let error):
                validationError = error
                return
            default:
                break
            }
        }
        
    }
    
    override func invalidate() {
        isValid = ValidationState.none
        validationError = nil
    }
}
