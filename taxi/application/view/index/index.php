<?php 
/*
 * 
 */
?>
<div id="application">
    <div class="menu_icons">
        <div class="data_table">
            <p>Таблица данных</p>
            <ul class="icons">
                <li class="showDrivers"><img src="<?= URL; ?>images/car.png" title="Водители"></li>
                <li class="menu_disable"><img src="<?= URL; ?>images/taxist.png"></li>
                <li class="menu_disable showDispatchers"><img src="<?= URL; ?>images/naushniki1.png" title="Диспетчера"></li>
                <li class="showClients"><img src="<?= URL; ?>images/rlienty1.png" title="Клиенты"></li>
            </ul>
        </div>
        <div class="black_list">
            <p>Черный список</p>
            <ul class="icons">
                <li class="menu_disable"><img src="<?= URL; ?>images/taxist_stop.png"></li>
                <li class="menu_disable"><img src="<?= URL; ?>images/klienty.png"></li>
            </ul>
        </div>
        <div class="reports">
            <p>Отчеты</p>
            <ul class="icons">
                <li class="menu_disable"><img src="<?= URL; ?>images/taxist_ramka.png" title="Отчёт о работе водителей"></li>
                <li class="orderReport"><img src="<?= URL; ?>images/paper.png" title="Отчёт по заказам"></li>
                <!--  <li class="menu_disable"><a href="#"><img src="<? URL; ?>images/paper.png"></a></li> -->
                <li class="menu_disable"><img src="<?= URL; ?>images/naushniki.png"></li>
                <li class="menu_disable"><img src="<?= URL; ?>images/taxist_clocks.png"></li>
                <li class="menu_disable"><img src="<?= URL; ?>images/grafik.png"></li>
                <li class="menu_disable"><img src="<?= URL; ?>images/shema.png"></li>
                <li class="menu_disable"><img src="<?= URL; ?>images/cloud.png"></li>
            </ul>
        </div>
        <div class="messages">
            <p>Сообщения</p>
            <ul class="icons">
                <li class="menu_disable"><img src="<?= URL; ?>images/enlevope_eye.png"></li>
                <li class="menu_disable"><img src="<?= URL; ?>images/envelops.png"></li>
            </ul>
        </div>
        <div class="control">
            <p>Управление</p>
            <ul class="icons">
                <li class="menu_disable"><img src="<?= URL; ?>images/taxists.png"></li>
                <li class="showSettings"><img src="<?= URL; ?>images/key.png" title="Настройки"></li>
                <li class="menu_disable"><img src="<?= URL; ?>images/window.png"></li>
            </ul>
        </div>
    </div>
    <div class="information_block">
        <div class="menu_bottom">
            <ul>
                <li class="create group"><span></span>Создать заказ</li>
                <li class="map group"><span></span>Открыть карту</li>
            </ul>
        </div>

        <div id="ordersLayout" class="tabs_section">
            <div class="nav_block">
                <ul class="tabs">
                    <li class="file"><a href="#tabs-1">Горячие<span class="corner"></span></a></li>
                    <li class="clock"><a href="#tabs-2">Предварительные<span class="corner"></span></a></li>
                    <li class="galochka"><a href="#tabs-3">Выполняющиеся<span class="corner"></span></a></li>
                </ul>
            </div>
            <div id="tabs-1" class="tab"></div>
            <div id="tabs-2" class="tab"></div>
            <div id="tabs-3" class="tab"></div>
        </div>
    </div>
</div>

<div id="orderListStart">
    <?php foreach($this->prop['orderList'] as $order): ?>
    <div id="<?php echo $order['orderId']; ?>">
        
        <?php foreach($order as $field => $value): ?>
        
        <?php if(!is_array($value)): ?>
        <input type="hidden" class="<?php echo $field; ?>" name="<?php echo $field; ?>" value="<?php echo $value; ?>">
        <?php else: ?>
            <?php if($field == 'points'): ?>
            <div class="points">
                <?php for($i = 0, $pointsCnt = count($value); $i < $pointsCnt; $i++): ?>
                <div class="point">
                    <input type="hidden" class="pointId" name="pointId" value="<?php echo $value[$i]['point_id']; ?>">
                    <input type="hidden" class="street" name="street" value="<?php echo $value[$i]['point']['street']; ?>">
                    <input type="hidden" class="number" name="number" value="<?php echo $value[$i]['point']['number']; ?>">
                    <div class="location">
                        <input type="hidden" class="lat" name="lat" value="<?php echo $value[$i]['location']->lat; ?>">
                        <input type="hidden" class="lng" name="lng" value="<?php echo $value[$i]['location']->lng; ?>">
                    </div>
                </div>
                <?php endfor; ?>
            </div>
            <?php endif; ?>
        <?php endif; ?>
        
        <?php endforeach; ?>
        
    </div>
    <?php endforeach; ?>
</div>
<!-- -->
<footer>
    <!--  
    <div id="clientMapWrap">
        <img title="Закрыть карту" class="hideMap" src="<?php //echo URL; ?>images/delete.png">
        <div id="clientMap"></div>
    </div>
    -->    
    <script data-main="scripts/main" src="<?php echo URL; ?>scripts/libs/RequireJS/RequireJS.js"></script>
</footer>