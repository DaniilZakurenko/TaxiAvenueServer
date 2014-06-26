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
	<h2 class="popup-title">Отчёт по водителям</h2>
	<div id="popup-content" class="popup-content">
		<div id="driverReportWindow">		
			<div>
				<div class="reportDateInterval">
					<input type="text" name="reportDateFrom">
					<input type="text" name="reportDateTo">
					<a href="javascript:getDriverReport()">Сформировать отчёт</a>
				</div>
			
				<div class="driverReport">
					<?= $this->prop['drivers']; ?>
				</div>
			</div>
		</div>
	</div>
	
	<button id="btn-no" class="btn-no"></button>
</div>