//
//  Components.swift
//  WaterReminder
//
//  Created by Rémy on 19/02/2022.
//

import SwiftUI

struct Components: View {
    var progress: Double
    var lineWidth: CGFloat
    var gradient: Gradient
    
    var body: some View {
        Circle()
            .trim(from: 0, to: CGFloat(progress))
            .rotation(.degrees(-90))
            .stroke(
                    AngularGradient(gradient: gradient,
                                    center: .center,
                                    startAngle: .degrees(-90),
                                    endAngle: .degrees(progress * 360 - 90)),
                                    style: .init(lineWidth: lineWidth, lineCap: .round)
                    )
            .scaledToFit()
            .padding(lineWidth/2)
            .overlay(
                    GeometryReader { geo in
                        // End round line cap and shadow
                        Circle()
                            .fill(self.gradient.stops[1].color)
                            .frame(width: self.lineWidth, height: self.lineWidth)
                            .position(x: geo.size.width / 2, y: geo.size.height / 2)
                            .offset(x: min(geo.size.width, geo.size.height)/2 - lineWidth / 2)
                            .rotationEffect(.degrees(self.progress * 360 - 90))
                            .shadow(color: .black.opacity(0.5), radius: self.lineWidth/2, x: 0, y: 0)
                    }
                    .clipShape(
                        // Clip end round line cap and shadow to front
                        Circle()
                            .offset(x:-lineWidth / 2)
                            .rotation(.degrees(-90 + self.progress * 360 - 0.5))
                            .trim(from: 0, to: 0.25)
                            .stroke(style: .init(lineWidth: self.lineWidth))
                    )
                )
    }
}

struct Components_Previews: PreviewProvider {
    static var previews: some View {
        Components(progress: 0.5, lineWidth: 50, gradient: Gradient(colors: [Color("Ring1"),Color("Ring2")]))
    }
}

