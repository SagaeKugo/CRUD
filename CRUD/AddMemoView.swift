//
//  AddMemoView.swift
//  CRUD
//
//  Created by 寒河江功悟 on 2023/05/12.
//

import SwiftUI

struct AddMemoView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentation
    @State private var title: String = ""
    @State private var content: String = ""

    var body: some View {
        VStack {
            HStack{
                Spacer()
                Button(action: {addMemo()}) {
                Text("保存")
                }
            }
            TextField("タイトル", text: $title)
                .font(.title)
            TextEditor(text: $content)
                .font(.body)
            Spacer()
        }
    }
    // 保存ボタン押下時の処理
    private func addMemo() {
        let memo = Memo(context: viewContext)
        memo.title = title
        memo.content = content
        memo.createdAt = Date()
        memo.updatedAt = Date()
    // 生成したインスタンスをCoreDataに保存する
        try? viewContext.save()
    
        presentation.wrappedValue.dismiss()
    }
}

struct AddMemoView_Previews: PreviewProvider {
    static var previews: some View {
        AddMemoView()
    }
}
