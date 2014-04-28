angular.module("piccoleau.about", [
    'ui.router'
])

.config(function ($stateProvider) {
    $stateProvider.state('about', {
        url: '/about',
        views: {
            "main": {
                templateUrl: 'about/about.tpl.html'
            }
        },
        data:{ pageTitle: 'Coordonnées' }
    });
})

;
