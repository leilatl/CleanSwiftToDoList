//
//  TaskManager.swift
//  ToDoListCleanSwift
//
//  Created by Dmitry Serebrov on 03.03.2023.
//

import Foundation
/// Предоставляет список заданий.
final class TaskManager {
	private var taskList = [Task]()

	/// Отдает список всех заданий
	public func allTasks() -> [Task] {
		taskList
	}

	/// Отдает список выполненных заданий
	public func completedTasks() -> [Task] {
		taskList.filter { $0.completed }
	}

	/// Отдает список невыполненных заданий
	public func uncompletedTasks() -> [Task] {
		taskList.filter { !$0.completed }
	}

	/// Добавляет переданное задание к списку заданий
	public func addTask(task: Task) {
		taskList.append(task)
	}

	/// Добавляет переданный массив заданий к списку заданий
	public func addTasks(tasks: [Task]) {
		taskList.append(contentsOf: tasks)
	}

	/// Удаляет переданное задание из списка заданий
	public func removeTask(task: Task) {
		taskList.removeAll { $0 === task }
	}
}
