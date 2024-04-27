﻿&НаКлиенте
Процедура ЗПОкладПриИзменении(Элемент)
	СТЧ = Элементы.ЗП.ТекущиеДанные;
	РаботаСдокументами.РасчетНдфл(СТЧ);
	РаботаСДокументами.РасчетЗп(СТЧ);
КонецПроцедуры

&НаКлиенте
Процедура ЗПРабочихДнейВМесяцеПриИзменении(Элемент)
	СТЧ = Элементы.ЗП.ТекущиеДанные;
	РаботаСДокументами.РасчетНдфл(СТЧ);
	РаботаСДокументами.РасчетЗп(СТЧ);
КонецПроцедуры

&НаКлиенте
Процедура ЗПФактическиОтработаноПриИзменении(Элемент)
	СТЧ = Элементы.ЗП.ТекущиеДанные;
	РаботаСДокументами.РасчетНдфл(СТЧ);
	РаботаСДокументами.РасчетЗп(СТЧ);
КонецПроцедуры

&НаКлиенте
Процедура ЗППремияПриИзменении(Элемент)
	СТЧ = Элементы.ЗП.ТекущиеДанные;
	РаботаСДокументами.РасчетНдфл(СТЧ);
	РаботаСДокументами.РасчетЗп(СТЧ);
КонецПроцедуры

&НаКлиенте
Процедура ЗПНДФЛПриИзменении(Элемент)
	СТЧ = Элементы.ЗП.ТекущиеДанные;
	РаботаСДокументами.РасчетЗп(СТЧ);
КонецПроцедуры

&НаКлиенте
Процедура ЗПСотрудникПриИзменении(Элемент)
	СТЧ = Элементы.ЗП.ТекущиеДанные;
	СТЧ.Оклад = РаботаСоСправочниками.Оклад(Объект.Дата, СТЧ.Сотрудник);
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Объект.Дата = ТекущаяДата();
	Объект.ДатаНачалаПериода = НачалоДня (НачалоМесяца (Объект.Дата));
	Объект.ДатаОкончаниеПериода = КонецДня (КонецМесяца (Объект.Дата));
КонецПроцедуры  

&НаСервере
Процедура ЗаполнитьТабличнуюЧасть()
	Объект.ЗП.Очистить();
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ
	|	ОкладыСрезПоследних.Сотрудник КАК Сотрудник,
	|	МАКСИМУМ(ОкладыСрезПоследних.Оклад) КАК Оклад
	|ИЗ
	|	РегистрСведений.Оклады.СрезПоследних(, ) КАК ОкладыСрезПоследних
	|
	|СГРУППИРОВАТЬ ПО
	|	ОкладыСрезПоследних.Сотрудник";
	РезультатЗапроса = Запрос.Выполнить().Выгрузить();
	
	ПроцентОтОклада = Объект.ВидРасчета.ПроцентОтОклада;
	Для каждого Стр из РезультатЗапроса Цикл 
		
		ФактическиОтработано = ПолучитьТабельСотрудника(Стр.Сотрудник);
		Если ФактическиОтработано = 0 Тогда
			Продолжить;
		КонецЕсли;
		
		НоваяСтрока = Объект.ЗП.Добавить();
		НоваяСтрока.Сотрудник = Стр.Сотрудник;
		НоваяСтрока.РабочихДнейВМесяце = 20;
		НоваяСтрока.ФактическиОтработано = ФактическиОтработано;	
		НоваяСтрока.Оклад = Стр.Оклад / 100 * ПроцентОтОклада;
		СреднийЗаработок = НоваяСтрока.Оклад / 20;
		НоваяСтрока.Начислено = НоваяСтрока.ФактическиОтработано * СреднийЗаработок;
		НоваяСтрока.НДФЛ = НоваяСтрока.Начислено/100*13;
		НоваяСтрока.Начислено = НоваяСтрока.Начислено - НоваяСтрока.НДФЛ;
	КонецЦикла
КонецПроцедуры 

&НаСервере
Функция ПолучитьТабельСотрудника(Сотрудник)
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ТабельТабличнаяЧасть1.Ссылка КАК Ссылка,
		|	ТабельТабличнаяЧасть1.КоличествоОтработаныхДней КАК КоличествоОтработаныхДней
		|ИЗ
		|	Документ.Табель.ТабличнаяЧасть1 КАК ТабельТабличнаяЧасть1
		|ГДЕ
		|	ТабельТабличнаяЧасть1.Сотрудник = &Сотрудник
		|	И ТабельТабличнаяЧасть1.Ссылка.Дата МЕЖДУ &ДатаНачала И &ДатаОкончания";
	
	Запрос.УстановитьПараметр("ДатаНачала", Объект.ДатаНачалаПериода);
	Запрос.УстановитьПараметр("ДатаОкончания", Объект.ДатаОкончаниеПериода);
	Запрос.УстановитьПараметр("Сотрудник", Сотрудник);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Если ВыборкаДетальныеЗаписи.Следующий() Тогда
		Возврат ВыборкаДетальныеЗаписи.КоличествоОтработаныхДней;	
	Иначе
		Возврат 0;	
	КонецЕсли;
	
КонецФункции

&НаКлиенте
Процедура ЗаполнитьПоСотруднику(Команда)

	Если ЗначениеЗаполнено(Объект.ВидРасчета) Тогда
		ЗаполнитьТабличнуюЧасть();   
	Иначе
		Сообщение = Новый СообщениеПользователю;
		Сообщение.Текст = "Не заполнен вид расчета!";
		Сообщение.Сообщить();
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура Расчитать(Команда)
	
КонецПроцедуры

&НаКлиенте
Процедура ТаблицаЗаработнойПлатыНДФЛПриИзменении(Элемент)
	СТЧ = Элементы.ТаблицаЗаработнойПлаты.ТекущиеДанные;
	РаботаСДокументами.РасчетЗп(СТЧ);
КонецПроцедуры

&НаКлиенте
Процедура ТаблицаЗаработнойПлатыРабочихДнейВМесяцеПриИзменении(Элемент)
	СТЧ = Элементы.ТаблицаЗаработнойПлаты.ТекущиеДанные;
	РаботаСДокументами.РасчетНдфл(СТЧ);
	РаботаСДокументами.РасчетЗп(СТЧ);
КонецПроцедуры

&НаКлиенте
Процедура ТаблицаЗаработнойПлатыФактическиОтработаноПриИзменении(Элемент)
	СТЧ = Элементы.ТаблицаЗаработнойПлаты.ТекущиеДанные;
	РаботаСДокументами.РасчетНдфл(СТЧ);
	РаботаСДокументами.РасчетЗп(СТЧ);
КонецПроцедуры
