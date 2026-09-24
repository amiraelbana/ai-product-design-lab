import SwiftUI

struct ContentView: View {
    
    @State private var showingAddTask = false
    
    @State private var tasks = [
        "Finish portfolio case study",
        "Prepare interview presentation",
        "Review Figma prototype",
        "Swift practice"
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 28) {
                    
                    // Header
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Good morning 👋")
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text("Let's make today count.")
                            .font(.title3)
                            .foregroundStyle(.secondary)
                    }
                    
                    // Progress Card
                    VStack(alignment: .leading, spacing: 14) {
                        HStack {
                            Text("TODAY")
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundStyle(.secondary)
                            
                            Spacer()
                            
                            Text("\(tasks.count) tasks")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        
                        Text("Your focus")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        ProgressView(value: 0.25)
                            .tint(.primary)
                        
                        Text("1 of \(tasks.count) tasks completed")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    .padding(20)
                    .background(Color(.secondarySystemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                    // Tasks
                    VStack(alignment: .leading, spacing: 18) {
                        Text("Today's tasks")
                            .font(.headline)
                        
                        ForEach(tasks, id: \.self) { task in
                            HStack(spacing: 14) {
                                Image(systemName: "circle")
                                    .font(.title3)
                                
                                Text(task)
                                    .font(.body)
                                
                                Spacer()
                            }
                        }
                    }
                    
                    // AI Button
                    NavigationLink(destination: FocusPlanView()) {
                        HStack {
                            Image(systemName: "sparkles")
                            
                            Text("Plan My Day")
                                .fontWeight(.semibold)
                            
                            Spacer()
                            
                            Image(systemName: "arrow.right")
                        }
                        .padding(18)
                        .foregroundStyle(.white)
                        .background(.black)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                    }
                }
                .padding(24)
            }
            .navigationTitle("FocusFlow")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingAddTask = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddTask) {
                AddTaskView { newTask in
                    tasks.append(newTask)
                }
            }
        }
    }
}


// MARK: - Focus Plan

struct FocusPlanView: View {
    
    let plan = [
        ("09:00", "Finish portfolio case study", "Deep Focus", "90 min"),
        ("10:45", "Prepare interview presentation", "High Priority", "45 min"),
        ("12:00", "Review Figma prototype", "Design", "30 min"),
        ("16:00", "Swift practice", "Learning", "45 min")
    ]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 28) {
                
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Image(systemName: "sparkles")
                        
                        Text("AI FOCUS PLAN")
                            .font(.caption)
                            .fontWeight(.semibold)
                    }
                    .foregroundStyle(.secondary)
                    
                    Text("Your day, optimized.")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("I've organized your tasks to protect your focus and keep your day achievable.")
                        .foregroundStyle(.secondary)
                }
                
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("4")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Text("Tasks")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("3h 30m")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Text("Focus time")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("16:45")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Text("Finish")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
                .padding(20)
                .background(Color(.secondarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                VStack(spacing: 0) {
                    ForEach(Array(plan.enumerated()), id: \.offset) { index, item in
                        HStack(alignment: .top, spacing: 18) {
                            Text(item.0)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .frame(width: 48, alignment: .leading)
                            
                            VStack(alignment: .leading, spacing: 6) {
                                Text(item.1)
                                    .font(.headline)
                                
                                HStack {
                                    Text(item.2)
                                    Text("•")
                                    Text(item.3)
                                }
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            }
                            
                            Spacer()
                        }
                        .padding(.vertical, 18)
                        
                        if index < plan.count - 1 {
                            Divider()
                        }
                    }
                }
                
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Image(systemName: "sparkles")
                        
                        Text("AI Insight")
                            .fontWeight(.semibold)
                    }
                    
                    Text("Your most demanding task is scheduled first, when your focus is likely to be strongest.")
                        .foregroundStyle(.secondary)
                        .lineSpacing(4)
                }
                .padding(20)
                .background(Color(.secondarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            .padding(24)
        }
        .navigationTitle("Focus Plan")
        .navigationBarTitleDisplayMode(.inline)
    }
}


// MARK: - Add Task

struct AddTaskView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var taskName = ""
    @State private var priority = "Medium"
    @State private var duration = "30 min"
    
    let priorities = ["Low", "Medium", "High"]
    let durations = ["15 min", "30 min", "45 min", "60 min", "90 min"]
    
    var onAdd: (String) -> Void
    
    var body: some View {
        NavigationStack {
            Form {
                Section("TASK") {
                    TextField("What do you need to do?", text: $taskName)
                }
                
                Section("PRIORITY") {
                    Picker("Priority", selection: $priority) {
                        ForEach(priorities, id: \.self) { priority in
                            Text(priority)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("ESTIMATED TIME") {
                    Picker("Duration", selection: $duration) {
                        ForEach(durations, id: \.self) { duration in
                            Text(duration)
                        }
                    }
                }
            }
            .navigationTitle("New Task")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        if !taskName.isEmpty {
                            onAdd(taskName)
                            dismiss()
                        }
                    }
                    .disabled(taskName.isEmpty)
                }
            }
        }
    }
}


#Preview {
    ContentView()
}
