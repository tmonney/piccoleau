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

.controller('ContactCtrl', function($scope, $http) {
    $scope.name = "";
    $scope.email = "";
    $scope.message = "";

    $scope.sendMessage = function(valid) {
        $http.post('assets/scripts/email.php', {
            'name': $scope.name,
            'email': $scope.email,
            'message': $scope.message
        }).success(function (data, status, headers, config) {
            alert('Success, status is ' + status);
        }).error(function (data, status, headers, config) {
            alert('Error, status is ' + status);
        });
    };
})

;
