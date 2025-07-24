//
//  SegmentsContainerView.swift
//  NeverDie
//
//  Created by 이혜빈 on 7/21/25.
//

import SwiftUI

struct SegmentsContainerView: View {
    
    @State private var selectedSegment: SegmentsModel = .day

    var body: some View {
        VStack(spacing: 0) {
            // MARK: 네비게이션 바, 데이터 추가 버튼
            NavigationBar()
            
            SegmentsPickerView()
        }
            
    }
}

#Preview {
    SegmentsContainerView()
}
