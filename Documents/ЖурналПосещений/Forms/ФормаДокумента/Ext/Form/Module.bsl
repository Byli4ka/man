﻿
&НаСервере
Процедура ГруппаПриИзмененииНаСервере()
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ГруппыСоставГруппы.Учащийся КАК Учащийся
		|ИЗ
		|	Справочник.Группы.СоставГруппы КАК ГруппыСоставГруппы
		|ГДЕ
		|	ГруппыСоставГруппы.Ссылка = &Ссылка";
	
	Запрос.УстановитьПараметр("Ссылка", Объект.Группа);
	
	Объект.Учащиеся.Загрузить(Запрос.Выполнить().Выгрузить());

КонецПроцедуры

&НаКлиенте
Процедура ГруппаПриИзменении(Элемент)
	ГруппаПриИзмененииНаСервере();
КонецПроцедуры
