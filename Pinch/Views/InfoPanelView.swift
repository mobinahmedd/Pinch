//
//  InfoPanelView.swift
//  Pinch
//
//  Created by Apptycoons on 01/04/2024.
//

import SwiftUI

struct InfoPanelView: View {
    // MARK: - PROPERTIES
    var scale: CGFloat
    var offSet: CGSize
    
    @State private var isInfoPanelVisible: Bool = false
    
    // MARK: - BODY
    var body: some View {
        
        HStack{
            //MARK: HOTSPOT
            Image(systemName: "circle.circle")
                .symbolRenderingMode(.hierarchical)
                .frame(width: 30,height: 30)
                .onLongPressGesture(minimumDuration: 1, perform: {
                    withAnimation(.easeOut){
                        isInfoPanelVisible.toggle()
                    }
                })
            Spacer()
            
            //MARK: INFO PANEL
            HStack(spacing:2){
                Image(systemName: "arrow.up.left.and.arrow.down.right")
                Text("\(scale)")
                
                Spacer()
                
                Image(systemName: "arrow.left.and.right")
                Text("\(offSet.width)")
                
                Spacer()
                
                Image(systemName: "arrow.up.and.down")
                Text("\(offSet.height)")
                
                Spacer()
            }
            .font(.footnote)
            .padding(8)
            // enable blur effect in background (glass like effect)
            .background(.ultraThinMaterial)
            .cornerRadius(8)
            .frame(maxWidth : 420)
            .opacity(isInfoPanelVisible ? 1 : 0)
        }
       
        
        Spacer()
    }
}

#Preview {
    InfoPanelView(scale: 1, offSet: .zero)
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
        .previewLayout(.sizeThatFits)
        .padding()
}
