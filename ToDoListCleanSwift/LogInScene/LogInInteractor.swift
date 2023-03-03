//
//  LogInInteractor.swift
//  ToDoListCleanSwift
//
//  Created by Dmitry Serebrov on 03.03.2023.
//

import Foundation
/// Протокол для логин интерактора
protocol ILoginInteractor {
	func login(request: LoginModels.Request)
}

/// Класс интерактор логин сцены
class LoginInteractor: ILoginInteractor {
	private var worker: ILoginWorker
	private var presenter: ILoginPresenter?

	/// Метод инициализации класса
	init(worker: ILoginWorker, presenter: ILoginPresenter) {
		self.worker = worker
		self.presenter = presenter
	}

	/// Метод для запроса списка задач и передачи списка дальше к презентеру
	func login(request: LoginModels.Request) {
		let result = worker.login(login: request.login, password: request.password)

		let responce = LoginModels.Responce(
			success: result.success == 1,
			login: result.login
		)

		presenter?.present(responce: responce)
	}

}
