//
//  SegmentsContainerView.swift
//  NeverDie
//
//  Created by 이혜빈 on 7/24/25.
//

import SwiftUI

struct SegmentsContainerView: View {
    
    @StateObject private var viewModel = StepChartsViewModel()
    @State private var selectedSegment: SegmentsModel = .day

    var body: some View {
        VStack(spacing: 20) {
            // MARK: 네비게이션 바, 데이터 추가 버튼
            NavigationBar()
            
            SegmentsPickerView(selectedSegment: $selectedSegment)
            
            ChartsTopView(selectedSegment: $selectedSegment)

            
        
        }
            
    }
}

#Preview {
    SegmentsContainerView()
}
