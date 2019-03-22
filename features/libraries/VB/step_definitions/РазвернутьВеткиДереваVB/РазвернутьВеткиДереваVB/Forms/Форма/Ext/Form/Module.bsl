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

	//описание параметров
	//пример вызова Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,Снипет,ИмяПроцедуры,ПредставлениеТеста,Транзакция,Параметр);

	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯРазвернулВсеВеткиДереваVB()","ЯРазвернулВсеВеткиДереваVB","Когда я развернул все ветки дерева VB");

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
Процедура РазвернутьСтрокуДерева(Строка,Элементы_ДеревоТестов)
	ИдентификаторСтроки=Строка.ПолучитьИдентификатор();
	Элементы_ДеревоТестов.Развернуть(ИдентификаторСтроки);
КонецПроцедуры

&НаКлиенте
Процедура СделатьОбходСтрок(Строки,Элементы_ДеревоТестов)
	Для каждого Строка Из Строки Цикл
		РазвернутьСтрокуДерева(Строка,Элементы_ДеревоТестов);

		ПодчиненныеСтроки = Строка.ПолучитьЭлементы();
		СделатьОбходСтрок(ПодчиненныеСтроки,Элементы_ДеревоТестов);
	КонецЦикла;
КонецПроцедуры

&НаКлиенте
//Когда я развернул все ветки дерева VB
//@ЯРазвернулВсеВеткиДереваVB()
Процедура ЯРазвернулВсеВеткиДереваVB() Экспорт
	ДеревоТестовСтроки = Ванесса.Объект.ДеревоТестов.ПолучитьЭлементы();
	Элементы_ДеревоТестов = Ванесса.Элементы.ДеревоТестов;

	СделатьОбходСтрок(ДеревоТестовСтроки,Элементы_ДеревоТестов);
КонецПроцедуры

//окончание текста модуля