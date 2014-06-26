/* 
 * Представление водителя в форме добавления/редактирования
 */
define([ 
    'jqueryui', 
    'underscore', 
    'backbone', 
    'dialog', 
    'general', 
    'templates'
], function($, _, Backbone, Dialog, General, templates){
    "use strict";
    
    return Backbone.View.extend({
        
        tagName: 'form',
        id: 'driverDetail',
        className: 'driverDetail group',
        attributes: { name: "driverDetail" },
        template: _.template(templates.driverDetail),
        
        formErrors: {},
        
        events: {
            "click #loadDriverPhoto"                            :       "loadDriverPhoto",
            "change #driverPhotoUpload"                         :       "selectFileHandler",
            "change input[name='driver[name]']"                 :       "checkName",
            "change input[name='driver[surname]']"              :       "checkSurname",
            "change input[name='driver[patronymic]']"           :       "checkPatronymic",
            "change input[name='driver[passport]']"             :       "checkPassport",
            "change input[name='driver[mobile_phone]']"         :       "checkPhone",
            "change input[name='driver[address]']"              :       "checkAddress",
            "change input[name='driver[callsign]']"             :       "checkCallsign",
            "change input[name='driver[dob]']"                  :       "checkDob",
            "change input[name='driver[admission_date]']"       :       "checkAdmissionDate",
            "change input[name='driver[password]']"             :       "checkPassword",
            "change input[name='car[commission]']"              :       "checkCarCommission",
            "change input[name='car[commission_period_pay]']"   :       "checkCarCommissionPeriodPay",
            "change input[name='car[fee]']"                     :       "checkCarFee",
            "change select[name='car[fee_period]']"             :       "checkCarFeePeriod",
            "change input[name='car[number]']"                  :       "checkCarNumber",
            "change input[name='car[model]']"                   :       "checkCarModel",
            "change input[name='car[year]']"                    :       "checkCarYear",
            "change select[name='car[color]']"                  :       "checkCarColor"
        },

        initialize: function() {
//            this.template = _.template($("#driverDetailTemplate").html());
//            this.listenTo(this.model, "change", this.update);
            this.listenTo(this.model, "invalid", this.displayError);
            this.listenTo(this.model, "removeFromCollection", this.remove);
        },
        
        render: function() {
            this.$el.append(this.template(this.model.toDetailForm()));
            this.createDialog();
            this.setUI();
            return this;
        },
        
        // Вызов в функции render
        setUI: function() {
            var datepickerFields = "input[name='driver[dob]'], input[name='driver[admission_date]'], input[name='driver[dismissal_date]']";
            
            this.$el.find(datepickerFields).datepicker({ 
                dateFormat: "dd-mm-yy", changeMonth: true, changeYear: true 
            });
        },
        
        // Вызов в функции render
        createDialog: function() {
            var options = {
                title: this.model.get("driver_id") ? "Редактирование данных": "Новый водитель",
                width: 850,
                height: 770,
                buttons: [
                    {
                        text: 'Сохранить',
                        click: $.proxy(this, 'saveDriver'),
                        id: 'saveDriver'
                    },
                    {
                        text: 'Отмена',
                        click: function(){ $(this).dialog("close"); }
                    }
                ]
            };
            this.dialog = new Dialog({widget: this, options: options});
        },
        
        update: function() {
            var view = this.template(this.model.toDetailForm());
            this.$el.html(view);
            return this;
        },
        
        displayError: function() {
            alert("Error: VDriverDetail/displayError");
        },
        
        saveDriver: function(){
            if(!(this.checkForm())) return;
            var dialog = this.dialog;
            this.dialog.showLoader();
            $("#saveDriver").attr("disabled", "disabled").addClass("ui-state-disabled");
            this.model.save(this.$el, function(result){
                dialog.removeLoader();
                dialog.close({ 
                    title: result.status, 
                    message: result.mes
                });
            });
        },

        checkForm: function(){
            return this.checkSurname() && this.checkName() && this.checkPatronymic() 
                    && this.checkDob() && this.checkPassport() && this.checkPhone() 
                    && this.checkAddress() && this.checkAdmissionDate() && this.checkPassword()
                    && this.checkCallsign() && this.checkCarCommission() && this.checkCarCommissionPeriodPay()
                    && this.checkCarFee() && this.checkCarFeePeriod() && this.checkCarNumber() 
                    && this.checkCarModel() && this.checkCarColor() && this.checkCarYear();
        },
        
        checkCarColor: function() {
            return this.checkField(this.$el.find('[name="car[color]"]'), this.model.checkCarColor);
        },
        
        checkCarYear: function() {
            return this.checkField(this.$el.find('[name="car[year]"]'), this.model.checkCarYear);
        },
        
        checkCarModel: function() {
            return this.checkField(this.$el.find('[name="car[model]"]'), this.model.checkCarModel);
        },
        
        checkCarNumber: function() {
            return this.checkField(this.$el.find('[name="car[number]"]'), this.model.checkCarNumber);
        },
        
        checkCarFeePeriod: function() {
            return this.checkField(this.$el.find('[name="car[fee_period]"]'), this.model.checkCarFeePeriod);
        },
        
        checkCarFee: function() {
            return this.checkField(this.$el.find('[name="car[fee]"]'), this.model.checkCarFee);
        },
        
        checkCarCommissionPeriodPay: function() {
            var $checked = this.$el.find('[name="car[commission_period_pay]"]:checked');
            if($checked.length === 0){
                this.$el.find("div.error").show().text("Необходимо заполнить поле 'Величина измерения'");
                this.$el.find('[name="car[commission_period_pay]"]').closest("div").addClass('errorField');
            }
            else {
                this.$el.find("div.error").hide().text('');
                this.$el.find('[name="car[commission_period_pay]"]').closest("div").removeClass('errorField');
                return true;
            }
        },
        
        checkCarCommission: function() {
            return this.checkField(this.$el.find('[name="car[commission]"]'), this.model.checkCarCommission);
        },
        
        checkPassword: function() {
            return this.checkField(this.$el.find('[name="driver[password]"]'), this.model.checkPassword);
        },
        
        checkAdmissionDate: function() {
            return this.checkField(this.$el.find('[name="driver[admission_date]"]'), this.model.checkAdmissionDate);
        },
        
        checkDob: function() {
            return this.checkField(this.$el.find('[name="driver[dob]"]'), this.model.checkDob);
        },
        
        checkName: function() {
            return this.checkField(this.$el.find('[name="driver[name]"]'), this.model.checkName);
        },
        
        checkSurname: function() {
            return this.checkField(this.$el.find('[name="driver[surname]"]'), this.model.checkSurname);
        },
        
        checkPatronymic: function() {
            return this.checkField(this.$el.find('[name="driver[patronymic]"]'), this.model.checkPatronymic);
        },
        
        checkPassport: function() {
            return this.checkField(this.$el.find('[name="driver[passport]"]'), this.model.checkPassport);
        },
        
        checkPhone: function() {
            return this.checkField(this.$el.find('[name="driver[mobile_phone]"]'), this.model.checkPhone);
        },
        
        checkAddress: function() {
            return this.checkField(this.$el.find('[name="driver[address]"]'), this.model.checkAddress);
        },
        
        checkCallsign: function() {
            return this.checkField(this.$el.find('[name="driver[callsign]"]'), this.model.checkCallsign);
        },
        
        checkField: function($field, checkFunc) {
            var value = $.trim($field.val());
            $field.val(value);
            try {
                checkFunc.call(this.model, value);
                $field.removeClass('error');
                this.removeError($field);
                return true;
            }
            catch(e)
            {
                $field.focus();
                $field.addClass('error');
                this.showError($field, e.message);
            }
        },
        
        showError: function($field, message) {
            
            this.removeError($field);
            this.$el.find("div.error p").remove();
            
            this.formErrors[$field.attr("name")] = message;
            var $errElem = this.$el.find("div.error");
            for(var err in this.formErrors){
                $errElem.append( $("<p></p>").attr("data-error-field", err).text(this.formErrors[err]) );
            }
            if($errElem.find("p").length > 0)
                $errElem.show();
        },
        
        removeError: function($field) {
            delete this.formErrors[$field.attr("name")];
            this.$el.find("div.error p[data-error-field='" + $field.attr("name") + "']").remove();
            if(this.$el.find("div.error p").length === 0)
                this.$el.find("div.error").hide();
        },
        
        // 
        loadDriverPhoto: function(){
            this.$el.find("#driverPhotoUpload").click();
        },
        
        selectFileHandler: function(e){
            var view = this;
            var files = e.target.files; // получаем объект FileList 

            for(var i = 0; i < files.length; i++) {    
                var file = files[i];
                // Если в файле содержится изображение
                if(/image.*/.test(file.type)) {
                    var fr = new FileReader();
                    // считываем его в строку base64
                    fr.readAsDataURL(file);
                    // как только файл загружен
                    fr.onload = function (e) {         
                        var img = new Image();       
                        img.src = e.target.result;
                        img.onload =  function () {
                            img = General.makePreview(img, 128);
                            view.$el.find("div.photo img").attr("src", img.src);
                        };
                    };
                }
            }
        }
    });
    
});

