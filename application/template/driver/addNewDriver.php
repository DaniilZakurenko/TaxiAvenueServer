<div id="addDriverPopup">
	<form name="addNewDriverForm" id="addNewDriverForm">
		<div class="column380 flLeft clearfix">
			<div  style=" height: 110px;">
                <div class="fullName">
                    <label>Фамилия<input type="text" name="driver[surname]"><br></label>
                    <label>Имя<input type="text" name="driver[name]"><br></label>
                    <label>Отчество<input type="text" name="driver[patronymic]"><br></label>
                </div>
                <div class="driverPhotoAll" >
                    <input id="driverPhotoUploadButton" type="file" name="driverPhoto" style="display: none;">
                    <div id="driverPhotoPreview">
                        <img src="../images/background_Preview_picture.png"/>
                    </div>
                    <button id="openFileDialogButton" onclick="openFileDialog('driverPhotoUploadButton');" type="button">Загрузить</button>
                </div>

            </div>
			<hr>
			<div class="driverInfo">
				<label>Дата рождения <input class="datepicker" type="text" name="driver[dob]"><br></label>
				<label>Паспорт<input type="text" name="driver[passport]"><br></label>
				<label>Мобильный телефон<input type="text" name="driver[mobile_phone]"><br></label>
				<label>Телефон 2<input type="text" name="driver[phone2]"><br></label>
				<label>Адрес<input type="text" name="driver[address1]"><br></label>
				<label>Дата приёма<input class="datepicker" type="text" name="driver[admission_date]" value="<?= date('d-m-Y'); ?>"><br></label>
				<label>Дата увольнения<input class="datepicker" type="text" name="driver[dismissal_date]"><br></label>
			</div>
			<hr>
			<div class="callsign">

                <div  style="width: 100%; height: 60px;">
                    <div class="callsignLeft">
                        <label >Позывной<br><input  type="text" name="driver[callsign]"><br></label>
                    </div>
                    <div class="callsignRight">
                        <label >Пароль<br><input  type="text" name="driver[password]"><br></label>
                    </div>

                    <!--<div id="ErrorMessage"></div>-->
                </div>
                <div class="callsignBottom" >

                    <label ><input type="checkbox" name="driver[see_non_cash]">Видимость заказа по безнал.<br></label>
                    <label><input type="checkbox" name="driver[only_non_cash]">Видит только безнал. если долг<br></label>
                    <label><input type="checkbox" name="driver[passenger_phone]">Видит телефон пассажира<br></label>

                </div>
			</div>
		</div>
		<div class="column flRight">
			<div class="commission">
				<label>Комиссия<input type="text" name="car[commission]"><br></label>
				<label>Комиссия (период, грн)<input type="text" name="car[commission_period_pay]"><br></label>
			</div>
			<div class="clear"></div>
			<hr>
			<div class="fee">
			<label>Абонплата<input type="text" name="car[fee]"><br></label>
			<label>Абонплата (период, грн)<input type="text" name="car[fee_period]"><br></label>
			</div>
			<div class="clear"></div>
			<hr>
			<div class="tarif">
				<label>Индивидуальный тариф<input type="text" name="car[tariff_ind]"><br></label>
				<div class="terminal">
					<label><input type="checkbox" name="car[terminal]">Терминал<br></label>
				</div>
			</div>
			<hr>
			<div class="carInfo">
				<label>Номер автомобиля<input type="text" name="car[number]"><br></label>
				<label>Марка<input type="text" name="car[model]"><br></label>
				<label>Цвет<input type="text" name="car[color]"><br></label>
				<label>Год выпуска<input type="text" name="car[year]"><br></label>
				<label>Тип<select style="margin-left: 10px" type="text" name="car[type]"> <? print_r($this->prop['carTypes']); ?>
					<? foreach($this->prop['carTypes'] as $type) : ?>
						<option value="<?= $type['id']; ?>"><?= $type['type']; ?></option>
					<? endforeach; ?>
				</select>				
				<br></label>
				<div class="conditioner">
					<label><input type="checkbox" name="car[condition]">Кондиционер<br></label>
				</div>
			</div>
			<div class="clear"></div>
			<div class="notes">
				<label>Заметки<textarea name="car[notes]"></textarea><br></label>
			</div>

            <button id="driverCancelButton" type="button" onclick="<? if(isset($this->prop['order'])) : ?> setOrderEditMark(<?= $this->prop['order'][0]['orderId']; ?> , 0); <? endif; ?> cancelOrder();">Отменить</button>
            <button id="driverSaveButton" type="button" onclick="saveDriver();">Сохранить</button>
        </div>
		

	</form>	
</div>
