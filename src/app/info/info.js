(function(app) {

    app.config(function ($stateProvider) {
        $stateProvider.state('info', {
            url: '/info',
            views: {
                "main": {
                    templateUrl: 'info/info.tpl.html'
                }
            },
            data:{ pageTitle: 'Informations' }
        });
    });

}(angular.module("piccoleau.info", [
    'ui.router'
])));