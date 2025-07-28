//
//  TodayLifeSaving.swift
//  NeverDie
//
//  Created by 길정수 on 7/25/25.
//

import SwiftUI

struct TodayLifeSaving: View {
    
    // MARK: - Property
    /// 저축 수명을 'day: 1, hour: 2, minute: 30'의 형태로 전달
    let lifeSaving: timeData
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(alignment: .center) {
                Text("오늘의 저축 수명")
                    .font(.sb16)
                    .foregroundStyle(Color.grayCaption03)
                    .figmaLineHeight(fontSize: 16)
                
                Spacer()
                
                Text("상세보기")
                    .font(.m12)
                    .foregroundStyle(Color.grayCaption02)
                    .figmaLineHeight(fontSize: 12)
            }
            
            Text(
                [
                    lifeSaving.day.map { "\($0)일" },
                    lifeSaving.hour.map { "\($0)시간" },
                    lifeSaving.minute.map { "\($0)분" },                ]
                    .compactMap { $0 } /// nil인 항목은 제거
                    .joined(separator: " ")
            )
            .font(.suitH40)
            .foregroundStyle(Color.black01)
            .figmaLineHeight(fontSize: 40)
        }
    }
}
