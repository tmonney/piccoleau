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
    'seo'
])

.config(function ($stateProvider, $urlRouterProvider, $locationProvider) {
    $urlRouterProvider.otherwise('/home');
    $locationProvider.html5Mode(false);
    $locationProvider.hashPrefix('!');
})

.controller('AppController', function ($scope, $state) {
    
    $scope.$on('$viewContentLoaded',function(event, viewConfig) {
        $scope.htmlReady();
    });


    $scope.pageTitle = function() {
        if($state.current.data) {
            return "Piccol'eau - " + $state.current.data.pageTitle;
        } else {
            return "Piccol'eau";
        }
    };
})

;
