//
//  ControlImageView.swift
//  Pinch
//
//  Created by Apptycoons on 01/04/2024.
//

import SwiftUI

struct ControlImageView: View {
    let icon: String
    var body: some View {
        
        Image(systemName: icon)
            .symbolRenderingMode(.hierarchical)
            .font(.system(size: 36))
        
    }
}

#Preview {
    ControlImageView(icon: "plus.magnifyingglass")
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
        .previewLayout(.sizeThatFits)
        .padding()
}
