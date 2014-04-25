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
    
    var clear = function() {
        $scope.name = "";
        $scope.email = "";
        $scope.message = "";
    };

    var messageSent = function(form) {
        clear();
        $scope.status = 'sent';
        form.$setPristine();
    };

    var messageNotSent = function() {
        $scope.status = 'error';
    };

    $scope.sendMessage = function(form) {
        $http.post('assets/scripts/email.php', {
            'name': $scope.name,
            'email': $scope.email,
            'message': $scope.message
        }).success(function (data, status, headers, config) {
            messageSent(form);
        }).error(function (data, status, headers, config) {
            messageNotSent();
        });
    };

    $scope.status = 'unsent';

    clear();
})

;
