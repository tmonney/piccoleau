angular.module("piccoleau.contact", [
    'ui.router'
])

.config(function ($stateProvider) {
    $stateProvider.state('contact', {
        url: '/contact',
        views: {
            "main": {
                controller: 'ContactCtrl',
                templateUrl: 'contact/contact.tpl.html'
            }
        },
        data:{ pageTitle: 'contact' }
    });
})

.controller('ContactCtrl', function($scope) {
    $scope.name = "";
    $scope.email = "";
    $scope.message = "";

    $scope.sendMessage = function(valid) {
        alert('Form was valid? ' + valid);
    };
})

;
