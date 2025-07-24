//
//  TodayStepCount.swift
//  NeverDie
//
//  Created by 길정수 on 7/21/25.
//

import SwiftUI

struct TodayStepCount: View {
    let stepCount: Int
    
    var body: some View {
        HStack {
            Text("오늘 걸음 수")
                .font(.calloutBold16)
            
            Spacer()
            
            HStack(alignment: .bottom, spacing: 3) {
                Text("\(stepCount)")
                    .font(.largeTitleSemiBold32)
                
                Text("걸음")
                    .font(.subheadlineMedium18)
                    .offset(y: -4)
            }
            .figmaLineHeight(fontSize: 18)
        }
        .foregroundStyle(Color.green03)
        .padding(.horizontal, 20)
        .padding(.bottom, 8)
        .frame(maxWidth: .infinity)
        .frame(height: 174, alignment: .bottom)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.green02)
        )
    }
}

#Preview {
    TodayStepCount(stepCount: 7524)
}
