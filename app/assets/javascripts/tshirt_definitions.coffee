# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $('#tshirt_definitions').DataTable({
    "language": {
      "url": "//cdn.datatables.net/plug-ins/1.10.10/i18n/Polish.json"
    }
  })
  $('#tshirt_definitions_id').select2 theme: 'bootstrap'

$(document).ready ->
  $('#tshirt_definition a.add_fields').data('association-insertion-position', 'before').data 'association-insertion-node', 'this'
  $('#tshirt_definition').bind 'cocoon:after-insert', ->
    $('#tshirt_definition_from_list').hide()
    $('#tshirt_definition a.add_fields').hide()
    return
  $('#tshirt_definition').bind 'cocoon:after-remove', ->
    $('#tshirt_definition_from_list').show()
    $('#tshirt_definition a.add_fields').show()
    return
  return
