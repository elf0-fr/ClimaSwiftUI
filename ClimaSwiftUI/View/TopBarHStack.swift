//
//  TopBarHStack.swift
//  ClimaSwiftUI
//
//  Created by Elfo on 28/06/2025.
//

import SwiftUI

struct TopBarHStack: Layout {
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        guard !subviews.isEmpty else {
            return .zero
        }
        
        // The view height must be equal to the textfield's height.
        
        return CGSize(
            width: proposal.width ?? 0,
            height: subviews[1].sizeThatFits(.unspecified).height
        )
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        guard !subviews.isEmpty else {
            return
        }
        
        let height = subviews[1].sizeThatFits(.unspecified).height
        
        let spacing = subviews.indices.map { index in
            guard index < subviews.count - 1 else { return CGFloat(0) }
            return subviews[index].spacing.distance(
                to: subviews[index + 1].spacing,
                along: .horizontal
            )
        }
        
        var x = bounds.minX + height / 2
        
        subviews[0].place(
            at: CGPoint(x: x, y: bounds.midY),
            anchor: .center,
            proposal: ProposedViewSize(width: height, height: height)
        )
        
        x += height / 2 + spacing[0]
        
        guard let proposedWidth = proposal.width else {
            return
        }
        
        let textfieldWidth = proposedWidth - spacing[0] - height
        
        subviews[1].place(
            at: CGPoint(x: x, y: bounds.midY),
            anchor: .leading,
            proposal: ProposedViewSize(width: textfieldWidth, height: height)
        )
    }
}

#Preview {
    TopBarHStack {
        Image(systemName: "location.circle.fill")
            .resizable()
            .scaledToFit()
        
        TextField("Search...", text: .constant(""))
            .padding(.vertical, 5)
            .padding(.horizontal)
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.ultraThinMaterial)
            }
    }
    .padding()
}
