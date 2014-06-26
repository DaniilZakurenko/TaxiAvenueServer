<style>
.popup {
	//background: url(../images/bg-popup.png) -5px -5px;
	background-color: white;
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
	border-radius: 6px 6px 0 0;
	font-family: 'HelveticaNeue', sans-serif;
	font-size: 17px;
	height: 43px;
	line-height: 43px;
	padding: 0 0 0 16px;
	text-shadow: 0 1px 0 rgba(255, 255, 255, .5);
	box-shadow: inset 0 1px 1px #e6edef;
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
	height: 35px;
	line-height: 35px;
	position: relative;
	text-shadow: 0 1px 0 rgba(255, 255, 255, .4);
	width: 99px;
}
.btn-yes:active,
.btn-no:active {
	top: 1px;
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
			<input type="hidden" name="orderId" value="<?= $this->prop['order'][0]['orderId']; ?>">
			<?php endif; ?>
			
				<label>Имя</label><input type="text" name="name" value="<?= isset($this->prop['order'][0]['name']) ? $this->prop['order'][0]['name'] : ''; ?>"><br>
				<label>Телефон</label><input type="text" name="phone" value="<?= isset($this->prop['order'][0]['phone']) ? $this->prop['order'][0]['phone'] : ''; ?>"><br>
				
				<div id="points">					
					<?php
					if(isset($this->prop['order'])) {
						$points = explode('|', $this->prop['order'][0]['points']);						
						for($i = 0; $i < count($points); $i++) {						
							?>
							<? if(count($points) > 1 ) { $id = $i; $class = 'pointId'.$id; } else $class = "point"; ?>
							<div class="<?= $class; ?>">
								<label>Куда</label><input type="text" class="pointAddr" name="point[<?= $i; ?>][S]" value="<?= substr($points[$i], 0, strpos($points[$i], ',')); ?>">
								<label>Дом</label><input type="text" name="point[<?= $i; ?>][N]" value="<?= substr($points[$i], strpos($points[$i], ',')+2); ?>">
								<a href="javascript:addPoint();">+</a>
								<? if($i > 0 ) : ?><a href="javascript:removePoint(<?= $i; ?>);">-</a><? endif; ?>
							</div><br>
							<?php
						}
					}
					else {
					?>
					<div class="point">
						<label>Откуда</label><input type="text" class="pointAddr" name="point[0][S]" value="<?= isset($this->prop['order'][0]['point_f']) ? substr($this->prop['order'][0]['point_f'], 0, strpos($this->prop['order'][0]['point_f'], ',')) : '';?>">
						<label>Дом</label><input type="text" name="point[0][N]" value="<?= isset($this->prop['order'][0]['point_f']) ? substr($this->prop['order'][0]['point_f'], strpos($this->prop['order'][0]['point_f'], ',')+2) : '';?>">
					</div><br>
					<div class="point">
						<label>Куда</label><input type="text" class="pointAddr" name="point[1][S]">
						<label>Дом</label><input type="text" name="point[1][N]">
						<a href="javascript:addPoint();">+</a>
					</div><br>
					<?php } ?>
				</div>
				
				<label>Тип заказа</label>
				<select name="type">
					<option value="1">Заказ</option>
					<option value="2">Срочно</option>
					<option value="3">Предзаказ</option>
				</select>
				<br>
				<label>Расчёт</label>
				<select id="payment" name="payment">
					<option value="cash_payment_tarif" selected>Наличный</option>
					<option value="name_cash_payment_tarif">Безналичный</option>
				</select>
				<br>
				<label>Тарификация</label>
				<select name="tariffing">
					<option value="fluid">Гибкая</option>
					<option value="overall">Общая</option>
				</select>
				<br>
				
				<div id="fluidTariffing">
					<label>Тариф</label>
					<select name="tarif">
						<?php
						foreach($this->prop['tarifTypes'] as $type) {
							if(isset($this->prop['order'])) {
								if($this->prop['order'][0]['tarif'] == $type['id']) {
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
				</div>
				
				<div id="overallTariffing">
				</div>
				
				<div>
				<label>Позывной водителя</label>
				<input type="text" name="driverCallsign" value="11">
				</div>
				
				<button type="button" onclick="cancelOrder();">Отменить</button>
			</form>
		</div>
	</div>
	
	<button type="button" onclick="saveOrder();">Сохранить</button>
	
	<button id="btn-no" class="btn-no">Закрыть</button>
</div>