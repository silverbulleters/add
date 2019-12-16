﻿//начало текста модуля

///////////////////////////////////////////////////
//Служебные функции и процедуры
///////////////////////////////////////////////////

&НаКлиенте
// контекст фреймворка Vanessa-ADD
Перем Ванесса;

&НаКлиенте
// Структура, в которой хранится состояние сценария между выполнением шагов. Очищается перед выполнением каждого сценария.
Перем Контекст Экспорт;

&НаКлиенте
// Структура, в которой можно хранить служебные данные между запусками сценариев. Существует, пока открыта форма Vanessa-ADD.
Перем КонтекстСохраняемый Экспорт;

&НаКлиенте
// Функция экспортирует список шагов, которые реализованы в данной внешней обработке.
Функция ПолучитьСписокТестов(КонтекстФреймворкаBDD) Экспорт
	Ванесса = КонтекстФреймворкаBDD;

	ВсеТесты = Новый Массив;

	// описание шагов
	// пример вызова Ванесса.ДобавитьШагВМассивТестов(ВсеТесты, Снипет, ИмяПроцедуры, ПредставлениеТеста, ОписаниеШага, ТипШагаДляОписания, ТипШагаВДереве);

	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯУстановилВКонтекстСохраняемыйЗначениеРавное(Парам01,Парам02)","ЯУстановилВКонтекстСохраняемыйЗначениеРавное","И я установил в КонтекстСохраняемый значение ""СлужебнаяПеременная"" равное 0","","");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ВКонтекстСохраняемыйЕстьЗначениеРавное(Парам01,Парам02)","ВКонтекстСохраняемыйЕстьЗначениеРавное","Тогда В КонтекстСохраняемый есть значение ""СлужебнаяПеременная"" равное 6","","");

	Возврат ВсеТесты;
КонецФункции

&НаСервере
// Служебная функция.
Функция ПолучитьМакетСервер(ИмяМакета)
	ОбъектСервер = РеквизитФормыВЗначение("Объект");
	Возврат ОбъектСервер.ПолучитьМакет(ИмяМакета);
КонецФункции

&НаКлиенте
// Служебная функция для подключения библиотеки создания fixtures.
Функция ПолучитьМакетОбработки(ИмяМакета) Экспорт
	Возврат ПолучитьМакетСервер(ИмяМакета);
КонецФункции



///////////////////////////////////////////////////
//Работа со сценариями
///////////////////////////////////////////////////

&НаКлиенте
// Процедура выполняется перед началом каждого сценария
Процедура ПередНачаломСценария() Экспорт

КонецПроцедуры

&НаКлиенте
// Процедура выполняется перед окончанием каждого сценария
Процедура ПередОкончаниемСценария() Экспорт

КонецПроцедуры



///////////////////////////////////////////////////
//Реализация шагов
///////////////////////////////////////////////////

&НаКлиенте
//И я установил в КонтекстСохраняемый значение "СлужебнаяПеременная" равное 0
//@ЯУстановилВКонтекстСохраняемыйЗначениеРавное(Парам01,Парам02)
Процедура ЯУстановилВКонтекстСохраняемыйЗначениеРавное(ИмяПеременной,Значение) Экспорт
	КонтекстСохраняемый.Вставить(ИмяПеременной,Значение);
КонецПроцедуры

&НаКлиенте
//Тогда В КонтекстСохраняемый есть значение "СлужебнаяПеременная" равное 6
//@ВКонтекстСохраняемыйЕстьЗначениеРавное(Парам01,Парам02)
Процедура ВКонтекстСохраняемыйЕстьЗначениеРавное(ИмяПеременной,Значение) Экспорт
	Если КонтекстСохраняемый[ИмяПеременной] <> Значение Тогда
		ВызватьИсключение "Ожидали в КонтекстСохраняемый в переменной <" + ИмяПеременной + "> значение <" + Значение + ">, а получили <" + КонтекстСохраняемый[ИмяПеременной] + ">";
	КонецЕсли;
КонецПроцедуры

//окончание текста модуля