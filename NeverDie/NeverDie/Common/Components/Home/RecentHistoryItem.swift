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
        
        HStack(spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(lifeSpanChange > 0 ? Color.green02 : Color.brown01)
                    .frame(width: 48, height: 46)
                
                Image(.walkingIcon)
                    .renderingMode(.template)
                    .tint(lifeSpanChange > 0 ? Color.green03 : Color.brown02)
            }
            
            VStack(alignment: .leading, spacing: 0) {
                HStack(alignment: .center, spacing: 2) {
                    Text("\(stepCount)")
                        .font(.subheadlineSemiBold20)
                        .foregroundColor(.black01)
                    
                    Text("걸음")
                        .font(.subheadlineMedium18)
                        .foregroundColor(.grayCaption03)
                }
                
                Text("\(startTime)시 - \(startTime + 1)시")
                    .font(.captionMedium12)
                    .foregroundColor(.grayCaption02)
                    .figmaLineHeight(fontSize: 12)
            }
            
            Spacer()
            
            HStack(spacing: 1) {
                Text("\(lifeSpanChange)")
                    .font(.headlineBold24)
                    .foregroundColor(lifeSpanChange > 0 ? Color.green03 : Color.brown02)
                
                Text("분")
                    .font(.captionMedium16)
                    .foregroundColor(.grayCaption03)
            }
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }
}

#Preview {
    RecentHistoryItem(stepCount: 12345, startTime: 22, lifeSpanChange: -30)
}
