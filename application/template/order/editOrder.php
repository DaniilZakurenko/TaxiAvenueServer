<style>
.popup {
	//background: url(../images/bg-popup.png) -5px -5px;
	background-color: #eceae8;
	border: 5px solid rgba(197, 192, 192, .7);
	border-radius: 10px;
	//height: 760px;
	position: absolute;
	//width: 1260px;
	z-index: 999;
}
.popup-content {
    border-radius: 6px;
    line-height: 1.6;
    padding: 14px 18px 0 17px;
}
.popup-title {
	//background: url(../images/bg-popup-title.png) repeat-x;
	/*border-radius: 6px 6px 0 0;*/
	font-family: 'HelveticaNeue', sans-serif;
	font-size: 17px;
	height: 43px;
	line-height: 43px;
	padding: 0 0 0 16px;
	/*text-shadow: 0 1px 0 rgba(255, 255, 255, .5);
	box-shadow: inset 0 1px 1px #e6edef;*/
	
	text-align: center;
	color:#fff;
	background: #639f01; /* Old browsers */
	background: -moz-linear-gradient(top,  #639f01 0%, #4d7b01 100%); /* FF3.6+ */
	background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#639f01), color-stop(100%,#4d7b01)); /* Chrome,Safari4+ */
	background: -webkit-linear-gradient(top,  #639f01 0%,#4d7b01 100%); /* Chrome10+,Safari5.1+ */
	background: -o-linear-gradient(top,  #639f01 0%,#4d7b01 100%); /* Opera 11.10+ */
	background: -ms-linear-gradient(top,  #639f01 0%,#4d7b01 100%); /* IE10+ */
	background: linear-gradient(to bottom,  #639f01 0%,#4d7b01 100%); /* W3C */
	filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#639f01', endColorstr='#4d7b01',GradientType=0 ); /* IE6-9 */

}
.popup-choice {
	margin: 34px 0 0;
	text-align: center;
}
.btn-yes,
.btn-no {
	border: none;
	font-family: 'HelveticaNeue', sans-serif;
	font-size: 12px;
	height: 22px;
	line-height: 35px;
	text-shadow: 0 1px 0 rgba(255, 255, 255, .4);
	width: 22px;
	position: absolute;
	right: 5px;
	top: 25px;
	background: url(../images/close.png) no-repeat;
}
.btn-yes:active,
.btn-no:active {
	top: 26px;
}
.btn-yes {
	//background: url(../images/bg-btn-yes.png) no-repeat;
	color: #2a4006;
	margin: 0 6px 0 0;
}
.btn-no {
	//background: url(../images/bg-btn-no.png) no-repeat;
	color: #582121;
}
.btn-close {
	//background: url(../images/btn-close.png) no-repeat;
	height: 17px;
	left: 314px;
	position: absolute;
	top: 13px;
	width: 16px;
}
.btn-close:hover {
	cursor: pointer;
}
.hide-layout {
	background: #000;
	bottom: 0;
	display: none;
	height: 100%;
	opacity: 0.5;
	position: fixed;
	top: 0;
	width: 100%;
	z-index: 998;
}
</style>

<div id="popup" class="popup">
	<h2 class="popup-title">Новый заказ</h2>
	<div id="popup-content" class="popup-content">
		<div id="createOrderForm">		
			<form id="newOrder" name="newOrder" method="post">
			<?php if(isset($this->prop['order'])) : ?>
			<input type="hidden" name="orderId" value="<?= $this->prop['order']['properties'][0]['orderId']; ?>">
			<?php endif; ?>
				<div class="column410 flLeft clearfix">
					<div class="block410 orderClPhone">
						<label>Телефон 1<input type="text" name="customerPhone" value="<?= isset($this->prop['order']['properties'][0]['customerPhone']) ? $this->prop['order']['properties'][0]['customerPhone'] : '+380'; ?>"></label>
						<label>Телефон 2<input type="text" name="phone" value="<?= isset($this->prop['order']['properties'][0]['phone2']) ? $this->prop['order']['properties'][0]['phone2'] : '380'; ?>"></label>
					</div>
					
					<div class="slice"></div>
					
					<div id="points" class="block410">
						<h3>Маршрут</h3>

						<?
						if(isset($this->prop['order'])) {
						$points = $this->prop['order']['points'];
							for($i = 0; $i < count($points); $i++) {
							if(count($points) > 1 ) { $id = $i; $class = 'pointId'.$id; } else $class = "point";?>
							<div class="<?= $class; ?> point"><?
								?><label class="pointSLabel"><?= $i == 0 ? 'Откуда' : 'Куда'; ?><input type="text" class="pointAddr" name="point[<?= $i; ?>][S]" value="<?= substr($points[$i]['address'], 0, strpos($points[$i]['address'], ',')); ?>"></label>
								<label class="pointNLabel">Дом<input type="text" name="point[<?= $i; ?>][N]" value="<?= substr($points[$i]['address'], strpos($points[$i]['address'], ',')+2); ?>"></label><?
							if($i > 0) echo '<a class="plusWay" href="javascript:addPoint();"></a>';
							if($i > 1) echo '<a class="minusWay" href="javascript:removePoint(<?= $i; ?>);"></a>';
							?></div><?
							}
						}
						else {
							?><div class="point">
								<label class="pointSLabel">Откуда<input type="text" class="pointAddr" name="point[0][S]" value="<?= isset($this->prop['order'][0]['point_f']) ? substr($this->prop['order'][0]['point_f'], 0, strpos($this->prop['order'][0]['point_f'], ',')) : '';?>"></label>
								<label class="pointNLabel">Дом<input type="text" name="point[0][N]" value="<?= isset($this->prop['order'][0]['point_f']) ? substr($this->prop['order'][0]['point_f'], strpos($this->prop['order'][0]['point_f'], ',')+2) : '';?>"></label>
							</div>
							<div class="point">
								<label class="pointSLabel">Куда<input type="text" class="pointAddr" name="point[1][S]"></label>
								<label class="pointNLabel">Дом<input type="text" name="point[1][N]"></label>
								<a class="plusWay" href="javascript:addPoint();"></a>
							</div><?
						}
						?>
					</div>
					
					<div class="clearfix"></div>
					
					<div class="block410 way">
						<label><input type="radio" name="dir" value="oneWay" checked>В одну сторону</label>
						<label><input type="radio" name="dir" value="tnb">В две стороны</label>
						<div class="clearfix"></div>
					</div>
					
					<div class="slice"></div>

					<div class="block410 callsignsBlock">							
						<label><input type="checkbox" name="forcedOrder">Принудительный заказ</label>						
						
						<label class="callsigns clearfix">Позывные <input type="text" name="callsigns"></label>
						<label class="callsign clearfix">Позывной <input type="text" name="callsign"></label>
						
						<!--
						<label class="driverStatus">Статус <span>Свободен</span></label> 
						<label>Машина <span></span></label>
						<label>Водитель <span></span></label>
						<label>Телефон <span></span></label> 
						-->
					</div>					
				</div>
			
				<div class="column flRight">
					
					<div class="reserv">
						<label><input type="checkbox" name="reservation">Предварительный заказ</label>
						<input class="reservDate" type="text" name="reservDate">
						<input class="reservTime" type="text" name="reservTime">
					</div>
					
					<div class="slice"></div>
					
					<div id="fluidTariffing" class="block400 clearfix">
						<label>Гибкий тариф</label>
						<select name="tarif">
							<?php
							foreach($this->prop['tarifTypes'] as $type) {
								if(isset($this->prop['order'])) {
									if($this->prop['order']['properties'][0]['tarif'] == $type['id']) {
										echo '<option value="'.$type['id'].'" selected>'.$type['type'].'</option>';
									}
									else {
										echo '<option value="'.$type['id'].'">'.$type['type'].'</option>';
									}
								}
								else {
									if($type['type'] == 'Базовый') {
										echo '<option value="'.$type['id'].'" selected>'.$type['type'].'</option>';
									}
									else {
										echo '<option value="'.$type['id'].'">'.$type['type'].'</option>';
									}
								}
							}
							?>
						</select>
						<button>Показать</button>
					</div>
					
					<div class="slice"></div>
					
					<div class="block400 clearfix">
						<label class="regCustomer"><input type="checkbox" name="regularCustomer">Постоянный клиент</label>
						<input type="text">
						<label class="nonCashPayment"><input type="checkbox" name="nonCashPayment">Безналичный расчёт</label>
					</div>
					
					<div class="block400 clearfix">
						<div class="block190 extracard mr10">
							<label>Доп. карточка</label>
							<input type="text">
						</div>
						
						<div class="block190 voucher ml10">
							<label>Ваучер</label>
							<input type="text">
						</div>	
							
					</div>
					
					<div class="slice"></div>
					
					<div class="block400 clearfix">
						<div class="block190 mr10 flLeft options">
							<label><input type="checkbox" name="salonLoading" <? if(isset($this->prop['order']['properties'][0]['salonLoading'])) { if($this->prop['order']['properties'][0]['salonLoading'] == 0) { echo ''; } else { echo 'checked'; }} ?>>Загрузка салона</label>
							<label><input type="checkbox" name="animal" <? if(isset($this->prop['order']['properties'][0]['animal'])) { if($this->prop['order']['properties'][0]['animal'] == 0) { echo ''; } else { echo 'checked'; }} ?>>Животное</label>
							<label><input type="checkbox" name="city" <? if(isset($this->prop['order']['properties'][0]['city'])) { if($this->prop['order']['properties'][0]['city'] == 0) { echo ''; } else { echo 'checked'; }} ?>>По городу</label>
							<label><input type="checkbox" name="airCondition" <? if(isset($this->prop['order']['properties'][0]['airCondition'])) { if($this->prop['order']['properties'][0]['airCondition'] == 0) { echo ''; } else { echo 'checked'; }} ?>>Кондиционер</label>
							<label><input type="checkbox" name="courierDelivery" <? if(isset($this->prop['order']['properties'][0]['courierDelivery'])) { if($this->prop['order']['properties'][0]['courierDelivery'] == 0) { echo ''; } else { echo 'checked'; }} ?>>Курьер. доставка</label>
							<label><input type="checkbox" name="terminal" <? if(isset($this->prop['order']['properties'][0]['terminal'])) { if($this->prop['order']['properties'][0]['terminal'] == 0) { echo ''; } else { echo 'checked'; }} ?>>Терминал</label>
						</div>
						
						<div class="block190 ml10 flRight options">
							<label><input type="checkbox" name="nameSign" <? if(isset($this->prop['order']['properties'][0]['nameSign'])) { if($this->prop['order']['properties'][0]['nameSign'] == 0) { echo ''; } else { echo 'checked'; }} ?>>Встреча с табличкой</label>
							<label><input type="checkbox" name="hour" <? if(isset($this->prop['order']['properties'][0]['hour'])) { if($this->prop['order']['properties'][0]['hour'] == 0) { echo ''; } else { echo 'checked'; }} ?>>"Почасовка"</label>
							<label><input type="checkbox" name="grach" <? if(isset($this->prop['order']['properties'][0]['grach'])) { if($this->prop['order']['properties'][0]['grach'] == 0) { echo ''; } else { echo 'checked'; }} ?>>Пасс. с руки</label>
							<label><input type="checkbox" name="ticket" <? if(isset($this->prop['order']['properties'][0]['ticket'])) { if($this->prop['order']['properties'][0]['ticket'] == 0) { echo ''; } else { echo 'checked'; }} ?>>Чек</label>
							<label>Заметки для GPRS</label>
							<input type="text" name="gprsNotes">
						</div>
					</div>
					
					<div class="block400 clearfix">
						<div class="addr">
							<label>Адрес</label>
							<input type="text" name="addr" value="<?= isset($this->prop['order']['properties'][0]['address']) ? $this->prop['order']['properties'][0]['address'] : ''; ?>">
						</div>
						
						<div class="apartment flLeft">
							<label>Квартира</label>
							<input type="text" name="apartment" value="<?= isset($this->prop['order']['properties'][0]['apartment']) ? $this->prop['order']['properties'][0]['apartment'] : ''; ?>">
						</div>
						
						<div class="porch flLeft">
							<label>Подъезд</label>
							<input type="text" name="porch" value="<?= isset($this->prop['order']['properties'][0]['porch']) ? $this->prop['order']['properties'][0]['porch'] : ''; ?>">
						</div>
						
						<div class="customerName flLeft">
							<label>Имя клиента</label>
							<input type="text" name="customerName" value="<?= isset($this->prop['order']['properties'][0]['customerName']) ? $this->prop['order']['properties'][0]['customerName'] : ''; ?>">
						</div>
					</div>
					
					<div class="notesForDriver block400">
						<label>Заметки для водителя</label>
						<textarea class="block400" rows="" cols="" name="driverNote"><?= isset($this->prop['order']['properties'][0]['driver_note']) ? $this->prop['order']['properties'][0]['driver_note'] : ''; ?></textarea>
					</div>
					
					<div class="notesForDisp block400">
						<label>Заметки для диспетчера</label>
						<textarea class="block400" rows="" cols="" name="dispatcherNote"><?= isset($this->prop['order']['properties'][0]['dispatcher_note']) ? $this->prop['order']['properties'][0]['dispatcher_note'] : ''; ?></textarea>
					</div>
					
				</div>
				
				<div class="clear"></div>
				
				
				<div class="orderFormButtons">
					<button type="button" onclick="saveOrder();">Сохранить</button>
					<button type="button" onclick="<? if(isset($this->prop['order'])) : ?> setOrderEditMark(<?= $this->prop['order']['properties'][0]['orderId']; ?> , 0); <? endif; ?> cancelOrder();">Отменить</button>	
				</div>
				
			</form>
		</div>
	</div>
	
	<button id="btn-no" class="btn-no" <? if(isset($this->prop['order'])) : ?> onclick="setOrderEditMark(<?= $this->prop['order']['properties'][0]['orderId']; ?>, 0);" <? else : ?>  <? endif; ?>></button>
</div>
