angular.module("piccoleau.links", [
    'ui.router'
])

.config(function ($stateProvider) {
    $stateProvider.state('links', {
        url: '/links',
        views: {
            "main": {
                templateUrl: 'links/links.tpl.html'
            }
        },
        data:{ pageTitle: 'Liens' }
    });
})

;