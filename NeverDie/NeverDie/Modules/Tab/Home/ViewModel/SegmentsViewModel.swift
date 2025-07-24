//
//  SegmentsViewModel.swift
//  NeverDie
//
//  Created by 이혜빈 on 7/21/25.
//

import Foundation
import SwiftUI

// MARK: 현재 선택된 세그먼트 상태를 관리하는 ViewModel
class SegmentViewModel: ObservableObject {
    
    // MARK: 선택된 세그먼트 (기본값: 1일)
    @Published var selectedSegment: SegmentsModel = .day
}
