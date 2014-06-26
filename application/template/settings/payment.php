<style>
#showCashPayment input[type="text"] {
	width: 50px;
}

#showCashPayment table td {
	min-width: 80px;
	max-width: 80px;
	text-align: center;
}

#showCashPayment table th {
	min-width: 80px;
	max-width: 160px;	
}

#showCashPayment table th span {
	display: block;
	-moz-transform: rotate(300deg);
	line-height: 15px;
	padding-bottom: 25px;
	font-size: 12px;
	font-style: normal;
}

#showCashPayment table th:first-child, 
#showCashPayment table td:first-child {
	width: 200px;
}


</style>

<div id="showCashPayment">
	<form>
		<a href="javascript:back('#showCashPayment', '#tariffingSettings');">Назад</a>
		<table>
			<tr height="60px">
				<th></th>
				<th width="96px"><span>Гибкий тариф (грн/км)</span></th>
				<th width="96px"><span>Добавочная стоимость (грн)</span></th>
				<th width="96px"><span>Минимум для гибкого тарифа (грн)</span></th>
				<th width="96px"><span>Учитывать км в минимуме</span></th>
				<th width="96px"><span>Простой (грн/мин)</span></th>
				<th width="96px"><span>Почасовой тариф (грн/минуту)</span></th>
				<th width="96px"><span>Минимальный почасовой тариф (грн/час)</span></th>
				<th width="96px"><span>Тариф за город в один конец (грн за 1 км)</span></th>
				<th width="96px"><span>Тариф за город в оба конца (грн за 1 км)</span></th>
			</tr>		
			<?php 
			foreach($this->prop['tarif'] as $tarif) {
				echo '<tr>';
					echo '<td>'.$tarif['type'].'</td>';
					echo '<td><input type="text" name="'.$tarif['typeId'].'[fluidTarrification]" value="'.$tarif['fluidTarrification'].'"></td>';
					echo '<td><input type="text" name="'.$tarif['typeId'].'[extraCost]" value="'.$tarif['extraCost'].'"></td>';
					echo '<td><input type="text" name="'.$tarif['typeId'].'[fluidTarifMin]" value="'.$tarif['fluidTarifMin'].'"></td>';
					echo '<td><input type="text" name="'.$tarif['typeId'].'[kmMin]" value="'.$tarif['kmMin'].'"></td>';
					echo '<td><input type="text" name="'.$tarif['typeId'].'[downtime]" value="'.$tarif['downtime'].'"></td>';
					echo '<td><input type="text" name="'.$tarif['typeId'].'[hourTarif]" value="'.$tarif['hourTarif'].'"></td>';
					echo '<td><input type="text" name="'.$tarif['typeId'].'[minHourTarif]" value="'.$tarif['minHourTarif'].'"></td>';
					echo '<td><input type="text" name="'.$tarif['typeId'].'[ootOneWayTarif]" value="'.$tarif['ootOneWayTarif'].'"></td>';
					echo '<td><input type="text" name="'.$tarif['typeId'].'[ootTnbTarif]" value="'.$tarif['ootTnbTarif'].'"></td>';
				echo '</tr>';
			}
			?>		
		</table>
		
		<input type="submit" value="Сохранить">
	</form>
</div>