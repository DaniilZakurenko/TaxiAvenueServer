<style>
.popup {
	//background: url(../images/bg-popup.png) -5px -5px;
	background-color: #eceae8;
	border: 5px solid rgba(197, 192, 192, .7);
	border-radius: 10px;
	//height: 760px;
	position: absolute;
	//width: 1095px!important;
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
.aButton {
    display: block;
    border: 1px solid #989390;
    text-align: center;
    padding: 10px 1px 10px 1px;
    width: 140px;
    float: right;
    margin:10px 18px 10px 10px;
    text-decoration: none;
    color: #222;
}
.driverSearchCallsign{
    margin: 20px 10px 10px 20px;

}
.driverSearchCallsign input{
    width: 70px;
    margin-top: 20px;
    margin-left: 5px;
}
#driverListTable{
    width: 100%;
    min-width: inherit;
}
#driverListTable tbody tr th{
    background-color: #989390;
    padding-top: 5px;
    padding-bottom: 5px;
    width: inherit;
    min-width: inherit;
    
}

#driverListTable tbody{

}
</style>

<div id="popup" class="popup">
	<h2 class="popup-title">Сведения о водителях</h2>

	<div id="popup-content" class="popup-content">
	<!-- <p class="popup-warning">Lorem Ipsum is simply dummy text of the printing and typesetting industry.</p> -->
		<!-- <div class="popup-choice"></div> -->
		<div id="driversListPopup">
			<div style=" width: auto; height: 50px; ">
		        <label class="driverSearchCallsign"> Позывной <input type="text"  ></label>
			    <a class="aButton" href="javascript:addDriverForm();">Добавить машину</a>
		    </div>
		<?php
			$str = '';
			$str .= '<table border=1 id="driverListTable">';
			$str .= '<tr>';
			$str .= '<th ></th>';
			$str .= '<th name="callsign" onclick="ShowSort(this)">Позывной</th>';
			$str .= '<th name="surname" onclick="ShowSort(this)">Фамилия</th>';
			$str .= '<th name="name" onclick="ShowSort(this)">Имя</th>';
			$str .= '<th name="patronymic" onclick="ShowSort(this)">Отчество</th>';
			$str .= '<th name="number" onclick="ShowSort(this)">Номер</th>';
			$str .= '<th name="model" onclick="ShowSort(this)">Марка</th>';
			$str .= '<th name="color" onclick="ShowSort(this)">Цвет</th>';
			$str .= '<th name="type" onclick="ShowSort(this)">Тип</th>';
			$str .= '<th name="notes" onclick="ShowSort(this)">Заметки</th>';
			$str .= '</tr>';
			foreach($this->prop['drivers']['driverList'] as $driver) {
				$str .= '<tr id="driver'.$driver['id'].'">';
				$str .= '<td class="drivertr">';
				$str .= '<span class="spanArrow"> </span>';
                $str .= '</td>';
					//$str .= '<td><input class="disabledField" style="width:55px;" type="text" name="driver[callsign]" value="'.$driver['callsign'].'" disabled></td>';
					$str .= '<td>'.$driver['callsign'].'</td>';
					$str .= '<td><input class="disabledField" type="text" name="driver[surname]" value="'.$driver['surname'].'" disabled></td>';
					$str .= '<td><input class="disabledField" type="text" name="driver[name]" value="'.$driver['name'].'" disabled></td>';
					$str .= '<td><input class="disabledField" type="text" name="driver[patronymic]" value="'.$driver['patronymic'].'" disabled></td>';
					$str .= '<td><input class="disabledField" style="width:55px; type="text" name="car[number]" value="'.$driver['number'].'" disabled></td>';
					$str .= '<td><input class="disabledField" style="width:55px; type="text" name="car[model]" value="'.$driver['model'].'" disabled></td>';
					$str .= '<td><input class="disabledField" style="width:55px; type="text" name="car[color]" value="'.$driver['color'].'" disabled></td>';
					$str .= '<td><input class="disabledField" style="width:55px; type="text" name="car[type]" value="'.$driver['type'].'" disabled></td>';
					//$str .= '<td></td>';
					$str .= '<td><textarea class="disabledField" name="car[notes]" disabled>'.$driver['notes'].'</textarea></td>';
				$str .= '</tr>';
			}
			$str .= '</table>';
			echo $str;
		?>
		<? //print_r($this->drivers); ?>
		</div>		
  	</div>
  	<button id="btn-no" class="btn-no"></button>
	<!-- <button id="btn-yes" class="btn-yes">Yes</button> -->
	<!--<button id="btn-no" class="btn-no">Закрыть</button> -->
	<!-- <div class="btn-close"></div> -->
</div>
<style>

</style>