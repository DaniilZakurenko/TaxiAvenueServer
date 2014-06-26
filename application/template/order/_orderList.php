<table class="orderList" border="1">
	<tr>
		<th>ID</th>
		<th>Позывной</th>
		<th>Клиент</th>
		<th>Телефон</th>
		<th>Маршрут</th>
		<th>Стоимость</th>
		<th>Статус</th>
	</tr>
	<?
	foreach($this->prop['orders'] as $order) {
		/*switch($order['status']) {
			case '6': $background = '#FFF'; break;
			case '7': $background = '#fff604'; break;
			case '18': $background = '#eeeeee'; break;
		}
		*/
	}
	$statusList = $this->prop['statusList'];
	?>
	<tr id="orderID<?= $order['orderId']; ?>">
		<td><?= $order['orderId'];  ?></td>
		<td><?= !empty($order['callsign']) ? $order['callsign'] : 'Заказ в эфире'; ?></td>
		<td><?= $order['name']; ?></td>
		<td><?= $order['phone']; ?></td>
		<td><?= str_replace('|', '; ', $order['points']); ?></td>
		<td><?= $order['cost']; ?></td>
		<td><?				
			for($i = 0, $statusCount = count($statusList); $i < $statusCount; $i++) {
					if($statusList[$i]['id'] == $order['status']) { ?>
						<?= $statusList[$i]['name']; break; ?>
					<? }
			}
		?>
		</td>
	</tr>
</table>