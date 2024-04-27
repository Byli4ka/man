﻿	
	&НаКлиенте
Процедура ВставитьКартинку(Команда)

Оповещение = Новый ОписаниеОповещения("ОбработатьВыборФайла",ЭтотОбъект);
НачатьПомещениеФайла(Оповещение,,,Истина, УникальныйИдентификатор);

КонецПроцедуры  
&НаКлиенте
Процедура ВыбратьФайлКартинки(Команда)
Оповещение = Новый ОписаниеОповещения("ОбработатьВыборФайла",ЭтотОбъект);
НачатьПомещениеФайла(Оповещение,,,Истина, УникальныйИдентификатор);
КонецПроцедуры

&НаКлиенте
Процедура ОбработатьВыборФайла(Результат, Адрес,
ВыбранноеИмяФайла,ДополнительныйПараметр) Экспорт
Если НЕ Результат Тогда
Возврат;
КонецЕсли;
СсылкаНаКартинку = Адрес;
КонецПроцедуры

&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
Если ЭтоАдресВременногоХранилища(СсылкаНаКартинку) Тогда
ТекущийОбъект.ДанныеКартинки = Новый
ХранилищеЗначения(ПолучитьИзВременногоХранилища(СсылкаНаКартинку));
КонецЕсли;
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
СсылкаНаКартинку = ПолучитьНавигационнуюСсылку(Объект.Ссылка,
"ДанныеКартинки");
КонецПроцедуры

		
	

             