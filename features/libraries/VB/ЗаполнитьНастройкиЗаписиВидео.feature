﻿# language: ru

@IgnoreOnCIMainBuild

@ExportScenarios


Функционал: Заполнение настроек записи видео
	Как Разработчик
	Я Хочу чтобы чтобы у меня был сценарий для заполнения настроек записи видео в TestClient
	Чтобы я мог его переиспользовать


Сценарий: Я заполняю настройки записи видео в TestClient
#	Дано Я открыл новый сеанс TestClient или подключил уже существующий без загрузки настроек
#	И    Я закрыл все окна клиентского приложения
#	И    Я открываю VanessaADD в режиме TestClient

	И     я перехожу к закладке "Сервис"
	И     я перехожу к закладке "Автоинструкции"
	И     в поле "Экран ширина" я ввожу значение из TestManager "ЗаписьВидеоЭкранШирина"
	И     в поле "Экран высота" я ввожу значение из TestManager "ЗаписьВидеоЭкранВысота"
	И     в поле "Количество кадров в секунду" я ввожу значение из TestManager "ЗаписьВидеоКоличествоКадров"
	И     в поле "Команда начать запись видео" я ввожу значение из TestManager "ЗаписьВидеоКомандаНачатьЗаписьВидео"
	И     в поле "Файл курсор мыши" я ввожу значение из TestManager "ЗаписьВидеоФайлКурсораМышки"
	И     в поле "Каталог для временных файлов" я ввожу значение из TestManager "ЗаписьВидеоКаталогДляВременныхФайлов"
	И     в поле "Файл водяной знак" я ввожу значение из TestManager "ЗаписьВидеоФайлВодянойЗнак"
	И     в поле "Команда ffmpeg" я ввожу значение из TestManager "ЗаписьВидеоКомандаFfmpeg"
	И     в поле "Команда Convert" я ввожу значение из TestManager "ЗаписьВидеоКомандаConvert"
	И     в поле "Каталог музыки" я ввожу значение из TestManager "ЗаписьВидеоКаталогМузыки"
	И     я изменяю флаг "Подсвечивать активные элементы форм" в соответствии со значением TestManager "ЗаписьВидеоПодсвечиватьАктивныеЭлементыФорм"
	И     я изменяю флаг "Перемещать курсор мышки к активному элементу формы" в соответствии со значением TestManager "ЗаписьВидеоПеремещатьКурсорМышкиКАктивномуЭлементуФормы"
	И     я изменяю флаг "Делать озвучку TTS" в соответствии со значением TestManager "ЗаписьВидеоДелатьНаложениеTTS"
	И     в поле "Путь к движку TTS" я ввожу значение из TestManager "ЗаписьВидеоПутьКДвижкуTTS"
	И     в поле "Имя голоса TTS" я ввожу значение из TestManager "ЗаписьВидеоИмяTTS"
	И     в поле Путь к словарю замен я ввожу значение из TestManager "ЗаписьВидеоСловарьЗамен"
