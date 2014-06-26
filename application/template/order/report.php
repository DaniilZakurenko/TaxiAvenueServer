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
	<h2 class="popup-title">Отчёт по заказам</h2>
	<div id="popup-content" class="popup-content">
	
	<table>
		<tr>
			<th>ID</th>
			<th>Позывной</th>
			<th>Откуда</th>
			<th>Куда</th>
			<th>Стоимость</th>
			<th>Диспетчер</th>
			<th>Имя клиента</th>
			<th>Телефон клиента</th>
			<th>Статус заказа</th>
		</tr>
		<?php 
		foreach($this->prop['orders'] as $order) {
			?>
			<tr>
				<td><?= $order['id']; ?></td>
				<td><?= $order['driver']; ?></td>
				<td><?= $order['point_f']; ?></td>
				<td><?= $order['points']; ?></td>
				<td><?= $order['cost']; ?></td>
				<td><?= $order['dispatcher']; ?></td>
				<td><?= $order['name']; ?></td>
				<td><?= $order['phone']; ?></td>
				<td><?= $order['status'] == 3 ? 'Выполнен' : '' ?></td>
			</tr>
			<?php 
		}
		?>
	</table>
	
	</div>
	<button id="btn-no" class="btn-no">Закрыть</button>
</div>