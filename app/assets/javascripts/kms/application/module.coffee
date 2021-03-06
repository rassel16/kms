angular.module('KMS', ['ui.bootstrap', 'ui.router', 'ngCookies', 'restangular', 'templates', 'ui.tree', 'ui.codemirror', 'flow', 'ui.select', 'ngSanitize', 'ngCkeditor', 'toggle-switch', 'angular-loading-bar', 'angularjs-dropdown-multiselect', 'Alertify', 'xeditable', 'as.sortable'])

angular.module('KMS').config ['$httpProvider', '$locationProvider', 'RestangularProvider', 'flowFactoryProvider', 'cfpLoadingBarProvider', ($httpProvider, $locationProvider, RestangularProvider, flowFactoryProvider, cfpLoadingBarProvider) ->
  cfpLoadingBarProvider.includeSpinner = false
  $locationProvider.html5Mode(true)
  $httpProvider.defaults.withCredentials = true

  RestangularProvider.setBaseUrl('/kms')
  RestangularProvider.setRequestSuffix(".json")

  flowFactoryProvider.defaults =
    target: '/kms/assets.json'
    permanentErrors: [404, 500, 501]
    maxChunkRetries: 1
    chunkSize: 50*1024*1024
    chunkRetryInterval: 5000
    simultaneousUploads: 4
    testChunks: false
    fileParameterName: "asset[file]"
]
  .run ['$http', '$cookies', 'editableOptions', ($http, $cookies, editableOptions) ->
    $http.defaults.headers.common['X-XSRF-TOKEN'] = $cookies['XSRF-TOKEN']
    editableOptions.theme = 'bs3'
]
