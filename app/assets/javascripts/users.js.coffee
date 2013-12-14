# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('#user_search').typeahead
    name: "user"
    remote: "/users/autocomplete?query=%QUERY"
    template: '<p>{{username}}</p>'
    engine:
      compile: (template) ->
        return {
          render: (ctx)->
            return template.replace(/\$(\w+)/g, (msg) -> ctx[msg.substring(1)])
        }