﻿//начало текста модуля
&НаКлиенте
Перем Ванесса;

&НаКлиенте
// Структура, в которой хранится состояние сценария между выполнением шагов. Очищается перед выполнением каждого сценария.
Перем Контекст Экспорт;

&НаКлиенте
// Структура, в которой можно хранить служебные данные между запусками сценариев. Существует, пока открыта форма Vanessa-ADD.
Перем КонтекстСохраняемый Экспорт;

&НаКлиенте
Функция ПолучитьСписокТестов(КонтекстФреймворкаBDD) Экспорт
	Ванесса = КонтекстФреймворкаBDD;

	ВсеТесты = Новый Массив;

	//описание параметров
	//пример вызова Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,Снипет,ИмяПроцедуры,ПредставлениеТеста,Транзакция,Параметр);

	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯОткрылФормуVanessaADDВРежимеСамотестирования()","ЯОткрылФормуVanessaADDВРежимеСамотестирования","я открыл форму VanessaADD в режиме самотестирования");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯЗагрузилСпециальнуюТестовуюФичу(Парам01Строка)","ЯЗагрузилСпециальнуюТестовуюФичу","Я загрузил специальную тестовую фичу ""ОсновнаяТестоваяФича""");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ДеревоТестовЗаполнилосьСтрокамиИзФичи()","ДеревоТестовЗаполнилосьСтрокамиИзФичи","ДеревоТестов заполнилось строками из фичи");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ВПолеСИменемЯУказываюПутьККаталогуФич(Парам01,Парам02)","ВПолеСИменемЯУказываюПутьККаталогуФич","И В поле с именем ""КаталогФичСлужебный"" я указываю путь к каталогу фич ""StepsRunner""");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯСкопировалКаталогиБиблиотекВоВторойЭкземплярVanessaADD()","ЯСкопировалКаталогиБиблиотекВоВторойЭкземплярVanessaADD","И я скопировал каталоги библиотек во второй экземпляр VanessaADD");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ВТестируемомЭкземпляреЯНажалНаКнопку(Парам01)","ВТестируемомЭкземпляреЯНажалНаКнопку","И в тестируемом экземпляре я нажал на кнопку ""ВыполнитьОдинШаг""");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯЗакрываюТестируемыйЭкземплярVanessaADD()","ЯЗакрываюТестируемыйЭкземплярVanessaADD","И я закрываю тестируемый экземпляр VanessaADD");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯЗапоминаюДанныеПодключенияСеансаИзТестируемогоЭкземпляраВПеременную(Парам01,Парам02)","ЯЗапоминаюДанныеПодключенияСеансаИзТестируемогоЭкземпляраВПеременную","И я запоминаю порт подключения сеанса ""Кладовщик"" из тестируемого экземпляра в переменную ""ПортПодключения""");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯДобавилВТаблицуTestClientЗаписьСТемиЖеДаннымиПодключения(Парам01)","ЯДобавилВТаблицуTestClientЗаписьСТемиЖеДаннымиПодключения","И я добавил в таблицу TestClient запись с теми же данными подключения ""ДанныеПодключения""");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯЗапоминаюКоличествоОткрытыхСеансов1СВПеременную(Парам01)","ЯЗапоминаюКоличествоОткрытыхСеансов1СВПеременную","Дано Я запоминаю количество открытых сеансов 1С в переменную ""КоличествоНачальное2""");

	Возврат ВсеТесты;
КонецФункции

&НаКлиенте
Процедура ПередОкончаниемСценария() Экспорт
	//безусловное закрытие формы если она осталась
	Попытка
	    ОткрытаяФормаVanessaADD = Контекст.ОткрытаяФормаVanessaADD;
		ОткрытаяФормаVanessaADD.Закрыть();
	Исключение

	КонецПопытки;
КонецПроцедуры

&НаКлиенте
//я открыл форму VanessaADD в режиме самотестирования
//@ЯОткрылФормуVanessaADDВРежимеСамотестирования()
Процедура ЯОткрылФормуVanessaADDВРежимеСамотестирования() Экспорт
	ПутьКОбработке = Ванесса.Объект.КаталогИнструментов + "/bddRunner.epf";
	Если НЕ Ванесса.ЕстьПоддержкаАсинхронныхВызовов Тогда
		Файл = Новый Файл(ПутьКОбработке);
		Ванесса.ПроверитьРавенство(Файл.Существует(),Истина,"Существует файл bddRunner.epf");
	КонецЕсли;

	ИмяОбработки = Ванесса.ПодключитьВнешнююОбработкуКлиент(ПутьКОбработке);
	ФормаОбработки = ПолучитьФорму("ВнешняяОбработка." + ИмяОбработки + ".Форма.УправляемаяФорма",,,Истина);
	Ванесса.ПроверитьНеРавенство(ФормаОбработки.Открыта(),Истина,"Форма обработки должна быть закрыта.");

	ФормаОбработки.Объект.РежимСамотестирования = Истина;
	ФормаОбработки.Объект.DebugLog = Истина; //режим самотестирования удобен при полном консольном выводе в режиме отладки
	ФормаОбработки.ХостСистема = Ванесса;
	ФормаОбработки.Объект.ВерсияПлатформыДляГенерацииEPF = Ванесса.Объект.ВерсияПлатформыДляГенерацииEPF;
	ФормаОбработки.Объект.КаталогИнструментов = Ванесса.Объект.КаталогИнструментов;
	ФормаОбработки.Открыть();

	Ванесса.ПроверитьРавенство(ФормаОбработки.Открыта(),Истина,"Форма обработки должна открыться.");

	Контекст.Вставить("ОткрытаяФормаVanessaADD",ФормаОбработки);

КонецПроцедуры

&НаКлиенте
Процедура СделатьЗагрзукуФичВОткрытойФорме()
	ОткрытаяФормаVanessaADD                   = Контекст.ОткрытаяФормаVanessaADD;
	ОткрытаяФормаVanessaADD.Объект.КаталогФич = Контекст.ПутьКФиче;
	ОткрытаяФормаVanessaADD.ЗагрузитьФичи();
КонецПроцедуры

&НаКлиенте
Процедура ОбработчикНачатьПроверкуСуществования(Существует,ДополнительныеПараметры) Экспорт
	Если НЕ Существует Тогда
		ВызватьИсключение "Файл " + Контекст.ПутьКФиче + " не существует!";
	КонецЕсли;
	СделатьЗагрзукуФичВОткрытойФорме();
	Ванесса.ПродолжитьВыполнениеШагов();
КонецПроцедуры

&НаКлиенте
//Я загрузил специальную тестовую фичу "ОсновнаяТестоваяФича"
//@ЯЗагрузилСпециальнуюТестовуюФичу(Парам01Строка)
Процедура ЯЗагрузилСпециальнуюТестовуюФичу(ИмяФичи) Экспорт
	Контекст.Вставить("ИмяТестовойФичи",ИмяФичи);

	ОткрытаяФормаVanessaADD            = Контекст.ОткрытаяФормаVanessaADD;
	ПутьКФиче = ОткрытаяФормаVanessaADD.Объект.КаталогИнструментов + "/features/Support/Templates/" + ИмяФичи + ".feature";
	Контекст.Вставить("ПутьКФиче",ПутьКФиче);

	Если НЕ Ванесса.ЕстьПоддержкаАсинхронныхВызовов Тогда
		ФайлПроверкаСуществования = Новый Файл(ПутьКФиче);
		Если НЕ ФайлПроверкаСуществования.Существует() Тогда
			ВызватьИсключение "Файл " + ПутьКФиче + " не существует!";
		КонецЕсли;
		СделатьЗагрзукуФичВОткрытойФорме();
	Иначе
		Ванесса.ЗапретитьВыполнениеШагов();
		Файл = Новый Файл(ПутьКФиче);
		ДополнительныеПараметры = Неопределено;
		ОписаниеОповещения = Вычислить("Новый ОписаниеОповещения(""ОбработчикНачатьПроверкуСуществования"",ЭтаФорма,ДополнительныеПараметры)");
		Выполнить("Файл.НачатьПроверкуСуществования(ОписаниеОповещения)");
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
//ДеревоТестов заполнилось строками из фичи
//@ДеревоТестовЗаполнилосьСтрокамиИзФичи()
Процедура ДеревоТестовЗаполнилосьСтрокамиИзФичи() Экспорт
	ОткрытаяФормаVanessaADD = Контекст.ОткрытаяФормаVanessaADD;

	ЭлементыДерева = ОткрытаяФормаVanessaADD.Объект.ДеревоТестов.ПолучитьЭлементы();

	Ванесса.ПроверитьНеРавенство(ЭлементыДерева.Количество(),0,"В дереве тестов на первом уровне должны быть строки.");

	ЭлементыДерева = ЭлементыДерева[0].ПолучитьЭлементы();
	Ванесса.ПроверитьНеРавенство(ЭлементыДерева.Количество(),0,"В дереве тестов на втором уровне должны быть строки.");
КонецПроцедуры

&НаКлиенте
//И В поле с именем "КаталогФичСлужебный" я указываю путь к каталогу фич "StepsRunner"
//@ВПолеСИменемЯУказываюПутьККаталогуФич(Парам01,Парам02)
Процедура ВПолеСИменемЯУказываюПутьККаталогуФич(ИмяПоля,ИмяФичи) Экспорт
	ПутьКФичам = Ванесса.Объект.КаталогИнструментов + "/features/" + ИмяФичи;
	Ванесса.Шаг("И В открытой форме в поле с именем """ + ИмяПоля + """ я ввожу текст """ + ПутьКФичам + """");
КонецПроцедуры

&НаКлиенте
//И я скопировал каталоги библиотек во второй экземпляр VanessaADD
//@ЯСкопировалКаталогиБиблиотекВоВторойЭкземплярVanessaADD(Парам01,Парам02)
Процедура ЯСкопировалКаталогиБиблиотекВоВторойЭкземплярVanessaADD() Экспорт
	ОткрытаяФормаVanessaADD = Контекст.ОткрытаяФормаVanessaADD;
	ОткрытаяФормаVanessaADD.Объект.КаталогиБиблиотек.Очистить();
	Для Каждого ЭлемКаталогиБиблиотек Из Ванесса.Объект.КаталогиБиблиотек Цикл
		ОткрытаяФормаVanessaADD.Объект.КаталогиБиблиотек.Добавить(ЭлемКаталогиБиблиотек.Значение);
	КонецЦикла;
КонецПроцедуры

&НаКлиенте
//И в тестируемом экземпляре я нажал на кнопку "ВыполнитьСценарии"
//@ВТестируемомЭкземпляреЯНажалНаКнопку(Парам01)
Процедура ВТестируемомЭкземпляреЯНажалНаКнопку(ИмяПроцедуры) Экспорт
	ОткрытаяФормаVanessaADD = Контекст.ОткрытаяФормаVanessaADD;
	Выполнить("ОткрытаяФормаVanessaADD." + ИмяПроцедуры +"();");
КонецПроцедуры

&НаКлиенте
//И я закрываю тестируемый экземпляр VanessaADD
//@ЯЗакрываюТестируемыйЭкземплярVanessaADD()
Процедура ЯЗакрываюТестируемыйЭкземплярVanessaADD() Экспорт
	ОткрытаяФормаVanessaADD = Контекст.ОткрытаяФормаVanessaADD;
	ОткрытаяФормаVanessaADD.Закрыть();
КонецПроцедуры

&НаКлиенте
//И я запоминаю данные подключения сеанса "Кладовщик" из тестируемого экземпляра в переменную "ПортПодключения"
//@ЯЗапоминаюДанныеПодключенияСеансаИзТестируемогоЭкземпляраВПеременную()
Процедура ЯЗапоминаюДанныеПодключенияСеансаИзТестируемогоЭкземпляраВПеременную(ИмяПрофиля,ИмяПеременной) Экспорт
	ОткрытаяФормаVanessaADD = Контекст.ОткрытаяФормаVanessaADD;
	Нашли = Ложь;
	Для Каждого ЭлемДанныеКлиентовТестирования Из ОткрытаяФормаVanessaADD.ДанныеКлиентовТестирования Цикл
		Если ЭлемДанныеКлиентовТестирования.Имя = ИмяПрофиля Тогда
			Нашли = Истина;
			ДанныеПодключения = Новый Структура;
			ДанныеПодключения.Вставить("ПортЗапускаТестКлиента",ЭлемДанныеКлиентовТестирования.ПортЗапускаТестКлиента);
			ДанныеПодключения.Вставить("ПутьКИнфобазе",ЭлемДанныеКлиентовТестирования.ПутьКИнфобазе);
			ДанныеПодключения.Вставить("ТипКлиента",ЭлемДанныеКлиентовТестирования.ТипКлиента);
			ДанныеПодключения.Вставить("Имя",ЭлемДанныеКлиентовТестирования.Имя);
			Контекст.Вставить(ИмяПеременной,ДанныеПодключения);
		КонецЕсли;
	КонецЦикла;

	Если Не Нашли Тогда
		ВызватьИсключение "Не нашли профиль <" + ИмяПрофиля + "> в тестируемом экземпляре Vanessa-ADD.";
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
//И я добавил в таблицу TestClient запись с теми же данными подключения "ДанныеПодключения"
//@ЯДобавилВТаблицуTestClientЗаписьСТемиЖеДаннымиПодключения(Парам01)
Процедура ЯДобавилВТаблицуTestClientЗаписьСТемиЖеДаннымиПодключения(ИмяПеременной) Экспорт
	ОткрытаяФормаVanessaADD = Контекст.ОткрытаяФормаVanessaADD;

	СтрокаДанныеКлиентовТестирования                        = ОткрытаяФормаVanessaADD.ДанныеКлиентовТестирования.Добавить();
	СтрокаДанныеКлиентовТестирования.ПортЗапускаТестКлиента = Контекст[ИмяПеременной].ПортЗапускаТестКлиента;
	СтрокаДанныеКлиентовТестирования.ПутьКИнфобазе          = Контекст[ИмяПеременной].ПутьКИнфобазе;
	СтрокаДанныеКлиентовТестирования.ТипКлиента             = Контекст[ИмяПеременной].ТипКлиента;
	СтрокаДанныеКлиентовТестирования.Имя                    = Контекст[ИмяПеременной].Имя;
КонецПроцедуры

&НаКлиенте
//Дано Я запоминаю количество открытых сеансов 1С в переменную "КоличествоНачальное"
//@ЯЗапоминаюКоличествоОткрытыхСеансов1СВПеременную(Парам01)
Процедура ЯЗапоминаюКоличествоОткрытыхСеансов1СВПеременную(ИмяПеременной) Экспорт
	МассивPIDОкон1С = Ванесса.ПолучитьМассивPIDОкон1С();
	Контекст.Вставить(ИмяПеременной,МассивPIDОкон1С.Количество());
КонецПроцедуры

//окончание текста модуля