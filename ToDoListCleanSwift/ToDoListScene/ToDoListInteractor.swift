//
//  ToDoListInteractor.swift
//  ToDoListCleanSwift
//
//  Created by Dmitry Serebrov on 03.03.2023.
//

import Foundation
/// Протокол для интерактора списка задач
protocol IToDoListInteractor {
	func showTasks()
	func didTaskSelected(at indexPath: IndexPath)
}

/// Класс интерактор сцены списка задач
class ToDoListInteractor: IToDoListInteractor {
	private var worker: IToDoListWorker
	private var presenter: IToDoListPresenter?

	/// Метод инициализации класса
	init(worker: IToDoListWorker, presenter: IToDoListPresenter?) {
		self.worker = worker
		self.presenter = presenter
	}

	/// Метод, который получает список задач из воркера и передает их дальше к презентеру
	func showTasks() {
		let tasks = mapViewData()
		presenter?.present(responce: tasks)

	}

	/// Метод, который реагирует на нажатие на ячейку - меняет статус задачи 
	func didTaskSelected(at indexPath: IndexPath) {
		worker.toggleTaskAt(indexPath: indexPath)
		let tasks = mapViewData()
		presenter?.present(responce: tasks)
	}

	private func mapViewData() -> ToDoListModel.Response {
		var sections = [ToDoListModel.Section]()
		for section in worker.getSections() {
			let sectionData = ToDoListModel.Section(
				title: section.title,
				tasks: worker.getTasksForSection(section: section)
			)

			sections.append(sectionData)
		}

		return ToDoListModel.Response(tasksBySections: sections)
	}
}
