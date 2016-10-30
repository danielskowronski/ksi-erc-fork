# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).ready ->
  $('#tshirt_issues').DataTable({
    "language": {
      "url": "//cdn.datatables.net/plug-ins/1.10.10/i18n/Polish.json"
    }
  })
  $('#tshirt_issues_id').select2 theme: 'bootstrap'

$(document).ready ->
  $('#tshirt_issue a.add_fields').data('association-insertion-position', 'before').data 'association-insertion-node', 'this'
  $('#tshirt_issue').bind 'cocoon:after-insert', ->
    $('#tshirt_issue_from_list').hide()
    $('#tshirt_issue a.add_fields').hide()
    return
  $('#tshirt_issue').bind 'cocoon:after-remove', ->
    $('#tshirt_issue_from_list').show()
    $('#tshirt_issue a.add_fields').show()
    return
  return
