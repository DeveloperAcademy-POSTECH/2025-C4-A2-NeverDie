//
//  TestNavigation.swift
//  NeverDie
//
//  Created by 이혜빈 on 7/21/25.
//

import SwiftUI

struct TestNavigation: View {
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink(destination: SegmentsContainerView()) {
                    Text("상세보기")
                    
                }
            }
        }
    }
}

#Preview {
    TestNavigation()
}
