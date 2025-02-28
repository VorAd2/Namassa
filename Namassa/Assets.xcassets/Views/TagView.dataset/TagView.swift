//
//  TagView.swift
//  Namassa
//
//  Created by found on 28/01/25.
//

import SwiftUI

struct TagView: View {
    let carnes: [String] = [
        "Frango", "Carne de porco", "Carne moída","cx","r"
    ]
    @State var tagRows: [[String]] = []
    @State var selectedTags: Set<String> = []
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(tagRows, id: \.self) { row in
                        HStack(spacing: 8){
                            ForEach(row,id:\.self){ tag in
                                Text(tag)
                                    .padding(.horizontal,12)
                                    .padding(.vertical,8)
                                    .background{
                                        Capsule()
                                            .fill(selectedTags.contains(tag) ? .orange : .gray.opacity(0.3))
                                    }
                                    .fixedSize()
                                    .scaleEffect(selectedTags.contains(tag) ? 0.9 : 1.0)
                                    .onTapGesture{
                                        toggleSelection(for: tag)
                                    }
                                    .animation(.spring, value: selectedTags.contains(tag))
                            }
                        }
                    }
                }.padding()
                .onAppear(){
                    calculateRows(for: geometry.size.width)
                }
            }
            
        }
    }
    
    private func toggleSelection(for tag: String){
        if selectedTags.contains(tag) {
            selectedTags.remove(tag)
        } else {
            selectedTags.insert(tag)
        }
    }
    private func calculateRows(for availableWidth: CGFloat){
        tagRows = []
        var currentRow: [String] = []
        var currentRowWidth: CGFloat = 0
        for tag in carnes {
            let tagWidth = tag.calculateWidth(usingFont: .systemFont(ofSize: 16)) + 16
            if currentRowWidth + tagWidth <= availableWidth {
                currentRow.append(tag)
                currentRowWidth += tagWidth
            } else {
                tagRows.append(currentRow)
                currentRow = [tag]
                currentRowWidth = tagWidth
            }
        }
        if !currentRow.isEmpty {
            tagRows.append(currentRow)
        }
    }
}
extension String {
    func calculateWidth(usingFont font: UIFont) -> CGFloat {
        let textWidth = (self as NSString).size(withAttributes: [.font: font]).width
        let paddingWidth = 24
        return textWidth + CGFloat(paddingWidth)
    }
}
#Preview {
    TagView()
}
