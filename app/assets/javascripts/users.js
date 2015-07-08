//= require jquery-ui/datepicker
//= require dataTables/jquery.dataTables

$( "#datepicker" ).datepicker({
  dateFormat: "dd-mm-yy"
});
$("table#versions").dataTable({
  bJQueryUI: true,
  "oLanguage": { "sSearch": "" }
});
