﻿
Перем ИмяПараметраТЧ;
Перем СтруктураПредставленияСтроки;

// { Plugin interface
Функция ОписаниеПлагина(ВозможныеТипыПлагинов) Экспорт
	
	Результат = Новый Структура;
	Результат.Вставить("Тип", ВозможныеТипыПлагинов.Утилита);
	Результат.Вставить("Идентификатор", "Данные");
	Результат.Вставить("Представление", "Данные");
	
	Возврат Новый ФиксированнаяСтруктура(Результат);
	
КонецФункции

Процедура Инициализация(КонтекстЯдраПараметр) Экспорт
КонецПроцедуры

// } Plugin interface

#Область ПрограммныйИнтерфейс_v2

Функция НачатьСоздание(ИмяМетаданных) Экспорт

	ПараметрыМетаданныхСлужебный = ПараметрыМетаданныхИзПолногоИмени(ИмяМетаданных);
	
	ИмяМетаданныхСлужебный = ИмяМетаданных;
	ПараметрыОбъектаСлужебный = Новый Структура;
	
	Возврат ЭтотОбъект;

КонецФункции

Функция Реквизит(ИмяРеквизита, Значение = Неопределено) Экспорт

	ПараметрыОбъектаСлужебный.Вставить(ИмяРеквизита, Значение);
	Возврат ЭтотОбъект;

КонецФункции

Функция ШапкаТабличнойЧасти(ИмяТабличнойЧасти,
							Колонка1 = Неопределено,
							Колонка2 = Неопределено,
							Колонка3 = Неопределено,
							Колонка4 = Неопределено,
							Колонка5 = Неопределено,
							Колонка6 = Неопределено,
							Колонка7 = Неопределено,
							Колонка8 = Неопределено,
							Колонка9 = Неопределено,
							Колонка10 = Неопределено) Экспорт
	
	
	НачатьВводТабличнойЧасти(ПараметрыОбъектаСлужебный, ИмяТабличнойЧасти,
													Колонка1,
													Колонка2,
													Колонка3,
													Колонка4,
													Колонка5,
													Колонка6,
													Колонка7,
													Колонка8,
													Колонка9,
													Колонка10);
													
	Возврат ЭтотОбъект;													

КонецФункции 

Функция ТаблицаЗначений(ИмяТЧ) Экспорт

	Если НЕ ПараметрыОбъектаСлужебный.Свойство("ТЧ_"+ИмяТЧ) Тогда
		ВызватьИсключение "Не найдена табличная часть "+ИмяТЧ;
	КонецЕсли; 
	
	Результат = Новый ТаблицаЗначений;
	Для каждого КолонкаТаблица Из СтруктураПредставленияСтроки Цикл
		Результат.Колонки.Добавить(КолонкаТаблица);
	КонецЦикла;
	
	Для каждого СтрокаТЧ Из ПараметрыОбъектаСлужебный["ТЧ_" + ИмяТЧ] Цикл
		ЗаполнитьЗначенияСвойств(Результат.Добавить(), СтрокаТЧ);
	КонецЦикла;
	
	Возврат Результат;

КонецФункции 

Функция СтрокаТЧ(Параметр0
				,Параметр1 = Неопределено
				,Параметр2 = Неопределено
				,Параметр3 = Неопределено
				,Параметр4 = Неопределено
				,Параметр5 = Неопределено
				,Параметр6 = Неопределено
				,Параметр7 = Неопределено
				,Параметр8 = Неопределено
				,Параметр9 = Неопределено) Экспорт

	ПредставлениеСтроки = Новый Структура;
	Для й = 0 По СтруктураПредставленияСтроки.Количество()-1 Цикл
		Выполнить("ПредставлениеСтроки.Вставить(СтруктураПредставленияСтроки["+й+"], Параметр"+й+")");
	КонецЦикла;
	
	ПараметрыОбъектаСлужебный[ИмяПараметраТЧ].Добавить(ПредставлениеСтроки);
	
	Возврат ЭтотОбъект;

КонецФункции 

Функция Создать() Экспорт

	Возврат СоздатьОбъект(Неопределено, ПараметрыОбъектаСлужебный);	

КонецФункции

Функция ШапкаНабора(Параметр0
					,Параметр1 = Неопределено
					,Параметр2 = Неопределено
					,Параметр3 = Неопределено
					,Параметр4 = Неопределено
					,Параметр5 = Неопределено
					,Параметр6 = Неопределено
					,Параметр7 = Неопределено
					,Параметр8 = Неопределено
					,Параметр9 = Неопределено) Экспорт


	НачатьВводНабораЗаписей(ПараметрыОбъектаСлужебный,Параметр0,
													Параметр1,
													Параметр2,
													Параметр3,
													Параметр4,
													Параметр5,
													Параметр6,
													Параметр7,
													Параметр8,
													Параметр9); 		

	Возврат ЭтотОбъект;
	
КонецФункции 

Функция ЗаписьНабора(Параметр0
					,Параметр1 = Неопределено
					,Параметр2 = Неопределено
					,Параметр3 = Неопределено
					,Параметр4 = Неопределено
					,Параметр5 = Неопределено
					,Параметр6 = Неопределено
					,Параметр7 = Неопределено
					,Параметр8 = Неопределено
					,Параметр9 = Неопределено) Экспорт

	СтрокаТЧ(Параметр0,
			Параметр1,
			Параметр2,
			Параметр3,
			Параметр4,
			Параметр5,
			Параметр6,
			Параметр7,
			Параметр8,
			Параметр9);
	
	Возврат ЭтотОбъект;													
													
КонецФункции 

#КонецОбласти

#Область ПрограммныйИнтерфейс_v1

Функция СоздатьПланОбмена(ИмяПланаОбмена, ПараметрыЭлемента = Неопределено) Экспорт

	Если ПараметрыЭлемента = Неопределено Тогда
		ПараметрыЭлемента = Новый Структура;	
	КонецЕсли; 
	
	ВыполнитьАвтозаполнениеПараметров("ПланОбмена", ИмяПланаОбмена, ПараметрыЭлемента);
	
	Элемент = ПланыОбмена[ИмяПланаОбмена].СоздатьУзел();
	ЗаполнитьЗначенияСвойств(Элемент, ПараметрыЭлемента);

	Элемент.Наименование = ?(Элемент.Наименование = "", ИмяПланаОбмена + "_" + Строка(Новый УникальныйИдентификатор), Элемент.Наименование);
	Элемент.ОбменДанными.Загрузка = Истина;
	Элемент.Код = Строка(Новый УникальныйИдентификатор);
	Элемент.Записать();
	
	Возврат Элемент.Ссылка;

КонецФункции 

Функция СоздатьЭлементСправочника(ИмяСправочника, ПараметрыЭлемента = Неопределено) Экспорт

	Если ПараметрыЭлемента = Неопределено Тогда
		ПараметрыЭлемента = Новый Структура;	
	КонецЕсли; 
	
	ВыполнитьАвтозаполнениеПараметров("Справочник", ИмяСправочника, ПараметрыЭлемента);
	
	Элемент = Справочники[ИмяСправочника].СоздатьЭлемент();	
	ЗаполнитьЗначенияСвойств(Элемент, ПараметрыЭлемента);
	
	ЗаполнитьТабличнуюЧасть(Элемент, Неопределено, ПараметрыЭлемента);
	
	Элемент.Наименование = ?(Элемент.Наименование = "", ИмяСправочника + "_" + Строка(Новый УникальныйИдентификатор), Элемент.Наименование);
	Элемент.ОбменДанными.Загрузка = Истина;
	Элемент.Записать();
	
	Возврат Элемент.Ссылка;
	
КонецФункции

Функция СоздатьДокумент(ИмяДокумента, ПараметрыДокумента = Неопределено, ОбработчикиСтрокТЧ = Неопределено) Экспорт

	Если ПараметрыДокумента = Неопределено Тогда
		ПараметрыДокумента = Новый Структура;	
	КонецЕсли; 
	
	ВыполнитьАвтозаполнениеПараметров("Документ", ИмяДокумента, ПараметрыДокумента);
	
	Документ = Документы[ИмяДокумента].СоздатьДокумент();	
	Документ.Дата = ТекущаяДата();
	Документ.УстановитьНовыйНомер();
	
	ЗаполнитьЗначенияСвойств(Документ, ПараметрыДокумента);
	
	ЗаполнитьТабличнуюЧасть(Документ, ОбработчикиСтрокТЧ, ПараметрыДокумента);
	
	Документ.ОбменДанными.Загрузка = Истина;
	Документ.Записать();
	
	Возврат Документ.Ссылка;
	
КонецФункции

Функция НачатьВводТабличнойЧасти(ПараметрыОбъекта, ИмяТабличнойЧасти
													,Параметр0
													,Параметр1 = Неопределено
													,Параметр2 = Неопределено
													,Параметр3 = Неопределено
													,Параметр4 = Неопределено
													,Параметр5 = Неопределено
													,Параметр6 = Неопределено
													,Параметр7 = Неопределено
													,Параметр8 = Неопределено
													,Параметр9 = Неопределено) Экспорт
	
	ИмяПараметраТЧ = "ТЧ_"+ИмяТабличнойЧасти;												
	Если НЕ ПараметрыОбъекта.Свойство(ИмяПараметраТЧ) Тогда
		ПараметрыОбъекта.Вставить(ИмяПараметраТЧ, Новый Массив);	
	КонецЕсли; 
	
	СтруктураПредставленияСтроки = Новый Массив;
	Для й = 0 По 9 Цикл
		
		Командлет = "
		|Если ЗначениеЗаполнено(Параметр"+й+") Тогда
		|	СтруктураПредставленияСтроки.Добавить(Параметр"+й+");		
		|КонецЕсли;"; 	
		
		Выполнить(Командлет);
		
	КонецЦикла; 
	
	ПараметрыОбъектаСлужебный = ПараметрыОбъекта;
	Возврат ЭтотОбъект;
	
КонецФункции 

Функция НачатьВводНабораЗаписей(ПараметрыОбъекта 
												,Параметр0
												,Параметр1 = Неопределено
												,Параметр2 = Неопределено
												,Параметр3 = Неопределено
												,Параметр4 = Неопределено
												,Параметр5 = Неопределено
												,Параметр6 = Неопределено
												,Параметр7 = Неопределено
												,Параметр8 = Неопределено
												,Параметр9 = Неопределено) Экспорт


	ИмяПараметраТЧ = "ЭтотОбъект";												
	Если НЕ ПараметрыОбъекта.Свойство(ИмяПараметраТЧ) Тогда
		ПараметрыОбъекта.Вставить(ИмяПараметраТЧ, Новый Массив);	
	КонецЕсли; 
	
	СтруктураПредставленияСтроки = Новый Массив;
	Для й = 0 По 9 Цикл
		
		Командлет = "
		|Если ЗначениеЗаполнено(Параметр"+й+") Тогда
		|	СтруктураПредставленияСтроки.Добавить(Параметр"+й+");		
		|КонецЕсли;"; 	
		
		Выполнить(Командлет);
		
	КонецЦикла; 
	
	ПараметрыОбъектаСлужебный = ПараметрыОбъекта;
	Возврат ЭтотОбъект;

КонецФункции 

Функция СтрокаНабора(ПараметрыОбъекта, Параметры) Экспорт

	Если НЕ ПараметрыОбъекта.Свойство("ЭтотОбъект") Тогда
		ПараметрыОбъекта.Вставить("ЭтотОбъект", Новый Массив);	
	КонецЕсли;	
	
	ПараметрыОбъекта.ЭтотОбъект.Добавить(Параметры);
	
	Возврат ЭтотОбъект;

КонецФункции 

Функция СоздатьНаборЗаписей(ТипМетаданных, ИмяМетаданных, Параметры = Неопределено, ОчищатьРегистр = Истина) Экспорт

	Перем Набор;
	
	 Выполнить("Набор = " + ТипМетаданных + "." + ИмяМетаданных + ".СоздатьНаборЗаписей()");	
	
	ГлобальныеПараметры = Новый Структура;
	Для каждого КлючЗначение Из Параметры Цикл
	
		Если КлючЗначение.Ключ = "ЭтотОбъект"
			ИЛИ КлючЗначение.Ключ = "Регистратор" Тогда
			
			Продолжить;
		КонецЕсли; 	
		
		Если СтрНайти(КлючЗначение.Ключ, "_Отбор") > 0 Тогда
			ИмяПараметра = СтрЗаменить(КлючЗначение.Ключ, "_Отбор", "");
			ГлобальныеПараметры.Вставить(ИмяПараметра, КлючЗначение.Значение);
			Набор.Отбор[ИмяПараметра].Установить(КлючЗначение.Значение);		
		КонецЕсли; 
		
		Если СтрНайти(КлючЗначение.Ключ, "_Отбор") = 0 Тогда
			ГлобальныеПараметры.Вставить(КлючЗначение.Ключ, КлючЗначение.Значение);
		КонецЕсли;
		
	КонецЦикла; 
		
	Если Параметры.Свойство("ЭтотОбъект") Тогда
		Для каждого СтрокаНабора Из Параметры.ЭтотОбъект Цикл
			Запись = Набор.Добавить();
			ЗаполнитьЗначенияСвойств(Запись, ГлобальныеПараметры);
			ЗаполнитьЗначенияСвойств(Запись, СтрокаНабора);
		КонецЦикла; 
	КонецЕсли; 
	
	Набор.ОбменДанными.Загрузка = Истина;
	Набор.Записать();
	
	Возврат Набор;	

КонецФункции 

Функция СоздатьПланВидовХарактеристик(ИмяМетаданных, ПараметрыЭлемента = Неопределено) Экспорт

	Если ПараметрыЭлемента = Неопределено Тогда
		ПараметрыЭлемента = Новый Структура;	
	КонецЕсли; 
	
	ВыполнитьАвтозаполнениеПараметров("ПланВидовХарактеристик", ИмяМетаданных, ПараметрыЭлемента);
	
	Элемент = ПланыВидовХарактеристик[ИмяМетаданных].СоздатьЭлемент();	
	ЗаполнитьЗначенияСвойств(Элемент, ПараметрыЭлемента);
	
	ЗаполнитьТабличнуюЧасть(Элемент, Неопределено, ПараметрыЭлемента);
	
	Элемент.Наименование = ?(Элемент.Наименование = "", ИмяМетаданных + "_" + Строка(Новый УникальныйИдентификатор), Элемент.Наименование);
	Элемент.ОбменДанными.Загрузка = Истина;
	Элемент.Записать();
	
	Возврат Элемент.Ссылка;

КонецФункции 

#КонецОбласти

#Область СлужебныеПроцедурыФункции

Функция СоздатьОбъект(ИмяМетаданных, Параметры = Неопределено)

	Перем Объект;
	
	Если Не ИмяМетаданных = Неопределено Тогда
		ПараметрыМетаданных = ПараметрыМетаданныхИзПолногоИмени(ИмяМетаданных);
	Иначе
		ПараметрыМетаданных = ПараметрыМетаданныхСлужебный;
	КонецЕсли; 
	
	ТипМетаданных = ПараметрыМетаданных.ТипМетаданных;
	ИмяМетаданных = ПараметрыМетаданных.ИмяМетаданных;
	
	Если ТипМетаданных = "ПланыОбмена" Тогда
		Объект = СоздатьПланОбмена(ИмяМетаданных, Параметры).ПолучитьОбъект();
	ИначеЕсли ТипМетаданных = "Справочники" Тогда
		Объект = СоздатьЭлементСправочника(ИмяМетаданных, Параметры).ПолучитьОбъект();
	ИначеЕсли ТипМетаданных = "Документы" Тогда
		Объект = СоздатьДокумент(ИмяМетаданных, Параметры).ПолучитьОбъект();
	ИначеЕсли ТипМетаданных = "РегистрыНакопления" Тогда
		Объект = СоздатьНаборЗаписей(ТипМетаданных, ИмяМетаданных, Параметры);
	ИначеЕсли ТипМетаданных = "РегистрыСведений" Тогда
		Объект = СоздатьНаборЗаписей(ТипМетаданных, ИмяМетаданных, Параметры);
	ИначеЕсли ТипМетаданных = "ПланыВидовХарактеристик" Тогда
		Объект = СоздатьПланВидовХарактеристик(ИмяМетаданных, Параметры);	
	КонецЕсли; 	
	
	Возврат Объект;

КонецФункции

Функция ПараметрыМетаданныхИзПолногоИмени(ИмяМетаданных)
	
	Параметры = Новый Структура;
	Параметры.Вставить("ТипМетаданных");
	Параметры.Вставить("ИмяМетаданных");
	
	ПараметерыТипа = СтрРазделить(ИмяМетаданных, ".");
	Если ПараметерыТипа.Количество() <> 2 Тогда
		ВызватьИсключение "Наименование метаданных не соответсвует шаблону [ТипМетаданных].[ИмяМетаданных]";
	КонецЕсли; 

	Параметры.ТипМетаданных = ИмяМетаданныхПолномеИмя()[ПараметерыТипа[0]];
	Параметры.ИмяМетаданных = ПараметерыТипа[1];
	
	// TODO проверка на корректность ввода
	Возврат Параметры;

КонецФункции

Процедура СтрокаТабличнойЧасти(ПараметрыОбъекта, ИмяТабличнойЧасти, Параметры = Неопределено)

	Если НЕ Параметры.Свойство(ИмяТабличнойЧасти) Тогда
		ПараметрыОбъекта.Вставить(ИмяТабличнойЧасти, Новый Массив);	
	КонецЕсли; 
	
	СтрокаТЧ = ПараметрыОбъекта[ИмяТабличнойЧасти].Добавить(Параметры);
		
	//Если параметр = неопределено, то создать объект

КонецПроцедуры 

Процедура ЗаполнитьТабличнуюЧасть(Документ, ОбработчикиСтрокТЧ, ПараметрыДокумента)
	
	Перем ИмяТЧ, КлючЗначение, НоваяСтрока, Параметр, ПредставлениеСтроки;
	
	Для каждого Параметр Из ПараметрыДокумента Цикл
		
		Если НЕ СтрНачинаетсяС(Параметр.Ключ, "ТЧ_") Тогда
			Продолжить;
		КонецЕсли; 
		
		ИмяТЧ = СтрЗаменить(Параметр.Ключ, "ТЧ_", "");
		Для каждого ПредставлениеСтроки Из ПараметрыДокумента[Параметр.Ключ] Цикл
			НоваяСтрока = Документ[ИмяТЧ].Добавить();
			ЗаполнитьЗначенияСвойств(НоваяСтрока, ПредставлениеСтроки);
			
			Если ОбработчикиСтрокТЧ <> Неопределено Тогда
				Для каждого КлючЗначение Из ОбработчикиСтрокТЧ Цикл
					Если КлючЗначение.Ключ = "ТекущаяСтрока" Тогда
						КлючЗначение.Значение = НоваяСтрока;	
					КонецЕсли; 
					ВыполнитьМетодКонфигурации(КлючЗначение.Ключ, КлючЗначение.Значение, Ложь); 
				КонецЦикла; 
			КонецЕсли; 
			
		КонецЦикла; 
		
	КонецЦикла;

КонецПроцедуры

Процедура ВыполнитьАвтозаполнениеПараметров(Знач ТипОбъекта, ИмяСправочника, ПараметрыЭлемента) 
	
	ТипОбъекта = ИмяМетаданныхПолномеИмя()[ТипОбъекта];
	
	Для каждого КлючЗначение Из ПараметрыЭлемента Цикл
		Если КлючЗначение.Значение = Неопределено Тогда
			ПараметрыЭлемента[КлючЗначение.Ключ] = ЗначениеРеквизитаПоТипу(ТипОбъекта, ИмяСправочника, КлючЗначение.Ключ);	
		КонецЕсли; 
	КонецЦикла;

КонецПроцедуры

Функция ЗначениеРеквизитаПоТипу(ТипОбъекта, ИмяОбъекта, ИмяРеквизита)

	Реквизиты = Метаданные[ТипОбъекта][ИмяОбъекта].Реквизиты;
	
	Типы = Реквизиты[ИмяРеквизита].Тип.Типы();
	Если Типы.Количество() > 1 Тогда
		ВызватьИсключение "Автозаполнение не поддерживается в составных типах";
	КонецЕсли; 
	
	Тип = Метаданные.НайтиПоТипу(Типы[0]).ПолноеИмя();
	ЗначениеРеквизита = СоздатьОбъект(Тип);
	Возврат ЗначениеРеквизита.Ссылка;

КонецФункции 

Функция ИмяМетаданныхПолномеИмя()

	Параметры = Новый Соответствие;
	Параметры.Вставить("Документы", "Документы");
	Параметры.Вставить("Документ", "Документы");
	
	Параметры.Вставить("Справочники", "Справочники");
	Параметры.Вставить("Справочник", "Справочники");
	
	Параметры.Вставить("ПланыОбмена", "ПланыОбмена");
	Параметры.Вставить("ПланОбмена", "ПланыОбмен");
	
	Параметры.Вставить("РегистрыНакопления", "РегистрыНакопления");
	Параметры.Вставить("РегистрНакопления", "РегистрыНакопления");

	Параметры.Вставить("РегистрыСведений", "РегистрыСведений");
	Параметры.Вставить("РегистрСведений", "РегистрыСведений");
	
	Параметры.Вставить("ПланыВидовХарактеристик", "ПланыВидовХарактеристик");
	Параметры.Вставить("ПланВидовХарактеристик", "ПланыВидовХарактеристик");
	
	Возврат Параметры;

КонецФункции 

// Параметры:
//  Метод		 - Строка - Имя процедуры модуля
//  Параметры	 - Структура - Массив переменных
// 
// Возвращаемое значение:
//   - Любое
//
Функция ВыполнитьМетодКонфигурации(Метод, Параметры, ЭтоФункция) Экспорт

	ПредставлениеПараметров = "";
	Для каждого КлючЗначение Из Параметры Цикл
		ПредставлениеПараметров = ПредставлениеПараметров + "Параметры["+КлючЗначение.Занчение+"],";	
	КонецЦикла; 
	
	СтрокаКоманды = Метод+"("+Лев(ПредставлениеПараметров, СтрДлина(ПредставлениеПараметров)-1)+")";
	Если ЭтоФункция Тогда
		Результат = Неопределено;
		Выполнить("Результат=" + СтрокаКоманды);
		Возврат Результат;
	Иначе
		Возврат Неопределено;
	КонецЕсли; 
	
КонецФункции // Тестирвоание_ВыполнитьМетодМодуля()

#КонецОбласти

ИмяМетаданныхСлужебный = "";
ПараметрыОбъектаСлужебный = Новый Структура;
