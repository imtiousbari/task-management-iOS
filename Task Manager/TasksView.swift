//
//  TasksView.swift
//  Task Manager
//
//  Created by Imtious Bari on 20/10/23.
//

import SwiftUI
import SwiftData

struct TasksView: View {
    
    @Binding var date: Date
    
    // SwiftDATA Dynamic Query
    @Query private var tasks: [Task]
    init(date: Binding<Date>) {
        self._date = date
        let calendar = Calendar.current
        let startDate = calendar.startOfDay(for: date.wrappedValue)
        let endOfDate = calendar.date(byAdding: .day, value: 1, to: startDate)!
        let predicate = #Predicate<Task> {
            return $0.date >= startDate && $0.date < endOfDate
        }
        
        // Sorting
        let sortDescriptor = [
            SortDescriptor(\Task.date, order: .reverse)
        ]
        self._tasks = Query(filter: predicate, sort: sortDescriptor, animation: .snappy)
    }
    
    
    var body: some View {
        VStack(alignment: .leading, content: {
            ForEach(tasks) { task in
                TaskItem(task: task)
                    .background(alignment: .leading) {
                        if tasks.last?.id != task.id {
                            Rectangle()
                                .frame(width: 1)
                                .offset(x: 24, y: 45)
                        }
                    }
            }
        })
//        .padding(.top, 450)
        .overlay {
            if tasks.isEmpty {
                VStack{
                    Image("NoTask")
                                .resizable()
                                .frame(width: 350, height: 350)
                                .foregroundColor(.gray)
                    Text("Add a new task")
                        .foregroundColor(.gray)
                        .font(.title3)
                        .frame(width: 300)
//                    Spacer()
                    HStack {
                        Text("Create a new task with")
                            .font(.caption2)
                            .foregroundColor(.gray)

//                            .
                        Circle()
                            .fill(Color.white)
                            .frame(width: 15, height: 15)
                            .overlay(
                                Text("+")
                                    .font(.system(size: 12))
                                    .foregroundColor(.gray)
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.5)
                            )
                            .overlay(
                                Circle()
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                        Text("button")
                            .font(.caption2)
                            .foregroundColor(.gray)
                    }
                }
                .padding(.top, 400)
            }
        }
    }
}

#Preview {
    ContentView()
}
