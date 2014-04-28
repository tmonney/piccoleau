angular.module("piccoleau", [
    'piccoleau.home',
    'piccoleau.info',
    'piccoleau.about',
    'piccoleau.contact',
    'piccoleau.links',
    'templates-app',
    'templates-common',
    'ui.router.state',
    'ui.router',
])

.config(function ($stateProvider, $urlRouterProvider) {
    $urlRouterProvider.otherwise('/home');
})

.controller('AppController', function ($scope, $state) {
    $scope.pageTitle = function() {
        if($state.current.data) {
            return "Piccol'eau - " + $state.current.data.pageTitle;
        } else {
            return "Piccol'eau";
        }
    };
})

;
