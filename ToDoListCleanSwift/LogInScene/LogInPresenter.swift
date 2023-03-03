//
//  LogInPresenter.swift
//  ToDoListCleanSwift
//
//  Created by Dmitry Serebrov on 03.03.2023.
//

import Foundation
/// Протокол для презентера
protocol ILoginPresenter {
	func present(responce: LoginModels.Responce)
}

/// Класс презентер получает запрос от интерактора и передает данные во вью
class LoginPresenter: ILoginPresenter {
	private weak var viewController: ILoginViewController?

	/// Инициализатор класса
	init(viewController: ILoginViewController?) {
		self.viewController = viewController
	}

	/// Метод, который передает данные во вью в готовом для презентации виде
	func present(responce: LoginModels.Responce) {
		let viewModel = LoginModels.ViewModel(
			success: responce.success,
			userName: responce.login
		)

		viewController?.render(viewModel: viewModel)
	}
}
