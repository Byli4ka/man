﻿ Функция ОсновнаяПлатформа() Экспорт
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ ПЕРВЫЕ 1
		|	Платформа.Ссылка КАК Ссылка
		|ИЗ
		|	Справочник.Платформа КАК Платформа
		|ГДЕ
		|	НЕ Платформа.ПометкаУдаления";
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Платформа = Справочники.Платформа.ПустаяСсылка();
	Если НЕ РезультатЗапроса.Пустой() Тогда
		
		Выборка = РезультатЗапроса.Выбрать();
		Выборка.Следующий();
		
		Платформа = Выборка.Ссылка;
	
	КонецЕсли;      
	
	Возврат Платформа;
	
КонецФункции
