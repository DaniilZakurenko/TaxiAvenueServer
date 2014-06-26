<table>
    <thead>
        <tr>
            <th></th>
            <th>Гибкий тариф (грн/км)</th>
            <th>Добавочная стоимость (грн)</th>
            <th>Минимум для гибкого тарифа (грн)</th>
            <th>Учитывать км в минимуме</th>
            <th>Простой<br>(грн/мин)</th>
            <th>Почасовой тариф<br>(грн/минуту)</th>
            <th>Минимальный почасовой тариф<br>(грн/час)</th>
            <th>Тариф за город в один конец<br>(грн за 1 км)</th>
            <th>Тариф за город в оба конца<br>(грн за 1 км)</th>
        </tr>
    </thead>
    <tbody>
        <?php 
        foreach($this->prop['tarif'] as $tarif) {				
            echo '<tr>';
                echo '<th>'.$tarif['type'].'</th>';
                echo '<td><input type="text" name="'.$tarif['typeId'].'[fluidTarification]" value="'.$tarif['fluidTarification'].'" disabled></td>';
                echo '<td><input type="text" name="'.$tarif['typeId'].'[extraCost]" value="'.$tarif['extraCost'].'" disabled></td>';
                echo '<td><input type="text" name="'.$tarif['typeId'].'[fluidTarifMin]" value="'.$tarif['fluidTarifMin'].'" disabled></td>';
                echo '<td><input type="text" name="'.$tarif['typeId'].'[kmMin]" value="'.$tarif['kmMin'].'" disabled></td>';
                echo '<td><input type="text" name="'.$tarif['typeId'].'[downtime]" value="'.$tarif['downtime'].'" disabled></td>';
                echo '<td><input type="text" name="'.$tarif['typeId'].'[hourTarif]" value="'.$tarif['hourTarif'].'" disabled></td>';
                echo '<td><input type="text" name="'.$tarif['typeId'].'[minHourTarif]" value="'.$tarif['minHourTarif'].'" disabled></td>';
                echo '<td><input type="text" name="'.$tarif['typeId'].'[ootOneWayTarif]" value="'.$tarif['ootOneWayTarif'].'" disabled></td>';
                echo '<td><input type="text" name="'.$tarif['typeId'].'[ootTnbTarif]" value="'.$tarif['ootTnbTarif'].'" disabled></td>';
            echo '</tr>';
        }
        ?>
    </tbody>
</table>
