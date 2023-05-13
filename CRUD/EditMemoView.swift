//
//  EditMemoView.swift
//  CRUD
//
//  Created by 寒河江功悟 on 2023/05/12.
//

import SwiftUI

struct EditMemoView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var title: String
    @State private var content: String
    private var memo: Memo
    
    init(memo: Memo) {
        self.memo = memo
        self.title = memo.title ?? ""
        self.content = memo.content ?? ""
    }
    
    var body: some View {
        VStack {
            Button(action: {saveMemo()}) {
                Text("保存")
            }
            TextField("タイトル", text: $title)
                .font(.title)
            TextEditor(text: $content)
                .font(.body)
            Spacer()
        }
    }
    
    private func saveMemo() {
        memo.title = title
        memo.content = content
        memo.updatedAt = Date()

        try? viewContext.save()
    }
}

struct EditMemoView_Previews: PreviewProvider {
    static var previews: some View {
        EditMemoView(memo: Memo())
    }
}
