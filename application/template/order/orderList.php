<?php
/*
 * <?php 
	foreach($this->prop['orders'] as $order) {
            
	}
	$statusList = $this->prop['statusList'];
	?>
	<tr id="orderID<?php echo $order['orderId']; ?>">
		<td><?php echo $order['orderId'];  ?></td>
		<td><?php echo !empty($order['callsign']) ? $order['callsign'] : 'Заказ в эфире'; ?></td>
		<td><?php echo $order['name']; ?></td>
		<td><?php echo $order['phone']; ?></td>
		<td><?php echo str_replace('|', '; ', $order['points']); ?></td>
		<td><?php echo $order['cost']; ?></td>
		<td><?php 				
			for($i = 0, $statusCount = count($statusList); $i < $statusCount; $i++) {
                            if($statusList[$i]['id'] == $order['status']) {
                                echo $statusList[$i]['name']; break; 
                            }
			}
                    ?>
                </td>
	</tr>
 */
$statusList = $this->prop['statusList'];
?>
<table class="orderList">
	<tr>
		<th>Действия</th>
		<th>Позывной</th>
		<th>Клиент</th>
		<th>Телефон</th>
		<th>Маршрут</th>
		<th>Стоимость</th>
		<th>Статус</th>
	</tr>
	<tbody>
        <?php foreach($this->prop['orders'] as $order): ?>
        <tr id="<?php echo $order['orderId']; ?>">
        	<td class="actions">
				<img title="Смотреть на карте" class="view" src="<? URL; ?>images/view.png" />
				<img title="Редактировать" class="edit" src="<? URL; ?>images/edit.png" />
				<img title="Выполнить" class="perform" src="<? URL; ?>images/perform.png" />
				<img title="Удалить" class="delete" src="<? URL; ?>images/delete.png" />
			</td>
			<td><?php echo !empty($order['callsign']) ? $order['callsign'] : 'Заказ в эфире'; ?></td>
			<td><?php echo $order['name']; ?></td>
			<td><?php echo $order['phone']; ?></td>
			<td><?php echo str_replace('|', '; ', $order['points']); ?></td>
			<td><?php echo $order['cost']; ?></td>
			<td class="status id_<?= $order['status']; ?>>"><?php 				
				for($i = 0, $statusCount = count($statusList); $i < $statusCount; $i++) {
	                            if($statusList[$i]['id'] == $order['status']) {
	                                echo $statusList[$i]['name']; break; 
	                            }
				}
	                    ?>
	                </td>
		</tr>
        <?php endforeach; ?>
	</tbody>
</table>