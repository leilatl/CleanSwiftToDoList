//
//  LogInModels.swift
//  ToDoListCleanSwift
//
//  Created by Dmitry Serebrov on 03.03.2023.
//

import Foundation
/// Модели, необходимые для общения модулей
enum LoginModels {
	/// Структура реквест используется вью чтобы обратиться к интегратору
	struct Request {
		var login: String
		var password: String
	}

	/// Структура респонс используется интегратором чтобы обратиться к презентору
	struct Responce {
		var success: Bool
		var login: String
	}

	/// Структура вьюмодель используется презентором чтобы обратиться к вью
	struct ViewModel {
		var success: Bool
		var userName: String
	}
}
