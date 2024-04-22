$(function(){
  "use strict"

  $('#editable-document').on('click', function(e){
    e.preventDefault();
    $('#individual-record-report-form').attr('action', Routes.individual_record_report_editable_report_pt_br_path());
    $('#individual-record-report-form').submit();
  });

  $('#readonly-document').on('click', function(e){
    e.preventDefault();
    $('#individual-record-report-form').attr('action', Routes.individual_record_report_readonly_report_pt_br_path());
    $('#individual-record-report-form').submit();
  });
});
