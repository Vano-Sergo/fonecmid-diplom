
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКоманды.ПриСозданииНаСервере(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды    
	
	//Панасенко С. 28.12.24  {
	КомандаЗаполнить = Команды.Добавить("ВыполнитьАвтозаполнение");   
	КомандаЗаполнить.Действие	= "ВКМ_ВыполнитьАвтозаполнение";
    КнопкаЗаполнить = Элементы.Добавить("Заполнить", Тип("КнопкаФормы"),Элементы.ФормаКоманднаяПанель); 
	КнопкаЗаполнить.Заголовок = "Заполнить";  
	КнопкаЗаполнить.ИмяКоманды	= "ВыполнитьАвтозаполнение"; 
	// }Панасенко С. 28.12.24 
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
    // СтандартныеПодсистемы.ПодключаемыеКоманды
    ПодключаемыеКомандыКлиент.НачатьОбновлениеКоманд(ЭтотОбъект);
    // Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
    // СтандартныеПодсистемы.ПодключаемыеКоманды
    ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
    // Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
    ПодключаемыеКомандыКлиент.ПослеЗаписи(ЭтотОбъект, Объект, ПараметрыЗаписи);
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыТовары

&НаКлиенте
Процедура ТоварыКоличествоПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Товары.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура ТоварыЦенаПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Товары.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура ТоварыПриИзменении(Элемент)
	
	РассчитатьСуммуДокумента();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыУслуги

&НаКлиенте
Процедура УслугиКоличествоПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Услуги.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура УслугиЦенаПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Услуги.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура УслугиПриИзменении(Элемент)
	
	РассчитатьСуммуДокумента();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура РассчитатьСуммуСтроки(ТекущиеДанные)
	
	ТекущиеДанные.Сумма = ТекущиеДанные.Цена * ТекущиеДанные.Количество;
	
	РассчитатьСуммуДокумента();
	
КонецПроцедуры

&НаКлиенте
Процедура РассчитатьСуммуДокумента()
	
	Объект.СуммаДокумента = Объект.Товары.Итог("Сумма") + Объект.Услуги.Итог("Сумма");
	
КонецПроцедуры

//Панасенко С. 28.12.24  {
&НаКлиенте
Процедура ВКМ_ВыполнитьАвтозаполнение(Команда)

	Если Не ЗначениеЗаполнено(Объект.Договор) Тогда   
		Сообщение = Новый СообщениеПользователю;
		Сообщение.Текст = "Не заполнен договор";
		Сообщение.Поле = "Договор";
		Сообщение.УстановитьДанные(ЭтотОбъект);
		Сообщение.Сообщить();
		Возврат; 
	КонецЕсли; 
	
	Если ЗначениеЗаполнено(Объект.Услуги) Тогда
		ДиалоговоеОкноДаНет(); 	  
	Иначе
		ВКМ_ВыполнитьАвтозаполнениеНаСервере()
   	КонецЕсли;
		
КонецПроцедуры   

  &НаКлиенте
Асинх Процедура ДиалоговоеОкноДаНет()
	
	Обещание = ВопросАсинх(НСтр("ru='В табличной части ""Услуги"" есть данные. Вы уверены, что их нужно перезаполнять?'"), РежимДиалогаВопрос.ДаНет, , КодВозвратаДиалога.Да);
    Результат = Ждать обещание;    
	
	Если Результат = КодВозвратаДиалога.Да Тогда
	
		ВКМ_ВыполнитьАвтозаполнениеНаСервере();
	
	КонецЕсли;
    
КонецПроцедуры	

&НаКлиенте
Процедура ПослеОтветаНаВопрос(Результат, Параметры) Экспорт     
	
	Если Результат = КодВозвратаДиалога.Да Тогда    
		ВКМ_ВыполнитьАвтозаполнениеНаСервере();		
	КонецЕсли;
		
КонецПроцедуры     

&НаСервере
Процедура ВКМ_ВыполнитьАвтозаполнениеНаСервере()   
	
	ДокументОбъект = РеквизитФормыВЗначение("Объект"); 
    ДокументОбъект.ВКМ_ВыполнитьАвтозаполнение(ДокументОбъект.Договор);
    ЗначениеВРеквизитФормы(ДокументОбъект,"Объект");  
 
КонецПроцедуры 

 // } Панасенко С. 28.12.24  
 
#Область ПодключаемыеКоманды

// СтандартныеПодсистемы.ПодключаемыеКоманды
&НаКлиенте
Процедура Подключаемый_ВыполнитьКоманду(Команда)
    ПодключаемыеКомандыКлиент.НачатьВыполнениеКоманды(ЭтотОбъект, Команда, Объект);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ПродолжитьВыполнениеКомандыНаСервере(ПараметрыВыполнения, ДополнительныеПараметры) Экспорт
    ВыполнитьКомандуНаСервере(ПараметрыВыполнения);
КонецПроцедуры

&НаСервере
Процедура ВыполнитьКомандуНаСервере(ПараметрыВыполнения)
    ПодключаемыеКоманды.ВыполнитьКоманду(ЭтотОбъект, ПараметрыВыполнения, Объект);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ОбновитьКоманды()
    ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
КонецПроцедуры
// Конец СтандартныеПодсистемы.ПодключаемыеКоманды

#КонецОбласти

#КонецОбласти
