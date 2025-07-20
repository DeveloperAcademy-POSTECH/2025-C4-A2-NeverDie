import func SwiftUI.__designTimeFloat
import func SwiftUI.__designTimeString
import func SwiftUI.__designTimeInteger
import func SwiftUI.__designTimeBoolean

#sourceLocation(file: "/Users/giljeongsu/Desktop/🍎/C4/2025-C4-A2-NeverDie/NeverDie/NeverDie/Views/Components/Home/RecentHistoryItem.swift", line: 1)
//
//  RecentHistoryItem.swift
//  NeverDie
//
//  Created by 길정수 on 7/20/25.
//

import SwiftUI

struct RecentHistoryItem: View {
    let stepCount: Int
    let startTime: Int
    let lifeSpanChange: Int
    
    var body: some View {
        
        HStack(spacing: __designTimeInteger("#21464_0", fallback: 12)) {
            ZStack {
                RoundedRectangle(cornerRadius: __designTimeInteger("#21464_1", fallback: 12))
                    .fill(lifeSpanChange > __designTimeInteger("#21464_2", fallback: 0) ? Color.green02 : Color.brown01)
                    .frame(width: __designTimeInteger("#21464_3", fallback: 48), height: __designTimeInteger("#21464_4", fallback: 46))
                
                Image(.walkingIcon)
                    .renderingMode(.template)
                    .tint(lifeSpanChange > __designTimeInteger("#21464_5", fallback: 0) ? Color.green03 : Color.brown02)
            }
            
            VStack(alignment: .leading, spacing: __designTimeInteger("#21464_6", fallback: 0)) {
                HStack(alignment: .center, spacing: __designTimeInteger("#21464_7", fallback: 2)) {
                    Text("\(stepCount)")
                        .font(.subheadlineSemiBold20)
                        .foregroundColor(.black01)
                    
                    Text(__designTimeString("#21464_8", fallback: "걸음"))
                        .font(.subheadlineMedium18)
                        .foregroundColor(.grayCaption03)
                }
                
                Text("\(startTime)시 - \(startTime + __designTimeInteger("#21464_9", fallback: 1))시")
                    .font(.captionMedium12)
                    .foregroundColor(.grayCaption02)
                    .figmaLineHeight(fontSize: __designTimeInteger("#21464_10", fallback: 12))
            }
            
            Spacer()
            
            HStack(spacing: __designTimeInteger("#21464_11", fallback: 1)) {
                Text("\(lifeSpanChange)")
                    .font(.headlineBold24)
                    .foregroundColor(lifeSpanChange > __designTimeInteger("#21464_12", fallback: 0) ? Color.green03 : Color.brown02)
                
                Text(__designTimeString("#21464_13", fallback: "분"))
                    .font(.captionMedium16)
                    .foregroundColor(.grayCaption03)
            }
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }
}

#Preview {
    RecentHistoryItem(stepCount: __designTimeInteger("#21464_14", fallback: 12345), startTime: __designTimeInteger("#21464_15", fallback: 22), lifeSpanChange: __designTimeInteger("#21464_16", fallback: -30))
}
