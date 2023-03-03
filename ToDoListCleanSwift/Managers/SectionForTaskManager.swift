//
//  SectionForTaskManager.swift
//  ToDoListCleanSwift
//
//  Created by Dmitry Serebrov on 03.03.2023.
//

import Foundation
/// Шаблон проектирования Адаптер
protocol ISectionForTaskManagerAdapter {
	/// Отдает список секций
	func getSections() -> [Section]
	/// Отдает список заданий в секции
	func getTasksForSection(section: Section) -> [Task]
	/// Отдает секцию и индекс задания
	func taskSectionAndIndex(task: Task) -> (section: Section, index: Int)?
	/// Отдает индекс секции
	func getSectionIndex(section: Section) -> Int
	/// Отдает секцию по индексу
	func getSection(forIndex index: Int) -> Section
}

/// Переводит название секции в строку для отображения
enum Section: CaseIterable {
	case completed
	case uncompleted

	var title: String {
		switch self {
		case .completed:
			return "Completed"
		case .uncompleted:
			return "Uncompleted"
		}
	}
}

/// Реализация класса адаптер
final class SectionForTaskManagerAdapter: ISectionForTaskManagerAdapter {

	private let sections: [Section] = [.uncompleted, .completed]

	private let taskManager: ITaskManager

	/// Инициализатор класса
	init(taskManager: ITaskManager) {
		self.taskManager = taskManager
	}

	/// Отдает список секций
	func getSections() -> [Section] {
		sections
	}

	/// Отдает индекс секции
	func getSectionIndex(section: Section) -> Int {
		sections.firstIndex(of: section) ?? 0
	}

	/// Отдает секцию по индексу
	func getSection(forIndex index: Int) -> Section {
		let index = min(index, sections.count - 1)
		return sections[index]
	}

	/// Отдает список заданий в секции
	func getTasksForSection(section: Section) -> [Task] {
		switch section {
		case .completed:
			return taskManager.completedTasks()
		case .uncompleted:
			return taskManager.uncompletedTasks()
		}
	}

	/// Отдает секцию и индекс задания
	func taskSectionAndIndex(task: Task) -> (section: Section, index: Int)? {
		for section in sections {
			let index = getTasksForSection(section: section).firstIndex { task === $0 }
			if index != nil {
				return (section, index!)
			}
		}
		return nil
	}
}
