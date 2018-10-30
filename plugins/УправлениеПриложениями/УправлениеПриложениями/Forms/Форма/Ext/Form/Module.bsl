﻿&НаКлиенте
Перем WshShell;

&НаКлиенте
Перем КонтекстЯдра;

// { Plugin interface
&НаКлиенте
Функция ОписаниеПлагина(ВозможныеТипыПлагинов) Экспорт
	Возврат ОписаниеПлагинаНаСервере(ВозможныеТипыПлагинов);
КонецФункции

&НаКлиенте
Процедура Инициализация(КонтекстЯдраПараметр) Экспорт
	КонтекстЯдра = КонтекстЯдраПараметр;
КонецПроцедуры

&НаСервере
Функция ОписаниеПлагинаНаСервере(ВозможныеТипыПлагинов)
	Возврат ЭтотОбъектНаСервере().ОписаниеПлагина(ВозможныеТипыПлагинов);
КонецФункции
// } Plugin interface

// { API

// Выполняет команду системы, при этом на экране не будет показано окно cmd
// Использует WshShell.
//
// Параметры:
//  СтрокаКоманды		 - Строка - выполняемая команда
//  ЖдатьОкончания		 - Булево, Число  - флаг ожидания окончания выполнения команды:
//		Если ЖдатьОкончания = Истина (или -1), тогда будет ожидания окончания работы приложения
//		Если ЖдатьОкончания = Ложь (или 0), тогда нет ожидания
//  ИспользоватьКодировкуТекстаUTF8	 - Булево - командный файл будет запущен с кодировкой консоли UTF8 через chcp 65001
//
// Возвращаемое значение:
//   - Результат выполнения скрипта. 0 - если не было ошибок.
//
&НаКлиенте
Функция ВыполнитьКомандуОСБезПоказаЧерногоОкна(Знач ТекстКоманды, Знач ЖдатьОкончания = Истина, 
	Знач ИспользоватьКодировкуТекстаUTF8 = Истина) Экспорт
	
	Если ЖдатьОкончания = -1 Тогда
		ЖдатьОкончания = Истина;
	ИначеЕсли ЖдатьОкончания = 0 Тогда
		ЖдатьОкончания = Ложь;
	КонецЕсли;

	УдалятьФайл = Ложь;
	ИмяВременногоФайлаКоманды = ТекстКоманды;
	Если ИспользоватьКодировкуТекстаUTF8 Тогда
		
		ИмяВременногоФайлаКоманды = ПолучитьИмяВременногоФайла("bat");
		
		//эти строки нужны для записи файла без BOM
		ЗТ = Новый ЗаписьТекста(ИмяВременногоФайлаКоманды, "CESU-8", , Ложь);
		ЗТ.ЗаписатьСтроку("chcp 65001");
	
		ЗТ.ЗаписатьСтроку(ТекстКоманды);
		ЗТ.Закрыть();
		
		УдалятьФайл = Истина;		
	КонецЕсли;
	
	ИмяВременногоФайлаКоманды = "cmd /c """ + ИмяВременногоФайлаКоманды + """";

	КонтекстЯдра.Отладка(ТекстКоманды);
	//КонтекстЯдра.Отладка(ИмяВременногоФайлаКоманды);

	Если WshShell = Неопределено Тогда
		WshShell = ПолучитьWshShell();
	КонецЕсли;

	Рез = WshShell.Run(ИмяВременногоФайлаКоманды, 0, ?(ЖдатьОкончания, -1, 0));

	Если ЖдатьОкончания И УдалятьФайл Тогда
		//иначе удалять нельзя
		Если КонтекстЯдра.ЕстьПоддержкаАсинхронныхВызовов Тогда
			// для скорости не удаляем временный файл, сервер потом удалит КонтекстЯдра.УдалитьФайлыКомандаСистемы(ИмяВременногоФайлаКоманды);
		Иначе
			УдалитьФайлы(ИмяВременногоФайлаКоманды);
		КонецЕсли;	 
	КонецЕсли;	 

	Возврат Рез;
КонецФункции

// Выполняет команду системы, при этом на экране не будет показано окно cmd
// Использует WshShell.
//
// Параметры:
//  ТекстКоманды           - Строка - выполняемая команда
//  ЖдатьОкончания          - Булево, Число  - флаг ожидания окончания выполнения команды:
//		Если ЖдатьОкончания = Истина (или -1), тогда будет ожидания окончания работы приложения
//		Если ЖдатьОкончания = Ложь (или 0), тогда нет ожидания
//  ИспользоватьКодировкуТекстаUTF8 - Булево - командный файл будет запущен с кодировкой консоли UTF8 через chcp 65001
//  КонсольныйВывод         - Строка - исходящий параметр. В нем возвращается весь консольный вывод скрипта
//
// Возвращаемое значение:
//  Число - Результат выполнения скрипта. 0 - если не было ошибок.
//
&НаКлиенте
Функция ВыполнитьКомандуОСБезПоказаЧерногоОкнаСВыводом(Знач ТекстКоманды, Знач ЖдатьОкончания = Истина, 
	Знач ИспользоватьКодировкуТекстаUTF8 = Истина, КонсольныйВывод = "") Экспорт
	
	Если ЖдатьОкончания = -1 Тогда
		ЖдатьОкончания = Истина;
	ИначеЕсли ЖдатьОкончания = 0 Тогда
		ЖдатьОкончания = Ложь;
	КонецЕсли;

	УдалятьФайл = Ложь;
	ИмяВременногоФайлаКоманды = ТекстКоманды;
	Если ИспользоватьКодировкуТекстаUTF8 Тогда
		
		ИмяВременногоФайлаКоманды = ПолучитьИмяВременногоФайла("bat");
		
		//эти строки нужны для записи файла без BOM
		ЗТ = Новый ЗаписьТекста(ИмяВременногоФайлаКоманды, "CESU-8", , Ложь);
		ЗТ.ЗаписатьСтроку("chcp 65001");
	
		ЗТ.ЗаписатьСтроку(ТекстКоманды);
		ЗТ.Закрыть();
		
		УдалятьФайл = Истина;
	КонецЕсли;
	
	ИмяФайлаВывода = ПолучитьИмяВременногоФайла("txt");
	ИмяВременногоФайлаКоманды = "cmd /c """ + ИмяВременногоФайлаКоманды + " -c > """ + ИмяФайлаВывода + """";

	КонтекстЯдра.Отладка(ТекстКоманды);
	//КонтекстЯдра.Отладка(ИмяВременногоФайлаКоманды);

	WshShell = ПолучитьWshShell();
	
	Рез = WshShell.Run(ИмяВременногоФайлаКоманды, 0, ?(ЖдатьОкончания, -1, 0));
	Если Рез = 0 Тогда
		// команда выполнилась успешно
		ЧТ = Новый ЧтениеТекста(ИмяФайлаВывода);
		КонсольныйВывод = ЧТ.Прочитать();
		ЧТ.Закрыть();
	КонецЕсли;
	
	Если ЖдатьОкончания И УдалятьФайл Тогда
		//иначе удалять нельзя
		Если КонтекстЯдра.ЕстьПоддержкаАсинхронныхВызовов Тогда
			// для скорости не удаляем временный файл, сервер потом удалит КонтекстЯдра.УдалитьФайлыКомандаСистемы(ИмяВременногоФайлаКоманды);
		Иначе
			УдалитьФайлы(ИмяВременногоФайлаКоманды);
		КонецЕсли;
	КонецЕсли;

	Возврат Рез;
КонецФункции

// далее переменная WshShell будет закеширована, чтобы не создавать ComObject каждый раз
&НаКлиенте
Функция ПолучитьWshShell() Экспорт

	Если WshShell = Неопределено Тогда
		Попытка
			WshShell = Новый COMОбъект("WScript.Shell");
		Исключение
			ВызватьИсключение "Не удалось подключить COM объект <WScript.Shell>";
		КонецПопытки;
	КонецЕсли;

	Возврат WshShell;

КонецФункции

// Функция - Установлен OneScript
// 
// Возвращаемое значение:
//   Булево - Истина = установлен, Ложь = Нет
//
&НаКлиенте
Функция УстановленOneScript() Экспорт

	ИнструментУстановлен = Ложь;

	ИмяФайлаЛога = ПолучитьИмяВременногоФайла("txt");
	Стр = "oscript > """ + ИмяФайлаЛога + """ 2>&1";

	ВыполнитьКомандуОСБезПоказаЧерногоОкна(Стр);

	Текст = Новый ЧтениеТекста;
	Текст.Открыть(ИмяФайлаЛога, "UTF-8");

	СтрокаВозврата = Неопределено;

	КолСтрокСчитано = 0;
	Стр = Текст.ПрочитатьСтроку();

	Если Стр <> Неопределено Тогда
		Образец = "1Script Execution Engine";
		Если Лев(Стр, СтрДлина(Образец)) = Образец Тогда
			ИнструментУстановлен = Истина;
		КонецЕсли;
	КонецЕсли;

	Текст.Закрыть();
	КонтекстЯдра.УдалитьФайлыКомандаСистемы(ИмяФайлаЛога);

	Возврат ИнструментУстановлен;

КонецФункции // УстановленOneScript()


&НаКлиенте
Функция ПолучитьМассивPIDПроцессов(ИмяОбраза) Экспорт
	ИмяВременногоФайла = ПолучитьИмяВременногоФайла("txt");
	ИмяВременногоBat = ПолучитьИмяВременногоФайла("bat");
	ЗТ = Новый ЗаписьТекста(ИмяВременногоBat, "windows-1251", , Истина);
	ЗТ.ЗаписатьСтроку("chcp 65001");
	ЗТ.ЗаписатьСтроку("tasklist /v /fo list /fi ""imagename eq " + ИмяОбраза + """ > """ + ИмяВременногоФайла + """");
	ЗТ.Закрыть();

	ВыполнитьКомандуОСБезПоказаЧерногоОкна(ИмяВременногоBat);

	Текст = Новый ЧтениеТекста;
	Текст.Открыть(ИмяВременногоФайла, "UTF-8");

	МассивProcessID = Новый Массив;
	ProcessID = Неопределено;
	Пока Истина Цикл
		Стр = Текст.ПрочитатьСтроку();
		Если Стр = Неопределено Тогда
			Прервать;
		КонецЕсли;

		Стр = НРег(Стр);
		Если Лев(Стр, 4) = "pid:" Тогда
			ProcessID = СокрЛП(Сред(Стр, 5));
		КонецЕсли;

		Если ProcessID <> Неопределено Тогда
			Если (Лев(Стр, 15) = "заголовок окна:") или (Лев(Стр, 13) = "window title:") Тогда
				МассивProcessID.Добавить(ProcessID);
			КонецЕсли;
		КонецЕсли;
	КонецЦикла;
	Текст.Закрыть();

	Возврат МассивProcessID;
КонецФункции

&НаКлиенте
Процедура ЗавершитьСеансыTestClientПринудительно() Экспорт
	ИмяВременногоФайла = ПолучитьИмяВременногоФайла("txt");

	Если НЕ КонтекстЯдра.ЭтоLinux Тогда
		ИмяВременногоBat = ПолучитьИмяВременногоФайла("bat");
		ЗТ = Новый ЗаписьТекста(ИмяВременногоBat, "windows-1251", , Истина);
		ЗТ.ЗаписатьСтроку("chcp 65001");
		ЗТ.ЗаписатьСтроку("tasklist /v /fo list /fi ""imagename eq 1cv8c.exe"" > """ + ИмяВременногоФайла + """");
		ЗТ.Закрыть();

		ЗапуститьПриложение(ИмяВременногоBat, , Истина);

		Текст = Новый ЧтениеТекста;
		Текст.Открыть(ИмяВременногоФайла, "UTF-8");

		МассивProcessID = Новый Массив;
		ProcessID = Неопределено;
		Пока Истина Цикл
			Стр = Текст.ПрочитатьСтроку();
			Если Стр = Неопределено Тогда
				Прервать;
			КонецЕсли;

			Стр = НРег(Стр);
			Если Лев(Стр, 4) = "pid:" Тогда
				ProcessID = СокрЛП(Сред(Стр, 5));
			КонецЕсли;

			Если ProcessID <> Неопределено Тогда
				Если (Лев(Стр, 15) = "заголовок окна:") или (Лев(Стр, 13) = "window title:") Тогда
					Если Найти(Стр, "vanessa") = 0 Тогда
						МассивProcessID.Добавить(ProcessID);
					КонецЕсли;
				КонецЕсли;
			КонецЕсли;
		КонецЦикла;
		Текст.Закрыть();

		Если МассивProcessID.Количество() = 0 Тогда
			Возврат;
		КонецЕсли;

		ИмяВременногоBat = ПолучитьИмяВременногоФайла("bat");
		ЗТ = Новый ЗаписьТекста(ИмяВременногоBat, "UTF-8", , Истина);
		Стр = "taskkill /F ";
		Для каждого ProcessID Из МассивProcessID Цикл
			Стр = Стр + "/pid " + ProcessID + " ";
		КонецЦикла;
		ЗТ.ЗаписатьСтроку(Стр);
		ЗТ.Закрыть();

		ЗапуститьПриложение(ИмяВременногоBat, , Истина);

	Иначе

		СтрокаЗапуска = "kill -9 `ps aux | grep -ie TESTCLIENT | grep -ie 1cv8c | awk '{print $2}'`";
		ЗапуститьПриложение(СтрокаЗапуска);

	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Функция ПолучитьМассивPIDОкон1С() Экспорт
	Рез = Новый Массив;

	ЗаполнитьМассивPIDПоИмениПроцесса("1cv8.exe", Рез);
	ЗаполнитьМассивPIDПоИмениПроцесса("1cv8c.exe", Рез);

	Возврат Рез;

КонецФункции

&НаКлиенте
Процедура СделатьОкноПроцессаАктивным(PID) Экспорт
	WshShell = ПолучитьWshShell();

	Попытка
		WshShell.AppActivate(PID);
	Исключение
		КонтекстЯдра.СделатьСообщение(ОписаниеОшибки());
	КонецПопытки;
КонецПроцедуры

&НаКлиенте
Процедура TASKKILL(ИмяПриложения) Экспорт
	СтрокаКоманды = "TASKKILL /F /IM " + ИмяПриложения;
	ВыполнитьКомандуОСБезПоказаЧерногоОкна(СтрокаКоманды);
КонецПроцедуры


// } Plugin interface

// { Helpers
&НаСервере
Функция ЭтотОбъектНаСервере()
	Возврат РеквизитФормыВЗначение("Объект");
КонецФункции

&НаКлиенте
Процедура ЗаполнитьМассивPIDПоИмениПроцесса(ИмяПроцесса, Массив)
	ЛогФайл = ПолучитьИмяВременногоФайла("txt");
	Команда = "tasklist /FI ""IMAGENAME eq " + ИмяПроцесса +  """ /nh > """ + ЛогФайл + """";
	ВыполнитьКомандуОСБезПоказаЧерногоОкна(Команда);

	Если НЕ КонтекстЯдра.ФайлСуществуетКомандаСистемы(ЛогФайл, "ЗаполнитьМассивPIDПоИмениПроцесса") Тогда
		КонтекстЯдра.СделатьСообщение("Ошибка при получении списка процессов 1С.");
		Возврат;
	КонецЕсли;

	Текст = Новый ЧтениеТекста;
	Текст.Открыть(ЛогФайл, "UTF-8");

	Пока Истина Цикл
		Стр = Текст.ПрочитатьСтроку();
		Если Стр = Неопределено Тогда
			Прервать;
		КонецЕсли;


		Если СокрЛП(Стр) = "" Тогда
			Продолжить;
		КонецЕсли;

		Стр = НРег(Стр);
		Стр = СокрЛП(СтрЗаменить(Стр, НРег(ИмяПроцесса), ""));
		Поз = Найти(Стр, " ");
		PID = Лев(Стр, Поз - 1);
		Если Найти(PID,"info") > 0 Тогда
			Продолжить;
		КонецЕсли;

		Попытка
			PID = Число(PID);
			Массив.Добавить(PID);
		Исключение
			ТекстСообщения = "Не смог преобразовать к числу PID=%1";
			ТекстСообщения = СтрЗаменить(ТекстСообщения,"%1",PID);
			КонтекстЯдра.СделатьСообщение(ТекстСообщения);
		КонецПопытки;

	КонецЦикла;

	Текст.Закрыть();

	КонтекстЯдра.УдалитьФайлыКомандаСистемы(ЛогФайл);

КонецПроцедуры

// } Helpers
