//
//  ToDoListWorker.swift
//  ToDoListCleanSwift
//
//  Created by Dmitry Serebrov on 03.03.2023.
//

import Foundation
/// Протокол для воркера
protocol IToDoListWorker {
	func getSections() -> [Section]
	func toggleTaskAt(indexPath: IndexPath)
	func getTasksForSection(section: Section) -> [Task]
}

/// Класс воркер обращается к сети чтобы получить данные
class ToDoListWorker: IToDoListWorker {
	private var sectionManager: ISectionForTaskManagerAdapter!

	/// Инициализатор класса
	init(sectionManager: ISectionForTaskManagerAdapter!) {
		self.sectionManager = sectionManager
	}

	/// Метод, который возвращает список секций из сети
	func getSections() -> [Section] {
		return sectionManager.getSections()
	}

	/// Метод, который возвращает список заданий под каждую секцию
	func getTasksForSection(section: Section) -> [Task] {
		return sectionManager.getTasksForSection(section: section)
	}

	/// Метод, который делает изменения в базе данных по выполнению задачи
	func toggleTaskAt(indexPath: IndexPath) {
		let section = sectionManager.getSection(forIndex: indexPath.section)
		let task = sectionManager.getTasksForSection(section: section)[indexPath.row]
		task.completed.toggle()
	}

}
