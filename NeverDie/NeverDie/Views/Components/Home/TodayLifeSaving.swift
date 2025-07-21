//
//  TodayLifeSaving.swift
//  NeverDie
//
//  Created by 길정수 on 7/21/25.
//

import SwiftUI

struct TodayLifeSaving: View {
    let date: String
    let lifeSaving: String
    
    var body: some View {
        Button (action: {
            print("오늘의 수명 저축량 클릭")
        }, label: {
            VStack(spacing: 10) {
                HStack {
                    Text("\(date)")
                    
                    Spacer()
                    
                    Text("상세보기")
                }
                .font(.captionRegular13)
                
                HStack {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("오늘의")
                        Text("수명 저축량")
                    }
                    .font(.calloutBold16)
                    
                    Spacer()
                    
                    Text("\(lifeSaving)")
                        .font(.largeTitleBold40)
                    
                }
            }
            .foregroundStyle(Color.green02)
            .padding(.horizontal, 20)
            .padding(.top, 15)
            .padding(.bottom, 9)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.green03)
                    .frame(maxWidth: .infinity)
            )
        })    }
}

#Preview {
    TodayLifeSaving(date: "2025.07.16", lifeSaving: "1시간 27분")
}
