//
//  PageModel.swift
//  Pinch
//
//  Created by Apptycoons on 01/04/2024.
//

import Foundation

struct Page : Identifiable {
    let id : Int
    let imageName: String
}

// we can add this as a function in above struct,
// doing it in extension make main struct cleaner
extension Page {
    var thumbnailName: String {
        return "thumb-" + imageName
    }
}
