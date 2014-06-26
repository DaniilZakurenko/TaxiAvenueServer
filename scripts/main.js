/*
 * 
 */
require.config({
    
    baseUrl: "scripts",
    
    // Предотвращает кэширование браузером скриптов. (Отключить в рабочей версии)
    urlArgs: "v=" +  (new Date()).getTime(),
    
    paths: {
        'jquery'        : 'libs/jquery/jquery-2.0.3.min',
        'jqueryForm'    : 'libs/jquery/jquery.form',
        'jqueryui'      : 'libs/jquery/jquery-ui-1.10.4.custom.min',
        'dateFormat'    : 'libs/jquery/jquery.dateFormat',
//        'pagination'    : 'libs/jquery/jquery.jqpagination',
        'underscore'    : 'libs/underscore/underscore',
        'backbone'      : 'libs/backbone/backbone',
//        'paginator'     : 'libs/backbone/backbone.paginator',
//        'babysitter'    : 'libs/backbone/backbone.babysitter',
//        'wreqr'         : 'libs/backbone/backbone.wreqr',
//        'marionette'    : 'libs/backbone/backbone.marionette',
        'text'          : 'libs/RequireJS/text'
    },
    
    shim: {
//        pagination : {
//            deps    : ['jquery'],
//            exports : '$.jqPagination'
//        },
//        jqueryui : {
//            deps    : ['jquery', 'jqueryForm', 'dateFormat', 'pagination'],
//            exports : '$'
//        },
        jqueryui : {
            deps    : ['jquery', 'jqueryForm', 'dateFormat'],
            exports : '$'
        },
        underscore : {
            exports : '_'
        },
        backbone : {
            deps    : ['underscore', 'jquery'],
            exports : 'Backbone'
        }
//        'paginator': {
//            deps    : ['backbone'],
//            exports : 'Backbone.PageableCollection'
//        },
//        marionette : {
//            deps    : ['backbone'],
//            exports : 'Backbone.Marionette'
//        }
    }
});

require([ 'app' ], function(Application){
   new Application();
//    console.log(Application);
});

