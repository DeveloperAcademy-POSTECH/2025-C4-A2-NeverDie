//
//  NavigationVar.swift
//  NeverDie
//
//  Created by 이혜빈 on 7/21/25.
//

import SwiftUI

struct NavigationBar: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            // MARK: 커스텀 네비게이션 바
            HStack {
                // < 홈
                Button(action: {
                    dismiss()
                }) {
                    HStack(spacing: 4) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 17, weight: .bold))
                        Text("홈")
                    }
                    .foregroundStyle(.greenChart02)
                    .font(.navLabelRegular17)
                }
                
//                Spacer()
                
                // 중앙 타이틀(네비게이션 커스텀 해서 텍스트로)
                Text("걸음수 상세")
                    .font(.navLabelSemiBold17)
                    .foregroundStyle(.black01)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.leading, 38)
                
                
                
                //                Spacer()
                
                
                Button(action: {
                    // 버튼 액션
                }) {
                    Text("데이터추가")
                        .foregroundStyle(.greenChart02)
                        .font(.navLabelSemiBold17)
                }
            }
        }
        .safeAreaPadding(.horizontal, 16)
        .navigationBarBackButtonHidden(true) // 시스템 백버튼 숨김
    }
}

#Preview {
    NavigationBar()
}
