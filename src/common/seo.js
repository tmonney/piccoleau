angular.module('seo', [])
    .run([
        '$rootScope',
        function($rootScope) {
            $rootScope.htmlReady = function() {
                $rootScope.$evalAsync(function() { // fire after $digest
                    setTimeout(function() { // fire after DOM rendering
                        if (typeof window.callPhantom == 'function') { 
                            window.callPhantom();
                        }
                    }, 0);
                });
            };
        }
    ]);
