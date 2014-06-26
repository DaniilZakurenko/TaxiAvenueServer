<?php
if(isset($this->prop['commonTariffication'])){
    $ct = $this->prop['commonTariffication'];
}
?>

<?php $reservationOrderExtraValue = isset($ct->reservationOrderExtra->value) ? $ct->reservationOrderExtra->value : ''; ?>
<label class="extraReservationField"><span>Наценка стоимости предварительного заказа</span><input type="text" name="commonTariff[reservationOrderExtra][value]" value="<?= $reservationOrderExtraValue; ?>"> грн.</label>

<?php $eachPointExtraPoint = isset($ct->eachPointExtra->point) ? $ct->eachPointExtra->point : ''; ?>
<?php $eachPointExtraValue = isset($ct->eachPointExtra->value) ? $ct->eachPointExtra->value : ''; ?>
<div class="extraPointField"><span>К тарифу после</span> <input type="text" name="commonTariff[eachPointExtra][point]" value="<?= $eachPointExtraPoint; ?>"><span> -ой точки прибавляется </span><input type="text" name="commonTariff[eachPointExtra][value]" value="<?= $eachPointExtraValue; ?>"><span> грн.за каждую точку</span></div>

<div class="services group">
    <div class="orderAdditionalServices">
    <? foreach($this->prop['additionalServices'] as $service) : ?>
        <div class="orderAdditionalService group">
            <label class="orderAdditionalServiceName"><span><?= $service['title']; ?></span> + <input type="text" name="additionalService[<?= $service['id']; ?>][<?= $service['name']; ?>][value]" value="<?= $service['value']; ?>"></label>
            <label class="orderAdditionalServiceUAH"><input type="radio" name="additionalService[<?= $service['id']; ?>][<?= $service['name']; ?>][type]" value="UAH" <? if($service['type'] == 'UAH') echo ' checked'; ?>> грн.</label>
            <label class="orderAdditionalServicePct"><input type="radio" name="additionalService[<?= $service['id']; ?>][<?= $service['name']; ?>][type]" value="PCT" <? if($service['type'] == 'PCT') echo ' checked'; ?>> %</label>
        </div>
    <? endforeach; ?>				
    </div>

    <div class="addNewAdditionalService"></div>
</div>

<div class="extraSnow group">
    <? $snowExtraActive = isset($ct->snowExtra->active) && $ct->snowExtra->active == true ? 'checked' : ''; ?>
    <? $snowExtraValue = isset($ct->snowExtra->value) ? $ct->snowExtra->value : ''; ?>
    <? $snowExtraType = isset($ct->snowExtra->type) ? $ct->snowExtra->type : ''; ?>

    <input type="checkbox" name="commonTariff[snowExtra][active]" <?= $snowExtraActive; ?>>
    <label>Включить наценку на снег</label>
    <input type="text" name="commonTariff[snowExtra][value]" value="<?= $snowExtraValue; ?>">
    <label><input type="radio" name="commonTariff[snowExtra][type]" value="UAH" <? if($snowExtraType == 'UAH') : ?> checked <? endif; ?>> грн.</label>
    <label><input type="radio" name="commonTariff[snowExtra][type]" value="PCT" <? if($snowExtraType == 'PCT') : ?> checked <? endif; ?>> %</label>
</div>

<div class="extraNonCash">
        <? $nonCashValue = isset($ct->nonCash->value) ? $ct->nonCash->value : ''; ?>

        <label>Наценка на безнал</label>
        <input type="text" name="commonTariff[nonCash][value]" value="<?= $nonCashValue; ?>">
        <label>%</label>
</div>

<div class="extraSector group">
        <label>Наценка на сектора</label>
        <label class="extraSectorDayOff"><input type="checkbox" disabled>Не распространять наценку на суб/воскр</label>
        <label class="extraSectorSumm"><input type="checkbox" disabled>Суммировать наценку на сектора подачи и назначения</label>
</div>

<? $grachValue = isset($ct->grach->value) ? $ct->grach->value : ''; ?>
<label class="extraPassenger">Надбавка для пассажира с руки<input type="text" name="commonTariff[grach][value]" value="<?= $grachValue; ?>">%</label>

<label class="distancesConversionRate">Коэффициент пересчёта расстояний:<input type="text" disabled></label>

<label class="useOldCountryRouteScheme"><input type="checkbox" disabled>Использовать старую схему расчёта загородных маршрутов</label>