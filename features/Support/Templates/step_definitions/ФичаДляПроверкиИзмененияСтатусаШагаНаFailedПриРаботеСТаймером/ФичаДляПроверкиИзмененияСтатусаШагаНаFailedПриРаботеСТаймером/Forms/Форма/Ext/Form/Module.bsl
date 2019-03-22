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

	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯПрерываюВыполнениеШаговИПодключаюТаймер(Парам01)","ЯПрерываюВыполнениеШаговИПодключаюТаймер","Когда я прерываю выполнение шагов и подключаю таймер ""СлужебныйТаймер""");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ВторойШагНеДолженВыполнится()","ВторойШагНеДолженВыполнится","Тогда второй шаг не должен выполнится");

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
	Ванесса.ХостСистема.ПродолжитьВыполнениеШагов();
КонецПроцедуры



///////////////////////////////////////////////////
//Реализация шагов
///////////////////////////////////////////////////

&НаКлиенте
Процедура СлужебныйТаймер()
	Ванесса.ПродолжитьВыполнениеШагов(Истина);
КонецПроцедуры

&НаКлиенте
//Когда я прерываю выполнение шагов и подключаю таймер "СлужебныйТаймер"
//@ЯПрерываюВыполнениеШаговИПодключаюТаймер(Парам01)
Процедура ЯПрерываюВыполнениеШаговИПодключаюТаймер(ИмяОбработчика) Экспорт
	Ванесса.ЗапретитьВыполнениеШагов();
	ПодключитьОбработчикОжидания(ИмяОбработчика,1,Истина);
КонецПроцедуры

&НаКлиенте
//Тогда второй шаг не должен выполнится
//@ВторойШагНеДолженВыполнится()
Процедура ВторойШагНеДолженВыполнится() Экспорт
	ВызватьИсключение "Не реализовано.";
КонецПроцедуры

//окончание текста модуля
