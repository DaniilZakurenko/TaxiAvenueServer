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

<div id="tariffingSettings">
	<a href="javascript:back('#tariffingSettings', '#settingsListPopup');">Назад</a>
	<h2>Гибкая тарификация</h2>
	<ul>
		<li><a href="javascript:showTarifGrid('cash_payment_tarif');">Наличный расчёт</a></li>
		<li><a href="javascript:showTarifGrid('non_cash_payment_tarif');">Безналичный расчёт</a></li>
		<li><a href="javascript:showTariffing();">Расчёт заказов через центр</a></li>
	</ul>
	<hr>
	<h2>Общая тарификация</h2>
	<ul>
		<li><a href="javascript:showTariffing();">Общий тариф</a></li>
		<li><a href="javascript:showTariffing();">Наценки</a></li>
		<li><a href="javascript:showTariffing();">Клиентская тарификация</a></li>
		<li><a href="javascript:showTariffing();">Гибкая скидка</a></li>
	</ul>
</div>