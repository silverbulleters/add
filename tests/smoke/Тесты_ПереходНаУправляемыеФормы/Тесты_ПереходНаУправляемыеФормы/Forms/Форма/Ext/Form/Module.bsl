﻿#Область ОписаниеПеременных

&НаКлиенте
Перем КонтекстЯдра;
&НаКлиенте
Перем Утверждения;
&НаКлиенте
Перем СтроковыеУтилиты;
&НаКлиенте
Перем ИсключенияИзПроверок;
&НаКлиенте
Перем ОтборПоПрефиксу;
&НаКлиенте
Перем ПрефиксОбъектов;
&НаКлиенте
Перем ВыводитьИсключения;
&НаКлиенте
Перем ПропускатьОбъектыСПрефиксомУдалить;

#КонецОбласти

#Область ИнтерфейсТестирования

&НаКлиенте
Процедура Инициализация(КонтекстЯдраПараметр) Экспорт
	
	КонтекстЯдра = КонтекстЯдраПараметр;
	Утверждения = КонтекстЯдра.Плагин("БазовыеУтверждения");
	СтроковыеУтилиты = КонтекстЯдра.Плагин("СтроковыеУтилиты");
	
	Настройки(КонтекстЯдра, ИмяТеста());
	
КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьНаборТестов(НаборТестов, КонтекстЯдраПараметр) Экспорт
	
	Инициализация(КонтекстЯдраПараметр);
	
	Если Не ВыполнятьТест() Тогда
		Возврат;
	КонецЕсли;
	
	ОбъектыМетаданных = ОбъектыМетаданных(ПрефиксОбъектов, ОтборПоПрефиксу);
	
	Для Каждого ОбъектМетаданных Из ОбъектыМетаданных Цикл
		Если Не ВыводитьИсключения Тогда
			МассивТестов = УбратьИсключения(ОбъектМетаданных.Значение);
		Иначе
			МассивТестов = ОбъектМетаданных.Значение;
		КонецЕсли;
		Если МассивТестов.Количество() = 0 Тогда
			Продолжить;
		КонецЕсли;
		НаборТестов.НачатьГруппу(ОбъектМетаданных.Ключ, Ложь);
		Для Каждого Тест Из МассивТестов Цикл
			НаборТестов.Добавить(
				"ТестДолжен_ПроверитьТипФормы", 
				НаборТестов.ПараметрыТеста(Тест.ПолноеИмя, Тест.ТипФормы), 
				КонтекстЯдра.СтрШаблон_("%1 [Проверка типа формы]", Тест.Имя));	
		КонецЦикла;
	КонецЦикла;
			
КонецПроцедуры

#КонецОбласти

#Область РаботаСНастройками

&НаКлиенте
Процедура Настройки(КонтекстЯдра, Знач ПутьНастройки)

	Если ЗначениеЗаполнено(Объект.Настройки) Тогда
		Возврат;
	КонецЕсли;
	
	ОтборПоПрефиксу = Ложь;
	ПрефиксОбъектов = "";
	ВыводитьИсключения = Истина;
	ПропускатьОбъектыСПрефиксомУдалить = Ложь;
	ИсключенияИзПроверок = Новый Соответствие;
	ПлагинНастроек = КонтекстЯдра.Плагин("Настройки");
	Объект.Настройки = ПлагинНастроек.ПолучитьНастройку(ПутьНастройки);
	Настройки = Объект.Настройки;
	
	Если Не ЗначениеЗаполнено(Настройки) Тогда
		Объект.Настройки = Новый Структура(ПутьНастройки, Неопределено);
		Возврат;
	КонецЕсли;
	
	Если Настройки.Свойство("Префикс") Тогда
		ПрефиксОбъектов = ВРег(Настройки.Префикс);
	КонецЕсли;
	
	Если Настройки.Свойство("ОтборПоПрефиксу") Тогда
		ОтборПоПрефиксу = Настройки.ОтборПоПрефиксу;
	КонецЕсли;
		
	Если Настройки.Свойство("ВыводитьИсключения") Тогда
		ВыводитьИсключения = Настройки.ВыводитьИсключения;
	КонецЕсли;
	
	Если Настройки.Свойство("ПропускатьОбъектыСПрефиксомУдалить") Тогда
		ПропускатьОбъектыСПрефиксомУдалить = Настройки.ПропускатьОбъектыСПрефиксомУдалить;
	КонецЕсли;

	Если Настройки.Свойство("ИсключенияИзпроверок") Тогда
		ИсключенияИзПроверок(Настройки);
	КонецЕсли;
		
КонецПроцедуры

&НаКлиенте
Процедура ИсключенияИзПроверок(Настройки)

	Для Каждого ИсключенияИзПроверокПоОбъектам Из Настройки.ИсключенияИзпроверок Цикл
		Для Каждого ИсключениеИзПроверок Из ИсключенияИзПроверокПоОбъектам.Значение Цикл
			ИсключенияИзПроверок.Вставить(ВРег(ИсключенияИзПроверокПоОбъектам.Ключ + "." + ИсключениеИзПроверок), Истина); 	
		КонецЦикла;
	КонецЦикла;	

КонецПроцедуры

#КонецОбласти

#Область Тесты

&НаКлиенте
Процедура ТестДолжен_ПроверитьТипФормы(ПолноеИмяМетаданных, ТипФормы) Экспорт
	
	ПропускатьТест = ПропускатьТест(ПолноеИмяМетаданных);
	
	Результат = (ТипФормы = "Управляемая");
		
	Если Не Результат И ПропускатьТест.Пропустить Тогда
		Утверждения.ПропуститьТест(ПропускатьТест.ТекстСообщения);
	Иначе
		Утверждения.Проверить(Результат, ТекстСообщения(ПолноеИмяМетаданных));
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Функция ПропускатьТест(ПолноеИмяМетаданных)

	Результат = Новый Структура;
	Результат.Вставить("ТекстСообщения", "");
	Результат.Вставить("Пропустить", Ложь);
	МассивСтрокИмени = СтроковыеУтилиты.РазложитьСтрокуВМассивПодстрок(ПолноеИмяМетаданных, ".");
	ИслючениеВсехОбъектов = СтроковыеУтилиты.ПодставитьПараметрыВСтроку("%1.*", МассивСтрокИмени[0]);
	
	Если ИсключенИзПроверок(ПолноеИмяМетаданных) Тогда
		ШаблонСообшения = НСтр("ru = 'Объект ""%1"" исключен из проверки'");
		Результат.ТекстСообщения = СтроковыеУтилиты.ПодставитьПараметрыВСтроку(ШаблонСообшения, ПолноеИмяМетаданных);
		Результат.Пропустить = Истина;
		Возврат Результат;
	КонецЕсли;
	
	Если ПропускатьОбъектыСПрефиксомУдалить = Истина И СтрНайти(ВРег(ПолноеИмяМетаданных), ".УДАЛИТЬ") > 0 Тогда
		ШаблонСообшения = НСтр("ru = 'Объект ""%1"" исключен из проверки, префикс ""Удалить""'");
		Результат.ТекстСообщения = СтроковыеУтилиты.ПодставитьПараметрыВСтроку(ШаблонСообшения, ПолноеИмяМетаданных);
		Результат.Пропустить = Истина;
		Возврат Результат;
	КонецЕсли;
			
	Возврат Результат;

КонецФункции 

&НаКлиенте
Функция ИсключенИзПроверок(ПолноеИмяМетаданных)
	
	Результат = Ложь;
	МассивСтрокИмени = СтроковыеУтилиты.РазложитьСтрокуВМассивПодстрок(ПолноеИмяМетаданных, ".");
	ИслючениеВсехОбъектов = СтроковыеУтилиты.ПодставитьПараметрыВСтроку("%1.*", МассивСтрокИмени[0]);
	
	Если ИсключенияИзПроверок.Получить(ВРег(ПолноеИмяМетаданных)) <> Неопределено
	 Или ИсключенияИзПроверок.Получить(ВРег(ИслючениеВсехОбъектов)) <> Неопределено Тогда
		Результат = Истина;	
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

&НаКлиенте
Функция УбратьИсключения(МассивТестов)

	Исключения = Новый Соответствие;
	Результат = Новый Массив;
	
	Для Каждого Тест Из МассивТестов Цикл
		Если ИсключенИзПроверок(Тест.ПолноеИмя) Тогда
			Исключения.Вставить(Тест, Истина);
		КонецЕсли;	
	КонецЦикла;
	
	Для Каждого Тест Из МассивТестов Цикл
 		Если Исключения.Получить(Тест) = Истина Тогда
			Продолжить;
		КонецЕсли;
		Результат.Добавить(Тест);
	КонецЦикла;
	
	Возврат Результат;

КонецФункции

&НаКлиенте
Функция ТекстСообщения(ПолноеИмяМетаданных)

	ШаблонСообщения = НСтр("ru = 'Форма ""%1"" не управляемая'");
	ТекстСообщения = СтроковыеУтилиты.ПодставитьПараметрыВСтроку(ШаблонСообщения, ПолноеИмяМетаданных);
	
	Возврат ТекстСообщения;

КонецФункции

&НаСервереБезКонтекста
Функция ОбъектыМетаданных(ПрефиксОбъектов, ОтборПоПрефиксу)
	
	ОбъектыМетаданных = Новый Структура;
		
	ОбъектыМетаданных.Вставить("ПланыОбмена", Новый Массив);
	ОбъектыМетаданных.Вставить("КритерииОтбора", Новый Массив);
	ОбъектыМетаданных.Вставить("ХранилищаНастроек", Новый Массив);
	ОбъектыМетаданных.Вставить("ОбщиеФормы", Новый Массив);
	ОбъектыМетаданных.Вставить("Константы", Новый Массив);
	ОбъектыМетаданных.Вставить("Документы", Новый Массив);
	ОбъектыМетаданных.Вставить("Справочники", Новый Массив);
	ОбъектыМетаданных.Вставить("ЖурналыДокументов", Новый Массив);
	ОбъектыМетаданных.Вставить("Перечисления", Новый Массив);
	ОбъектыМетаданных.Вставить("ПланыВидовХарактеристик", Новый Массив);
	ОбъектыМетаданных.Вставить("ПланыСчетов", Новый Массив);
	ОбъектыМетаданных.Вставить("ПланыВидовРасчета", Новый Массив);
	ОбъектыМетаданных.Вставить("Отчеты", Новый Массив);
	ОбъектыМетаданных.Вставить("Обработки", Новый Массив);
	ОбъектыМетаданных.Вставить("РегистрыСведений", Новый Массив);
	ОбъектыМетаданных.Вставить("РегистрыНакопления", Новый Массив);
	ОбъектыМетаданных.Вставить("РегистрыБухгалтерии", Новый Массив);
	ОбъектыМетаданных.Вставить("РегистрыРасчета", Новый Массив);
	ОбъектыМетаданных.Вставить("БизнесПроцессы", Новый Массив);
	ОбъектыМетаданных.Вставить("Задачи", Новый Массив);
	
	СтроковыеУтилиты = СтроковыеУтилиты();
	
	Для Каждого Элемент Из ОбъектыМетаданных Цикл
		Для Каждого ОбъектМетаданных Из Метаданные[Элемент.Ключ] Цикл
			
			Если ОтборПоПрефиксу И Не ИмяСодержитПрефикс(ОбъектМетаданных.Имя, ПрефиксОбъектов) Тогда
				Продолжить;
			КонецЕсли;
			
			Если ЕстьРеквизитИлиСвойствоОбъекта(ОбъектМетаданных, "ТипФормы") Тогда
				ДобавитьЭлементКоллекцииОбъектовМетаданных(
					ОбъектыМетаданных[Элемент.Ключ], 
					ОбъектМетаданных.Имя, 
					ОбъектМетаданных.ПолноеИмя(),
					Строка(ОбъектМетаданных.ТипФормы));
				Продолжить;	
			КонецЕсли;
			
			Если Не ЕстьРеквизитИлиСвойствоОбъекта(ОбъектМетаданных, "Формы") Тогда
				Продолжить;	
			КонецЕсли;
			
			Для Каждого Форма Из ОбъектМетаданных.Формы Цикл
				ДобавитьЭлементКоллекцииОбъектовМетаданных(
					ОбъектыМетаданных[Элемент.Ключ], 
					Форма.ПолноеИмя(), 
					Форма.ПолноеИмя(),
					Строка(Форма.ТипФормы));	
			КонецЦикла;
						
		КонецЦикла;
	КонецЦикла;
	
	Возврат ОбъектыМетаданных;

КонецФункции

&НаСервереБезКонтекста
Процедура ДобавитьЭлементКоллекцииОбъектовМетаданных(Коллекция, Имя, ПолноеИмя, ТипФормы)

	СтруктураЭлемента = Новый Структура;
	СтруктураЭлемента.Вставить("Имя", Имя);
	СтруктураЭлемента.Вставить("ПолноеИмя", ПолноеИмя);
	СтруктураЭлемента.Вставить("ТипФормы", ТипФормы);
	Коллекция.Добавить(СтруктураЭлемента);

КонецПроцедуры 

&НаКлиентеНаСервереБезКонтекста
Функция ЕстьРеквизитИлиСвойствоОбъекта(Объект, ИмяРеквизита) Экспорт
	
	КлючУникальности   = Новый УникальныйИдентификатор;
	СтруктураРеквизита = Новый Структура(ИмяРеквизита, КлючУникальности);
	ЗаполнитьЗначенияСвойств(СтруктураРеквизита, Объект);
	
	Возврат СтруктураРеквизита[ИмяРеквизита] <> КлючУникальности;
	
КонецФункции

&НаКлиентеНаСервереБезКонтекста
Функция ИмяСодержитПрефикс(Имя, Префикс)
	
	Если Не ЗначениеЗаполнено(Префикс) Тогда
		Возврат Ложь;
	КонецЕсли;
	
	ДлинаПрефикса = СтрДлина(Префикс);
	Возврат СтрНайти(ВРег(Лев(Имя, ДлинаПрефикса)), Префикс) > 0;
	
КонецФункции

&НаСервереБезКонтекста
Функция СтроковыеУтилиты()
	Возврат ВнешниеОбработки.Создать("СтроковыеУтилиты");	
КонецФункции 

&НаКлиенте
Функция ИмяТеста()
	
	Если Не ЗначениеЗаполнено(Объект.ИмяТеста) Тогда
		Объект.ИмяТеста = ИмяТестаНаСервере();
	КонецЕсли;
	
	Возврат Объект.Имятеста;
	
КонецФункции

&НаСервере
Функция ИмяТестаНаСервере()
	Возврат РеквизитФормыВЗначение("Объект").Метаданные().Имя;
КонецФункции

&НаКлиенте
Функция ВыполнятьТест()
	
	ВыполнятьТест = Истина;
	Настройки(КонтекстЯдра, ИмяТеста());
	Настройки = Объект.Настройки;
	
	Если Не ЗначениеЗаполнено(Настройки) Тогда
		Возврат ВыполнятьТест;
	КонецЕсли;
		
	Если ТипЗнч(Настройки) = Тип("Структура") И Настройки.Свойство("Используется") Тогда
		ВыполнятьТест = Настройки.Используется;	
	КонецЕсли;
	
	Возврат ВыполнятьТест;

КонецФункции

#КонецОбласти