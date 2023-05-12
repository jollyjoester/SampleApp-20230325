import SwiftUI

struct TodoInputView: View {
    
    @State private var text: String = ""
    @State private var date: Date = Date()
    
    var body: some View {
        VStack {
            Text("TODOを入力してください")
            TextField("TODO", text: $text)
            DatePicker("日付",
                       selection: $date,
                       displayedComponents: [.date]
            )
            Button(action: {
                guard !text.isEmpty else { return }
                // UserDefaultからData型のTodoListを取得して[Todo]型に変換する
                var todoList = Todo.getTodoListFromUserDefaults()
//                var todoList = UserDefaults.standard.object(forKey: "TodoList") as? [Todo] ?? []
                
                let todo = Todo(content: text, date: date)
                todoList.append(todo)
                
                // [Todo]型をData型に変換してUserDefaultに保存
                Todo.setTodoListToUserDefaults(todoList)
            }, label: {
                Text("追加する")
            })
        }
        .padding()
    }
}

struct TodoInputView_Previews: PreviewProvider {
    static var previews: some View {
        TodoInputView()
    }
}
