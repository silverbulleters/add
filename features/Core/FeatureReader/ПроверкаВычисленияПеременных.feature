﻿# language: ru

Функционал: Автоматическое вычисление выражений при передаче параметров в шаги
	Как Разработчик
	Я Хочу чтобы была простая возможность в любом шаге использовать переменные контекста

Сценарий: Вычисление переменной контекста в обычном параметре-строке
	Когда Я запоминаю строку "Привет" как переменную "ПроверяемаяПеременная"
	Тогда переменная "ПроверяемаяПеременная" имеет значение "Привет"
	Тогда переменная "ПроверяемаяПеременная" имеет значение "$ПроверяемаяПеременная$"
	И выражение внутреннего языка 'Контекст.ПроверяемаяПеременная = "$ПроверяемаяПеременная$"' Истинно
	И выражение внутреннего языка '"Привет" = "$ПроверяемаяПеременная$"' Истинно
	И Я запоминаю значение выражения 'Строка("Привет" = "$ПроверяемаяПеременная$")' в переменную "Утверждение"
	Тогда переменная "Утверждение" имеет значение "Да"

Сценарий: Вычисление сложного выражения с переменными контекста в обычном параметре-строке
	Когда Я запоминаю строку "Привет" как переменную "ПроверяемаяПеременная"
	Когда Я запоминаю строку "$ПроверяемаяПеременная$" как переменную "Другая проверяемая переменная"
	Тогда переменная "Другая проверяемая переменная" имеет значение "$ПроверяемаяПеременная$"
	И выражение внутреннего языка '"$Другая проверяемая переменная$" = "$ПроверяемаяПеременная$"' Истинно
	И выражение внутреннего языка '"$Другая проверяемая переменная$" = "Привет"' Истинно

Сценарий: Вычисление глобальной переменной контекста в обычном параметре-строке
	Когда Я запоминаю строку "Привет" как переменную "ГлобальнаяПроверяемаяПеременная" глобально
	Тогда переменная "ГлобальнаяПроверяемаяПеременная" имеет значение "Привет" глобально
	Тогда переменная "ГлобальнаяПроверяемаяПеременная" имеет значение "$$ГлобальнаяПроверяемаяПеременная$$" глобально
	И выражение внутреннего языка 'КонтекстСохраняемый.ГлобальнаяПроверяемаяПеременная = "$$ГлобальнаяПроверяемаяПеременная$$"' Истинно
	И выражение внутреннего языка '"Привет" = "$$ГлобальнаяПроверяемаяПеременная$$"' Истинно
	И Я запоминаю значение выражения 'Строка("Привет" = "$$ГлобальнаяПроверяемаяПеременная$$")' в переменную "Утверждение"
	Тогда переменная "Утверждение" имеет значение "Да"

Сценарий: Проверки строки с экранированием доллара
	Когда Я запоминаю строку "$$$Привет$$$" как переменную "ПроверяемаяПеременная"
	Тогда переменная "ПроверяемаяПеременная" имеет значение "$$$Привет$$$"
	И затем я выполняю код встроенного языка
	|Контекст.Вставить("БезЭкранирования", СтрДлина("$ПроверяемаяПеременная$"));|
	И переменная "БезЭкранирования" имеет значение 12
	И затем я выполняю код встроенного языка
	"""
		Контекст.Вставить("БезЭкранирования", СтрДлина("$ПроверяемаяПеременная$"));
	"""
	И Я запоминаю значение выражения 'СтрДлина("$ПроверяемаяПеременная$")' в переменную "Результат"
	И переменная "Результат" имеет значение 47

Сценарий: Вычисление переменной контекста, не идентификатор 1С, в обычном параметре-строке с пробелами
	Когда Я запоминаю строку "Привет" как переменную "Проверяемая Переменная"
	Тогда переменная "Проверяемая Переменная" имеет значение "$Проверяемая Переменная$"
	И выражение внутреннего языка 'Ванесса.ПолучитьСохраненноеЗначениеИзКонтекста("Проверяемая Переменная") = "$Проверяемая Переменная$"' Истинно
	И выражение внутреннего языка '"Привет" = "$Проверяемая Переменная$"' Истинно
	И Я запоминаю значение выражения 'Строка("Привет" = "$Проверяемая Переменная$")' в переменную "Утверждение"
	Тогда переменная "Утверждение" имеет значение "Да"
