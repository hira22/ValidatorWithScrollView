//
//  ContentView.swift
//  ValidatorWithScrollView
//
//  Created by hiraoka on 2022/03/01.
//

import SwiftUI

enum Section: String, CaseIterable, Identifiable {
    var id: Int { self.hashValue }

    case zero
    case first
    case second
    case third
    case fourth
    case fifth
    case sixth
    case seventh
    case eighth
    case ninth

    @ViewBuilder
    var content: some View {
        Text(self.rawValue)
    }

    var color: Color {
        switch self {
        case .first, .sixth:
            return .red
        case .second, .seventh:
            return .yellow
        case .third, .eighth:
            return .blue
        case .fourth, .ninth:
            return .green
        case .fifth, .zero:
            return .gray
        }
    }
}

struct ContentView: View {
    @State private var invalidSections: Set<Section> = []
    @State private var invalidIndex: Int?

    var body: some View {
        NavigationView {
            ScrollViewReader { proxy in
                ScrollView {
                    ForEach(Section.allCases) { section in
                        section.content
                            .frame(width: 300, height: 160)
                            .background(section.color.clipShape(RoundedRectangle(cornerRadius: 8)))
                            .id(section.id)
                    }
                }
                .onChange(of: invalidSections) { newValue in
                    proxy.scrollTo(newValue.first?.id, anchor: .top)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem {
                    Button("validate") {
                        let index = (0..<10).randomElement()!
                        invalidIndex = index
                        invalidSections = [Section.allCases[index]]
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Text(invalidIndex?.description ?? "not set")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
