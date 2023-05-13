//
//  ContentView.swift
//  CRUD
//
//  Created by 寒河江功悟 on 2023/05/11.
//

//  ContentView.swift

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        entity: Memo.entity(),
        sortDescriptors: [NSSortDescriptor(key: "updatedAt", ascending: false)],
        animation: .default
    ) var fetchedMemoList: FetchedResults<Memo>
    @State private var show: Bool = false
    
    var body: some View {
        VStack{
            Spacer()
            HStack{
                VStack{
                    Button(action: {
                        testAddInit()
                    }){
                        Text("testAdd")
                    }
                    Button(action: {
                        allDelete()
                    }){
                        Text("testDelete")
                    }
                }
                Spacer()
                Text("メモアプリ")
                    .font(.title)
                Spacer()
                Button(action: {
                    self.show.toggle()
                }){
                    Text("新規作成")
                }.sheet(isPresented: self.$show){
                    AddMemoView()
                }
            }
            NavigationView {
                List {
                    ForEach(fetchedMemoList) { memo in
                        NavigationLink(destination: EditMemoView(memo: memo)) {
                            VStack {
                                Text(memo.title ?? "")
                                    .font(.title)
                                    .frame(maxWidth: .infinity,alignment: .leading)
                                    .lineLimit(1)
                                HStack {
                                    Text (memo.stringUpdatedAt)
                                        .font(.caption)
                                        .lineLimit(1)
                                    Text(memo.content ?? "")
                                        .font(.caption)
                                        .lineLimit(1)
                                    Spacer()
                                }
                            }
                        }
                    }
                    .onDelete(perform: deleteMemo)
                }
            }
        }
    }
    // 削除時の処理
    private func deleteMemo(offsets: IndexSet) {
        offsets.forEach { index in
            viewContext.delete(fetchedMemoList[index])
        }
        try? viewContext.save()
    }
    
    // テスト用に10件追加
    private func testAddInit() {
        for index in 0..<10 {
            let newMemo = Memo(context: viewContext)
            newMemo.title = "メモタイトル\(index + 1)"
            newMemo.content = "メモ\(index + 1)の内容が記載されています"
            newMemo.createdAt = Date()
            newMemo.updatedAt = Date()
        }
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    // 全削除
    private func allDelete() {
        for index in 0..<fetchedMemoList.count{
            viewContext.delete(fetchedMemoList[index])
        }
        try? viewContext.save()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
