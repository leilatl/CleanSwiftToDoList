//
//  LogInWorker.swift
//  ToDoListCleanSwift
//
//  Created by Dmitry Serebrov on 03.03.2023.
//

import Foundation
/// Структура, которая описывает данные получаемые из сети
public struct LoginDTO {
	var success: Int
	var login: String
}

/// Протокол для воркера
protocol ILoginWorker {
	func login(login: String, password: String) -> LoginDTO
}

/// Класс воркер обращается к сети чтобы получить данные
class LoginWorker: ILoginWorker {

	/// Метод логин принимает логин и пароль, отдает их в сеть и получает ответ 
	func login(login: String, password: String) -> LoginDTO {

		if login == "Admin" && password == "pa$$32!" {
			return LoginDTO(
				success: 1,
				login: login
			)
		} else {
			return LoginDTO(
				success: 0,
				login: login
			)
		}
	}

}
